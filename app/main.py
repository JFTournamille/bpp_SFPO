import os
import re
import unicodedata
import uuid
from typing import Optional

from fastapi import Depends, FastAPI, HTTPException, Request, Response, UploadFile, File
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.gzip import GZipMiddleware
from fastapi.responses import FileResponse
from pydantic import BaseModel

from app import auth, rgpd
from app.admin import router as admin_router
from app.auth import current_user, current_user_any, require_expert
from app.db import fetch_all, fetch_one, execute, execute_returning
from app.migrations import run_migrations

UPLOAD_DIR = os.environ.get("UPLOAD_DIR", "/app/uploads")
os.makedirs(UPLOAD_DIR, exist_ok=True)

MAX_FILE_SIZE = 10 * 1024 * 1024  # 10 Mo

app = FastAPI(title="Auto-évaluation BPP - API")
# le référentiel complet (/api/questionnaire) pèse ~1 Mo en JSON : ~110 Ko une fois compressé
app.add_middleware(GZipMiddleware, minimum_size=1000)

try:
    run_migrations()
    auth.ensure_bootstrap_expert()
except Exception:  # base injoignable au démarrage : l'API répondra en erreur, migrations retentées au prochain démarrage
    import logging
    logging.getLogger("uvicorn.error").exception("Migrations non appliquées")


# ------------------------------------------------------------------
# Référentiel (sections imbriquées / questions, avec sous-questions et dépendances)
# ------------------------------------------------------------------
@app.get("/api/refs")
def get_ref_texts(user: dict = Depends(current_user)):
    """Texte officiel de chaque référence BPP, pour l'info-bulle de chaque bulle de référence.
    Source : table ref_texts (importée du référentiel Excel, migration 008). À défaut, extrait
    stocké sur une question dont c'est la 1re référence (de préférence de premier niveau)."""
    rows = fetch_all(
        """
        SELECT DISTINCT ON (trim(ref)) trim(ref) AS ref, ref_text
        FROM questions
        WHERE ref IS NOT NULL AND trim(ref) <> '' AND ref_text IS NOT NULL AND trim(ref_text) <> ''
        ORDER BY trim(ref), (parent_question_id IS NOT NULL), length(ref_text) DESC, sort_order
        """
    )
    texts = {r["ref"]: r["ref_text"] for r in rows}
    texts.update({r["ref"]: r["texte"] for r in fetch_all("SELECT ref, texte FROM ref_texts")})
    return texts


@app.get("/api/questionnaire")
def get_questionnaire(user: dict = Depends(current_user)):
    sections = fetch_all("SELECT id, parent_id, title, level FROM sections ORDER BY sort_order")
    questions = fetch_all(
        "SELECT id, code, section_id, parent_question_id AS \"parentQuestionId\", question, "
        "ref, ref_text AS \"refText\", refs, "
        "depends_on_question_id AS \"dependsOnQuestionId\", depends_on_value AS \"dependsOnValue\", "
        "is_part AS \"isPart\", severite "
        "FROM questions ORDER BY sort_order"
    )

    q_by_id = {}
    for q in questions:
        q["refs"] = [r.strip() for r in (q["refs"] or "").split(",") if r.strip()]
        q["children"] = []
        q_by_id[q["id"]] = q

    top_by_section = {}
    for q in questions:
        parent_id = q.pop("parentQuestionId")
        section_id = q.pop("section_id")
        if parent_id and parent_id in q_by_id:
            q_by_id[parent_id]["children"].append(q)
        else:
            top_by_section.setdefault(section_id, []).append(q)

    children_by_parent = {}
    for s in sections:
        s["questions"] = top_by_section.get(s["id"], [])
        children_by_parent.setdefault(s["parent_id"], []).append(s)

    for s in sections:
        s["sections"] = children_by_parent.get(s["id"], [])
        s.pop("parent_id")

    return children_by_parent.get(None, [])


# ------------------------------------------------------------------
# Authentification
# ------------------------------------------------------------------
class LoginBody(BaseModel):
    login: str
    password: str


class PasswordChange(BaseModel):
    current_password: str
    new_password: str


def _me_json(user: dict):
    return {
        "id": user["id"], "login": user["login"], "role": user["role"], "nom": user["nom"],
        "centre_id": user["centre_id"], "centre_libelle": user["centre_libelle"],
        "must_change_password": user["must_change_password"],
        "must_acknowledge_rgpd": auth.must_acknowledge_rgpd(user),
    }


