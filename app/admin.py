"""Espace expert : tableau de bord des questionnaires, gestion des centres et des comptes."""
import os
import shutil
from typing import List, Optional

from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel

from app import auth
from app.rgpd import ACCOUNT_RETENTION_YEARS, EVALUATION_RETENTION_YEARS
from app.auth import require_expert
from app.db import execute, execute_returning, fetch_all, fetch_one

router = APIRouter(prefix="/api/admin", dependencies=[Depends(require_expert)])


# ------------------------------------------------------------------
# Tableau de bord
# ------------------------------------------------------------------
# Questions « de base » : ni elles ni leurs questions chapeau n'ont de condition d'affichage
# (même définition que le compteur de progression de l'interface).
BASE_QUESTIONS_SQL = """
WITH RECURSIVE anc AS (
  SELECT id, depends_on_question_id AS dep, parent_question_id AS parent FROM questions
  UNION ALL
  SELECT anc.id, q.depends_on_question_id, q.parent_question_id
  FROM anc JOIN questions q ON q.id = anc.parent
)
SELECT COUNT(*) AS n FROM questions WHERE id NOT IN (SELECT id FROM anc WHERE dep IS NOT NULL)
"""


@router.get("/dashboard")
def dashboard():
    base = fetch_one(BASE_QUESTIONS_SQL)["n"]
    rows = fetch_all(
        """
        SELECT e.id, e.label, e.status, e.created_at, e.completed_at, e.centre_id, c.libelle AS centre_libelle,
               COUNT(r.question_id) FILTER (WHERE r.reponse IS NOT NULL)            AS answered,
               COUNT(r.question_id) FILTER (WHERE r.reponse = 'non')                AS non_conformes,
               COUNT(r.question_id) FILTER (WHERE r.reponse = 'non' AND r.criticite IS NULL) AS a_qualifier,
               MAX(r.updated_at) AS last_activity,
               (SELECT COUNT(*) FROM users u WHERE u.centre_id = e.centre_id AND u.role = 'membre' AND u.active) AS membres
        FROM evaluations e
        LEFT JOIN centres c ON c.id = e.centre_id
        LEFT JOIN responses r ON r.evaluation_id = e.id
        GROUP BY e.id, c.libelle
        ORDER BY e.status, COALESCE(MAX(r.updated_at), e.created_at) DESC
        """
    )
    return {"base_questions": base, "evaluations": rows}


class EvaluationCreate(BaseModel):
    centre_id: int
    label: str = "Auto-évaluation BPP"


class EvaluationUpdate(BaseModel):
    centre_id: Optional[int] = None
    label: Optional[str] = None


def _ensure_centre(centre_id: int):
    if not fetch_one("SELECT id FROM centres WHERE id = %s", (centre_id,)):
        raise HTTPException(status_code=404, detail="Centre introuvable")


@router.post("/evaluations")
def create_evaluation(body: EvaluationCreate):
    """Nouvelle campagne pour un centre : devient le questionnaire de travail de ses membres."""
    _ensure_centre(body.centre_id)
    execute("INSERT INTO evaluations (label, centre_id) VALUES (%s, %s)",
            (body.label.strip() or "Auto-évaluation BPP", body.centre_id))
    return fetch_one("SELECT id FROM evaluations WHERE centre_id = %s ORDER BY id DESC LIMIT 1", (body.centre_id,))


@router.patch("/evaluations/{evaluation_id}")
def update_evaluation(evaluation_id: int, body: EvaluationUpdate):
    if not fetch_one("SELECT id FROM evaluations WHERE id = %s", (evaluation_id,)):
        raise HTTPException(status_code=404, detail="Évaluation introuvable")
    if body.centre_id is not None:
        _ensure_centre(body.centre_id)
        execute("UPDATE evaluations SET centre_id = %s WHERE id = %s", (body.centre_id, evaluation_id))
    if body.label is not None and body.label.strip():
        execute("UPDATE evaluations SET label = %s WHERE id = %s", (body.label.strip(), evaluation_id))
    return {"ok": True}


# ------------------------------------------------------------------
# Centres
# ------------------------------------------------------------------
class CentreBody(BaseModel):
    libelle: str
    finess: Optional[str] = None


