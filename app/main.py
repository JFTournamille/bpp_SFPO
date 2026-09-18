import os
import re
import unicodedata
import uuid
from typing import Optional

from fastapi import FastAPI, HTTPException, UploadFile, File
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
from pydantic import BaseModel

from app.db import fetch_all, fetch_one, execute

UPLOAD_DIR = os.environ.get("UPLOAD_DIR", "/app/uploads")
os.makedirs(UPLOAD_DIR, exist_ok=True)

MAX_FILE_SIZE = 10 * 1024 * 1024  # 10 Mo

app = FastAPI(title="Auto-évaluation BPP - API")


# ------------------------------------------------------------------
# Référentiel (sections imbriquées / questions, avec sous-questions et dépendances)
# ------------------------------------------------------------------
@app.get("/api/questionnaire")
def get_questionnaire():
    sections = fetch_all("SELECT id, parent_id, title, level FROM sections ORDER BY sort_order")
    questions = fetch_all(
        "SELECT id, code, section_id, parent_question_id AS \"parentQuestionId\", question, "
        "ref, ref_text AS \"refText\", refs, "
        "depends_on_question_id AS \"dependsOnQuestionId\", depends_on_value AS \"dependsOnValue\" "
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
# Évaluations
# ------------------------------------------------------------------
@app.get("/api/evaluations/current")
def get_current_evaluation():
    row = fetch_one("SELECT id, label, created_at FROM evaluations ORDER BY id LIMIT 1")
    if row:
        return row
    execute("INSERT INTO evaluations (id, label) VALUES (1, 'Auto-évaluation BPP') ON CONFLICT (id) DO NOTHING")
    return fetch_one("SELECT id, label, created_at FROM evaluations WHERE id = 1")


def _ensure_evaluation(evaluation_id: int):
    row = fetch_one("SELECT id FROM evaluations WHERE id = %s", (evaluation_id,))
    if not row:
        raise HTTPException(status_code=404, detail="Évaluation introuvable")


RESPONSE_COLUMNS = (
    "question_id, reponse, comment_actif, commentaire, preuve_texte, "
    "preuve_fichier_nom, preuve_fichier_chemin, criticite, risque_maitrise, action"
)


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
    }


@app.get("/api/evaluations/{evaluation_id}/responses")
def get_responses(evaluation_id: int):
    _ensure_evaluation(evaluation_id)
    rows = fetch_all(f"SELECT {RESPONSE_COLUMNS} FROM responses WHERE evaluation_id = %s", (evaluation_id,))
    return {row["question_id"]: _row_to_json(row) for row in rows}


class ResponseUpdate(BaseModel):
    reponse: Optional[str] = None
    comment_actif: bool = False
    commentaire: str = ""
    preuve_texte: str = ""
    criticite: Optional[str] = None
    risque_maitrise: Optional[str] = None
    action: str = ""


ALLOWED_REPONSE = {None, "oui", "non", "partiel", "na"}
ALLOWED_CRITICITE = {None, "mineure", "majeure", "critique"}
ALLOWED_RISQUE = {None, "oui", "non"}


@app.put("/api/evaluations/{evaluation_id}/responses/{question_id}")
def upsert_response(evaluation_id: int, question_id: str, body: ResponseUpdate):
    _ensure_evaluation(evaluation_id)
    if not fetch_one("SELECT id FROM questions WHERE id = %s", (question_id,)):
        raise HTTPException(status_code=404, detail="Question inconnue")
    if body.reponse not in ALLOWED_REPONSE:
        raise HTTPException(status_code=422, detail="Réponse invalide")
    if body.criticite not in ALLOWED_CRITICITE:
        raise HTTPException(status_code=422, detail="Criticité invalide")
    if body.risque_maitrise not in ALLOWED_RISQUE:
        raise HTTPException(status_code=422, detail="Valeur de risque maîtrisé invalide")

    execute(
        """
        INSERT INTO responses (evaluation_id, question_id, reponse, comment_actif, commentaire,
                                preuve_texte, criticite, risque_maitrise, action, updated_at)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, now())
        ON CONFLICT (evaluation_id, question_id) DO UPDATE SET
            reponse = EXCLUDED.reponse,
            comment_actif = EXCLUDED.comment_actif,
            commentaire = EXCLUDED.commentaire,
            preuve_texte = EXCLUDED.preuve_texte,
            criticite = EXCLUDED.criticite,
            risque_maitrise = EXCLUDED.risque_maitrise,
            action = EXCLUDED.action,
            updated_at = now()
        """,
        (
            evaluation_id, question_id, body.reponse, body.comment_actif, body.commentaire,
            body.preuve_texte, body.criticite, body.risque_maitrise, body.action,
        ),
    )
    row = fetch_one(f"SELECT {RESPONSE_COLUMNS} FROM responses WHERE evaluation_id=%s AND question_id=%s",
                     (evaluation_id, question_id))
    return _row_to_json(row)


@app.delete("/api/evaluations/{evaluation_id}/responses")
def reset_responses(evaluation_id: int):
    _ensure_evaluation(evaluation_id)
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
async def upload_proof_file(evaluation_id: int, question_id: str, file: UploadFile = File(...)):
    _ensure_evaluation(evaluation_id)
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
        INSERT INTO responses (evaluation_id, question_id, preuve_fichier_nom, preuve_fichier_chemin, updated_at)
        VALUES (%s, %s, %s, %s, now())
        ON CONFLICT (evaluation_id, question_id) DO UPDATE SET
            preuve_fichier_nom = EXCLUDED.preuve_fichier_nom,
            preuve_fichier_chemin = EXCLUDED.preuve_fichier_chemin,
            updated_at = now()
        """,
        (evaluation_id, question_id, file.filename, rel_path),
    )
    return {"preuve_fichier_nom": file.filename, "preuve_fichier_url": f"/uploads/{rel_path}"}


@app.delete("/api/evaluations/{evaluation_id}/responses/{question_id}/file")
def delete_proof_file(evaluation_id: int, question_id: str):
    _ensure_evaluation(evaluation_id)
    row = fetch_one(
        "SELECT preuve_fichier_chemin FROM responses WHERE evaluation_id=%s AND question_id=%s",
        (evaluation_id, question_id),
    )
    if row and row["preuve_fichier_chemin"]:
        _delete_upload_file(row["preuve_fichier_chemin"])
    execute(
        "UPDATE responses SET preuve_fichier_nom=NULL, preuve_fichier_chemin=NULL, updated_at=now() "
        "WHERE evaluation_id=%s AND question_id=%s",
        (evaluation_id, question_id),
    )
    return {"ok": True}


@app.get("/api/health")
def health():
    fetch_one("SELECT 1 AS ok")
    return {"status": "ok"}


# ------------------------------------------------------------------
# Fichiers uploadés (preuves) + frontend statique
# ------------------------------------------------------------------
app.mount("/uploads", StaticFiles(directory=UPLOAD_DIR), name="uploads")
app.mount("/", StaticFiles(directory="static", html=True), name="static")