@app.post("/api/auth/login")
def login(body: LoginBody, request: Request, response: Response):
    user = auth.authenticate(body.login, body.password)
    auth.open_session(response, request, user["id"])
    me = fetch_one(
        "SELECT u.id, u.login, u.role, u.nom, u.centre_id, u.must_change_password, u.rgpd_version, "
        "c.libelle AS centre_libelle FROM users u LEFT JOIN centres c ON c.id = u.centre_id WHERE u.id = %s", (user["id"],))
    return _me_json(me)


@app.post("/api/auth/logout")
def logout(request: Request, response: Response):
    auth.close_session(response, request)
    return {"ok": True}


@app.get("/api/auth/me")
def me(user: dict = Depends(current_user_any)):
    return _me_json(user)


@app.post("/api/auth/password")
def change_password(body: PasswordChange, user: dict = Depends(current_user_any)):
    row = fetch_one("SELECT password_hash FROM users WHERE id = %s", (user["id"],))
    if not auth.verify_password(body.current_password, row["password_hash"]):
        raise HTTPException(status_code=403, detail="Mot de passe actuel incorrect")
    auth.check_password_policy(body.new_password)
    if body.new_password == body.current_password:
        raise HTTPException(status_code=422, detail="Le nouveau mot de passe doit être différent de l'actuel")
    execute("UPDATE users SET password_hash = %s, must_change_password = FALSE WHERE id = %s",
            (auth.hash_password(body.new_password), user["id"]))
    return {"ok": True}


class RgpdAck(BaseModel):
    version: str


@app.get("/api/rgpd")
def get_rgpd_notice():
    """Mention d'information RGPD en vigueur (consultable sans connexion)."""
    return rgpd.notice()


@app.post("/api/auth/rgpd")
def acknowledge_rgpd(body: RgpdAck, user: dict = Depends(current_user_any)):
    """Enregistre sur le compte l'acquittement de la mention (version + horodatage)."""
    if body.version != rgpd.RGPD_VERSION:
        # la mention a changé entre l'affichage et la validation : la faire relire
        raise HTTPException(status_code=409, detail="La mention a été mise à jour, merci de la relire")
    execute("UPDATE users SET rgpd_version = %s, rgpd_acknowledged_at = now() WHERE id = %s",
            (rgpd.RGPD_VERSION, user["id"]))
    execute("INSERT INTO rgpd_acknowledgements (user_id, version) VALUES (%s, %s)", (user["id"], rgpd.RGPD_VERSION))
    return {"ok": True}


# ------------------------------------------------------------------
# Évaluations (une ou plusieurs campagnes par centre)
# ------------------------------------------------------------------
EVAL_SELECT = (
    "SELECT e.id, e.label, e.created_at, e.status, e.completed_at, e.centre_id, c.libelle AS centre_libelle "
    "FROM evaluations e LEFT JOIN centres c ON c.id = e.centre_id "
)


def _get_evaluation(evaluation_id: int, user: dict, write: bool = False) -> dict:
    """Contrôle d'accès : un membre n'accède qu'aux évaluations de son centre, et ne peut plus
    les modifier une fois terminées ; un expert accède à tout (y compris pour l'expertise après clôture)."""
    ev = fetch_one(EVAL_SELECT + "WHERE e.id = %s", (evaluation_id,))
    if not ev:
        raise HTTPException(status_code=404, detail="Évaluation introuvable")
    if user["role"] != "expert":
        if ev["centre_id"] is None or ev["centre_id"] != user["centre_id"]:
            raise HTTPException(status_code=404, detail="Évaluation introuvable")
        if write and ev["status"] == "termine":
            raise HTTPException(status_code=409, detail="Questionnaire terminé : modification impossible")
    return ev


@app.get("/api/evaluations/current")
def get_current_evaluation(user: dict = Depends(current_user)):
    """Questionnaire de travail du membre : la dernière campagne de son centre (créée si besoin)."""
    if user["role"] == "expert":
        raise HTTPException(status_code=400, detail="Un expert ouvre un questionnaire depuis le tableau de bord")
    if not user["centre_id"]:
        raise HTTPException(status_code=409, detail="Votre compte n'est rattaché à aucun centre. Contactez un expert SFPO.")
    ev = fetch_one(EVAL_SELECT + "WHERE e.centre_id = %s ORDER BY e.id DESC LIMIT 1", (user["centre_id"],))
    if ev:
        return ev
    execute("INSERT INTO evaluations (label, centre_id) VALUES ('Auto-évaluation BPP', %s)", (user["centre_id"],))
    return fetch_one(EVAL_SELECT + "WHERE e.centre_id = %s ORDER BY e.id DESC LIMIT 1", (user["centre_id"],))