@router.get("/centres")
def list_centres(q: str = "", actifs: bool = False, limit: int = 50):
    """Recherche dans le référentiel (≈1300 centres). `actifs` : seulement les centres ayant
    au moins un membre ou un questionnaire."""
    limit = max(1, min(limit, 200))
    where, params = [], []
    for word in q.split():
        where.append("(unaccent_lower(c.libelle) LIKE unaccent_lower(%s) OR c.finess LIKE %s)")
        params += [f"%{word}%", f"%{word}%"]
    having = "HAVING COUNT(DISTINCT u.id) > 0 OR COUNT(DISTINCT e.id) > 0" if actifs else ""
    rows = fetch_all(
        f"""
        SELECT c.id, c.libelle, c.finess,
               COUNT(DISTINCT u.id) AS membres, COUNT(DISTINCT e.id) AS questionnaires
        FROM centres c
        LEFT JOIN users u ON u.centre_id = c.id AND u.role = 'membre' AND u.active
        LEFT JOIN evaluations e ON e.centre_id = c.id
        {"WHERE " + " AND ".join(where) if where else ""}
        GROUP BY c.id {having}
        ORDER BY c.libelle
        LIMIT %s
        """,
        (*params, limit),
    )
    return rows


def _clean_centre(body: CentreBody):
    libelle = body.libelle.strip()
    if not libelle:
        raise HTTPException(status_code=422, detail="Libellé obligatoire")
    finess = (body.finess or "").strip() or None
    return libelle, finess


@router.post("/centres")
def create_centre(body: CentreBody):
    libelle, finess = _clean_centre(body)
    if fetch_one("SELECT id FROM centres WHERE lower(libelle) = lower(%s)", (libelle,)):
        raise HTTPException(status_code=409, detail="Un centre porte déjà ce libellé")
    return execute_returning("INSERT INTO centres (libelle, finess) VALUES (%s, %s) RETURNING id, libelle, finess",
                            (libelle, finess))


@router.patch("/centres/{centre_id}")
def update_centre(centre_id: int, body: CentreBody):
    _ensure_centre(centre_id)
    libelle, finess = _clean_centre(body)
    execute("UPDATE centres SET libelle = %s, finess = %s WHERE id = %s", (libelle, finess, centre_id))
    return {"ok": True}


# ------------------------------------------------------------------
# Comptes (experts / membres)
# ------------------------------------------------------------------
class UserCreate(BaseModel):
    login: str
    role: str = "membre"
    nom: str = ""
    email: str = ""
    centre_id: Optional[int] = None


class UserUpdate(BaseModel):
    nom: Optional[str] = None
    email: Optional[str] = None
    role: Optional[str] = None
    centre_id: Optional[int] = None
    detach_centre: bool = False
    active: Optional[bool] = None


@router.get("/users")
def list_users():
    return fetch_all(
        "SELECT u.id, u.login, u.role, u.nom, u.email, u.centre_id, c.libelle AS centre_libelle, "
        "u.active, u.must_change_password, u.created_at, u.last_login_at, "
        "u.rgpd_version, u.rgpd_acknowledged_at "
        "FROM users u LEFT JOIN centres c ON c.id = u.centre_id ORDER BY u.role DESC, u.login"
    )


@router.post("/users")
def create_user(body: UserCreate):
    login = body.login.strip().lower()
    if not login or " " in login:
        raise HTTPException(status_code=422, detail="Identifiant invalide (pas d'espace)")
    if body.role not in ("expert", "membre"):
        raise HTTPException(status_code=422, detail="Rôle invalide")
    if body.centre_id is not None:
        _ensure_centre(body.centre_id)
    if fetch_one("SELECT id FROM users WHERE login = %s", (login,)):
        raise HTTPException(status_code=409, detail="Identifiant déjà utilisé")
    password = auth.generate_password()
    execute(
        "INSERT INTO users (login, password_hash, role, nom, email, centre_id, must_change_password) "
        "VALUES (%s, %s, %s, %s, %s, %s, TRUE)",
        (login, auth.hash_password(password), body.role, body.nom.strip(), body.email.strip(), body.centre_id),
    )
    # le mot de passe provisoire n'est renvoyé qu'une fois, pour être transmis à la personne
    return {"login": login, "password": password}


@router.patch("/users/{user_id}")
def update_user(user_id: int, body: UserUpdate, me: dict = Depends(require_expert)):
    if not fetch_one("SELECT id FROM users WHERE id = %s", (user_id,)):
        raise HTTPException(status_code=404, detail="Compte introuvable")
    if user_id == me["id"] and (body.active is False or body.role == "membre"):
        raise HTTPException(status_code=409, detail="Vous ne pouvez pas désactiver ni rétrograder votre propre compte")
    if body.role is not None and body.role not in ("expert", "membre"):
        raise HTTPException(status_code=422, detail="Rôle invalide")
    if body.centre_id is not None:
        _ensure_centre(body.centre_id)
    sets, params = [], []
    for col in ("nom", "email", "role", "active"):
        val = getattr(body, col)
        if val is not None:
            sets.append(f"{col} = %s")
            params.append(val.strip() if isinstance(val, str) else val)
    if body.centre_id is not None:
        sets.append("centre_id = %s")
        params.append(body.centre_id)
    elif body.detach_centre:
        sets.append("centre_id = NULL")
    if sets:
        execute(f"UPDATE users SET {', '.join(sets)} WHERE id = %s", (*params, user_id))
    if body.active is False:
        execute("DELETE FROM sessions WHERE user_id = %s", (user_id,))
    return {"ok": True}