@app.get("/api/evaluations/{evaluation_id}")
def get_evaluation(evaluation_id: int, user: dict = Depends(current_user)):
    return _get_evaluation(evaluation_id, user)


@app.post("/api/evaluations/{evaluation_id}/complete")
def complete_evaluation(evaluation_id: int, user: dict = Depends(current_user)):
    _get_evaluation(evaluation_id, user, write=True)
    execute("UPDATE evaluations SET status = 'termine', completed_at = now() WHERE id = %s", (evaluation_id,))
    return _get_evaluation(evaluation_id, user)


@app.post("/api/evaluations/{evaluation_id}/reopen")
def reopen_evaluation(evaluation_id: int, user: dict = Depends(require_expert)):
    _get_evaluation(evaluation_id, user)
    execute("UPDATE evaluations SET status = 'en_cours', completed_at = NULL WHERE id = %s", (evaluation_id,))
    return _get_evaluation(evaluation_id, user)


RESPONSE_COLUMNS = (
    "r.question_id, r.reponse, r.comment_actif, r.commentaire, r.preuve_texte, "
    "r.preuve_fichier_nom, r.preuve_fichier_chemin, r.criticite, r.risque_maitrise, r.action, "
    "r.version, r.updated_at, r.answered_in, COALESCE(NULLIF(u.nom, ''), u.login) AS updated_by_nom"
)
RESPONSE_FROM = "FROM responses r LEFT JOIN users u ON u.id = r.updated_by "


def _fetch_response(evaluation_id: int, question_id: str):
    return fetch_one(f"SELECT {RESPONSE_COLUMNS} {RESPONSE_FROM} WHERE r.evaluation_id=%s AND r.question_id=%s",
                     (evaluation_id, question_id))


def _row_to_json(row):
    return {
        "reponse": row["reponse"],
        "comment_actif": row["comment_actif"],
        "commentaire": row["commentaire"],
        "preuve_texte": row["preuve_texte"],
        "preuve_fichier_nom": row["preuve_fichier_nom"],
        "preuve_fichier_url": (f"/uploads/{row['preuve_fichier_chemin']}" if row["preuve_fichier_chemin"] else None),
        "criticite": row["criticite"],
        "risque_maitrise": row["risque_maitrise"],
        "action": row["action"],
        # travail à plusieurs : version (détection des modifications concurrentes) et dernier auteur
        "version": row["version"],
        "answered_in": row["answered_in"],
        "updated_at": row["updated_at"].isoformat() if row["updated_at"] else None,
        "updated_by_nom": row["updated_by_nom"],
    }


@app.get("/api/evaluations/{evaluation_id}/responses")
def get_responses(evaluation_id: int, user: dict = Depends(current_user)):
    _get_evaluation(evaluation_id, user)
    rows = fetch_all(f"SELECT {RESPONSE_COLUMNS} {RESPONSE_FROM} WHERE r.evaluation_id = %s", (evaluation_id,))
    return {row["question_id"]: _row_to_json(row) for row in rows}


class ResponseUpdate(BaseModel):
    reponse: Optional[str] = None
    comment_actif: bool = False
    commentaire: str = ""
    preuve_texte: str = ""
    criticite: Optional[str] = None
    risque_maitrise: Optional[str] = None
    action: str = ""
    # version de la réponse sur laquelle l'utilisateur travaillait (None : pas de contrôle)
    base_version: Optional[int] = None
    # chapitre BPP où la question est renseignée (fixé à la 1re saisie, conservé ensuite)
    answered_in: Optional[str] = None


ALLOWED_REPONSE = {None, "oui", "non", "partiel", "na"}
ALLOWED_CRITICITE = {None, "mineure", "majeure", "critique"}
ALLOWED_RISQUE = {None, "oui", "non"}


@app.put("/api/evaluations/{evaluation_id}/responses/{question_id}")
def upsert_response(evaluation_id: int, question_id: str, body: ResponseUpdate,
                    user: dict = Depends(current_user)):
    _get_evaluation(evaluation_id, user, write=True)
    if not fetch_one("SELECT id FROM questions WHERE id = %s", (question_id,)):
        raise HTTPException(status_code=404, detail="Question inconnue")
    if body.reponse not in ALLOWED_REPONSE:
        raise HTTPException(status_code=422, detail="Réponse invalide")
    if body.criticite not in ALLOWED_CRITICITE:
        raise HTTPException(status_code=422, detail="Criticité invalide")
    if body.risque_maitrise not in ALLOWED_RISQUE:
        raise HTTPException(status_code=422, detail="Valeur de risque maîtrisé invalide")
    if body.answered_in is not None and not re.fullmatch(r"\d|LD\d|autre", body.answered_in):
        raise HTTPException(status_code=422, detail="Chapitre invalide")

    if user["role"] != "expert":
        # criticité / risque / action relèvent de l'expertise : un membre ne peut pas les modifier
        prev = fetch_one("SELECT criticite, risque_maitrise, action FROM responses "
                         "WHERE evaluation_id=%s AND question_id=%s", (evaluation_id, question_id))
        body.criticite = prev["criticite"] if prev else None
        body.risque_maitrise = prev["risque_maitrise"] if prev else None
        body.action = prev["action"] if prev else ""

    # Mise à jour refusée si quelqu'un d'autre a modifié la réponse depuis que l'utilisateur l'a chargée
    # (plusieurs membres d'un même centre peuvent travailler en même temps sur le questionnaire).
    saved = execute_returning(
        """
        INSERT INTO responses (evaluation_id, question_id, reponse, comment_actif, commentaire,
                                preuve_texte, criticite, risque_maitrise, action, updated_at, updated_by, version,
                                answered_in)
        VALUES (%(e)s, %(q)s, %(rep)s, %(ca)s, %(com)s, %(pt)s, %(crit)s, %(risk)s, %(act)s, now(), %(uid)s, 1,
                %(ain)s)
        ON CONFLICT (evaluation_id, question_id) DO UPDATE SET
            reponse = EXCLUDED.reponse,
            comment_actif = EXCLUDED.comment_actif,
            commentaire = EXCLUDED.commentaire,
            preuve_texte = EXCLUDED.preuve_texte,
            criticite = EXCLUDED.criticite,
            risque_maitrise = EXCLUDED.risque_maitrise,
            action = EXCLUDED.action,
            updated_at = now(),
            updated_by = EXCLUDED.updated_by,
            version = responses.version + 1,
            answered_in = COALESCE(responses.answered_in, EXCLUDED.answered_in)
        WHERE %(base)s::int IS NULL OR responses.version = %(base)s::int
        RETURNING version
        """,
        {
            "e": evaluation_id, "q": question_id, "rep": body.reponse, "ca": body.comment_actif,
            "com": body.commentaire, "pt": body.preuve_texte, "crit": body.criticite,
            "risk": body.risque_maitrise, "act": body.action, "uid": user["id"], "base": body.base_version,
            "ain": body.answered_in,
        },
    )
    row = _fetch_response(evaluation_id, question_id)
    if not saved:
        raise HTTPException(status_code=409, detail={
            "message": "Réponse modifiée entre-temps par une autre personne",
            "current": _row_to_json(row),
        })
    return _row_to_json(row)


@app.delete("/api/evaluations/{evaluation_id}/responses")
def reset_responses(evaluation_id: int, user: dict = Depends(require_expert)):
    _get_evaluation(evaluation_id, user)
    rows = fetch_all(
        "SELECT preuve_fichier_chemin FROM responses WHERE evaluation_id = %s AND preuve_fichier_chemin IS NOT NULL",
        (evaluation_id,),
    )
    for row in rows:
        _delete_upload_file(row["preuve_fichier_chemin"])
    execute("DELETE FROM responses WHERE evaluation_id = %s", (evaluation_id,))
    return {"ok": True}


def _safe_filename(name: str) -> str:
    name = unicodedata.normalize("NFKD", name).encode("ascii", "ignore").decode("ascii")
    name = re.sub(r"[^A-Za-z0-9._-]+", "_", name).strip("_")
    return name or "fichier"