@router.post("/users/{user_id}/reset-password")
def reset_password(user_id: int):
    row = fetch_one("SELECT login FROM users WHERE id = %s", (user_id,))
    if not row:
        raise HTTPException(status_code=404, detail="Compte introuvable")
    password = auth.generate_password()
    execute("UPDATE users SET password_hash = %s, must_change_password = TRUE WHERE id = %s",
            (auth.hash_password(password), user_id))
    execute("DELETE FROM sessions WHERE user_id = %s", (user_id,))
    return {"login": row["login"], "password": password}



@router.get("/users/{user_id}/rgpd")
def user_rgpd_history(user_id: int):
    return fetch_all(
        "SELECT version, acknowledged_at FROM rgpd_acknowledgements WHERE user_id = %s ORDER BY acknowledged_at DESC",
        (user_id,),
    )


# ------------------------------------------------------------------
# Purge RGPD : application des durées de conservation (aperçu puis confirmation par un expert)
# ------------------------------------------------------------------
UPLOAD_DIR = os.environ.get("UPLOAD_DIR", "/app/uploads")

# comptes sans connexion depuis la durée de conservation (date de création si jamais connecté) ;
# le compte de l'expert qui lance la purge n'est jamais concerné
PURGEABLE_USERS_SQL = (
    "SELECT u.id, u.login, u.nom, u.role, c.libelle AS centre_libelle, u.created_at, u.last_login_at "
    "FROM users u LEFT JOIN centres c ON c.id = u.centre_id "
    "WHERE COALESCE(u.last_login_at, u.created_at) < now() - make_interval(years => %s) AND u.id <> %s "
)
# auto-évaluations clôturées depuis la durée de conservation
PURGEABLE_EVALS_SQL = (
    "SELECT e.id, e.label, c.libelle AS centre_libelle, e.completed_at "
    "FROM evaluations e LEFT JOIN centres c ON c.id = e.centre_id "
    "WHERE e.status = 'termine' AND e.completed_at < now() - make_interval(years => %s) "
)


@router.get("/purge")
def purge_preview(me: dict = Depends(require_expert)):
    return {
        "account_years": ACCOUNT_RETENTION_YEARS,
        "evaluation_years": EVALUATION_RETENTION_YEARS,
        "users": fetch_all(PURGEABLE_USERS_SQL + "ORDER BY u.login", (ACCOUNT_RETENTION_YEARS, me["id"])),
        "evaluations": fetch_all(PURGEABLE_EVALS_SQL + "ORDER BY e.completed_at", (EVALUATION_RETENTION_YEARS,)),
    }


class PurgeBody(BaseModel):
    user_ids: List[int] = []
    evaluation_ids: List[int] = []


@router.post("/purge")
def purge(body: PurgeBody, me: dict = Depends(require_expert)):
    """Supprime les éléments confirmés depuis l'aperçu, après avoir revérifié qu'ils sont toujours éligibles."""
    users = [r["id"] for r in fetch_all(PURGEABLE_USERS_SQL, (ACCOUNT_RETENTION_YEARS, me["id"]))
             if r["id"] in set(body.user_ids)]
    evals = [r["id"] for r in fetch_all(PURGEABLE_EVALS_SQL, (EVALUATION_RETENTION_YEARS,))
             if r["id"] in set(body.evaluation_ids)]
    for evaluation_id in evals:
        # réponses supprimées en cascade ; fichiers de preuve rangés sous UPLOAD_DIR/<evaluation_id>/
        execute("DELETE FROM evaluations WHERE id = %s", (evaluation_id,))
        shutil.rmtree(os.path.join(UPLOAD_DIR, str(evaluation_id)), ignore_errors=True)
    for user_id in users:
        # sessions et historique d'acquittement supprimés en cascade
        execute("DELETE FROM users WHERE id = %s", (user_id,))
    return {"users_deleted": len(users), "evaluations_deleted": len(evals)}