def _delete_upload_file(rel_path: str):
    full_path = os.path.join(UPLOAD_DIR, rel_path)
    try:
        if os.path.commonpath([os.path.abspath(full_path), os.path.abspath(UPLOAD_DIR)]) == os.path.abspath(UPLOAD_DIR):
            if os.path.isfile(full_path):
                os.remove(full_path)
    except (OSError, ValueError):
        pass


@app.post("/api/evaluations/{evaluation_id}/responses/{question_id}/file")
async def upload_proof_file(evaluation_id: int, question_id: str, file: UploadFile = File(...),
                            user: dict = Depends(current_user)):
    _get_evaluation(evaluation_id, user, write=True)
    if not fetch_one("SELECT id FROM questions WHERE id = %s", (question_id,)):
        raise HTTPException(status_code=404, detail="Question inconnue")

    content = await file.read()
    if len(content) > MAX_FILE_SIZE:
        raise HTTPException(status_code=413, detail="Fichier trop volumineux (max 10 Mo)")

    row = fetch_one(
        "SELECT preuve_fichier_chemin FROM responses WHERE evaluation_id=%s AND question_id=%s",
        (evaluation_id, question_id),
    )
    if row and row["preuve_fichier_chemin"]:
        _delete_upload_file(row["preuve_fichier_chemin"])

    safe_name = _safe_filename(file.filename or "fichier")
    rel_dir = f"{evaluation_id}/{question_id}"
    os.makedirs(os.path.join(UPLOAD_DIR, rel_dir), exist_ok=True)
    unique_name = f"{uuid.uuid4().hex[:8]}_{safe_name}"
    rel_path = f"{rel_dir}/{unique_name}"
    with open(os.path.join(UPLOAD_DIR, rel_path), "wb") as f:
        f.write(content)

    execute(
        """
        INSERT INTO responses (evaluation_id, question_id, preuve_fichier_nom, preuve_fichier_chemin,
                               updated_at, updated_by, version)
        VALUES (%s, %s, %s, %s, now(), %s, 1)
        ON CONFLICT (evaluation_id, question_id) DO UPDATE SET
            preuve_fichier_nom = EXCLUDED.preuve_fichier_nom,
            preuve_fichier_chemin = EXCLUDED.preuve_fichier_chemin,
            updated_at = now(),
            updated_by = EXCLUDED.updated_by,
            version = responses.version + 1
        """,
        (evaluation_id, question_id, file.filename, rel_path, user["id"]),
    )
    return _row_to_json(_fetch_response(evaluation_id, question_id))


@app.delete("/api/evaluations/{evaluation_id}/responses/{question_id}/file")
def delete_proof_file(evaluation_id: int, question_id: str, user: dict = Depends(current_user)):
    _get_evaluation(evaluation_id, user, write=True)
    row = fetch_one(
        "SELECT preuve_fichier_chemin FROM responses WHERE evaluation_id=%s AND question_id=%s",
        (evaluation_id, question_id),
    )
    if row and row["preuve_fichier_chemin"]:
        _delete_upload_file(row["preuve_fichier_chemin"])
    execute(
        "UPDATE responses SET preuve_fichier_nom=NULL, preuve_fichier_chemin=NULL, updated_at=now(), "
        "updated_by=%s, version=version+1 WHERE evaluation_id=%s AND question_id=%s",
        (user["id"], evaluation_id, question_id),
    )
    row = _fetch_response(evaluation_id, question_id)
    return _row_to_json(row) if row else {"ok": True}


@app.get("/api/health")
def health():
    fetch_one("SELECT 1 AS ok")
    return {"status": "ok"}


# ------------------------------------------------------------------
# Fichiers uploadés (preuves) — servis uniquement aux personnes ayant accès à l'évaluation
# ------------------------------------------------------------------
@app.get("/uploads/{evaluation_id}/{rel_path:path}")
def get_upload(evaluation_id: int, rel_path: str, user: dict = Depends(current_user)):
    _get_evaluation(evaluation_id, user)
    base = os.path.abspath(os.path.join(UPLOAD_DIR, str(evaluation_id)))
    full_path = os.path.abspath(os.path.join(base, rel_path))
    if os.path.commonpath([full_path, base]) != base or not os.path.isfile(full_path):
        raise HTTPException(status_code=404, detail="Fichier introuvable")
    return FileResponse(full_path)


app.include_router(admin_router)

# ------------------------------------------------------------------
# Frontend statique
# ------------------------------------------------------------------
app.mount("/", StaticFiles(directory="static", html=True), name="static")
