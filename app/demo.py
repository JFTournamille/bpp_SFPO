"""Données de démonstration : remplit un questionnaire vierge de façon aléatoire mais réaliste.

Réservé aux experts (bouton « Remplir (démo) » du tableau de bord, questionnaire sans aucune
réponse). Les réponses respectent les conditions d'affichage du référentiel ; le niveau de
conformité varie d'une thématique à l'autre pour que les statistiques soient parlantes. Une
partie des questions reçoit un commentaire, une référence de preuve et, plus rarement, une
pièce jointe PDF générée ; les non-conformités et réponses partielles sont expertisées
(criticité, risque maîtrisé, action corrective).
"""
import os
import random
import uuid
from datetime import date

from app.db import fetch_all, get_cursor

COMMENTAIRES = [
    "Procédure en cours de révision, validation prévue au prochain comité qualité.",
    "Vérifié lors de l'audit interne du dernier trimestre.",
    "Pratique en place mais traçabilité encore partielle sur l'équipe de week-end.",
    "Point discuté avec le pharmacien responsable de l'URC.",
    "Document existant, diffusion à compléter auprès des préparateurs.",
    "Conforme depuis la mise en place du logiciel de production.",
    "Écart ponctuel constaté, analyse des causes réalisée.",
    "À revoir lors de la prochaine requalification des isolateurs.",
    "Organisation différente selon les plages horaires.",
    "Formation planifiée pour les nouveaux arrivants.",
]
PREUVES = [
    "PR-QUA-{n:03d} v{v} — procédure qualité",
    "MO-URC-{n:03d} — mode opératoire",
    "ENR-{n:03d} — registre de suivi {y}",
    "Rapport d'audit interne {y}",
    "Certificat de qualification ZAC {y}",
    "Compte rendu du comité qualité du {d}",
    "Grille d'habilitation préparateur {y}",
    "Fiche de poste PH / préparateur v{v}",
    "Plan de formation {y}",
    "Rapport de contrôle microbiologique {y}",
]
ACTIONS = [
    "Rédiger et valider la procédure manquante",
    "Former l'ensemble de l'équipe et tracer les habilitations",
    "Mettre à jour le document et le diffuser",
    "Planifier un audit de suivi à 6 mois",
    "Mettre en place un enregistrement systématique",
    "Requalifier l'équipement concerné",
    "Intégrer le point au plan d'actions qualité annuel",
    "Revoir l'analyse de risque et définir des mesures de maîtrise",
    "Désigner un référent et formaliser ses missions",
    "Renforcer le double contrôle sur ce point",
]
FICHIERS = ["procedure", "enregistrement", "rapport_audit", "certificat", "compte_rendu", "grille_habilitation"]


def _pdf(lines):
    """PDF minimal (une page, Helvetica) — suffisant pour une pièce jointe de démonstration."""
    def esc(t):
        t = t.replace("—", "-").replace("–", "-").replace("’", "'").replace("œ", "oe")
        t = t.encode("latin-1", "replace").decode("latin-1")
        return t.replace("\\", "\\\\").replace("(", "\\(").replace(")", "\\)")
    stream = "BT /F1 16 Tf 60 780 Td (" + esc(lines[0]) + ") Tj /F1 11 Tf"
    for ln in lines[1:]:
        stream += " 0 -22 Td (" + esc(ln) + ") Tj"
    stream += " ET"
    data = stream.encode("latin-1")
    objs = [
        b"<< /Type /Catalog /Pages 2 0 R >>",
        b"<< /Type /Pages /Kids [3 0 R] /Count 1 >>",
        b"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 595 842] /Resources << /Font << /F1 5 0 R >> >> /Contents 4 0 R >>",
        b"<< /Length " + str(len(data)).encode() + b" >>\nstream\n" + data + b"\nendstream",
        b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica /Encoding /WinAnsiEncoding >>",
    ]
    out = b"%PDF-1.4\n"
    offsets = []
    for i, o in enumerate(objs, 1):
        offsets.append(len(out))
        out += f"{i} 0 obj\n".encode() + o + b"\nendobj\n"
    xref = len(out)
    out += f"xref\n0 {len(objs) + 1}\n0000000000 65535 f \n".encode()
    out += b"".join(f"{o:010d} 00000 n \n".encode() for o in offsets)
    out += f"trailer\n<< /Size {len(objs) + 1} /Root 1 0 R >>\nstartxref\n{xref}\n%%EOF\n".encode()
    return out


def _met(reponse, expected):
    return reponse == expected or (expected == "oui" and reponse == "partiel")


def fill(evaluation_id: int, user_id: int, centre: str, upload_dir: str, seed=None, profil: str = "contraste") -> dict:
    """profil « contraste » : niveaux de conformité très variables d'une thématique à l'autre.
    profil « bon » (intermédiaire) : établissement globalement conforme — les questions maîtres sont
    « Oui » (pas de « Non » en cascade), les exigences critiques conformes ou au pire partielles, sauf
    sur 2 ou 3 chapitres BPP tirés au sort où une exigence critique est non conforme (chapitres
    en rouge dans l'avis d'expert) ; deux thématiques « fragiles » ont en outre un niveau plus bas."""
    rnd = random.Random(seed)
    bon = profil == "bon"
    sections = {s["id"]: s for s in fetch_all("SELECT id, parent_id FROM sections")}
    questions = fetch_all(
        "SELECT id, code, section_id, parent_question_id AS parent, depends_on_question_id AS dep, "
        "depends_on_value AS dep_val, is_part, question, severite, refs FROM questions ORDER BY sort_order"
    )

    def top(sid):
        while sections[sid]["parent_id"]:
            sid = sections[sid]["parent_id"]
        return sid
    # niveau de conformité propre à chaque thématique (statistiques contrastées)
    themes = [sid for sid in sections if not sections[sid]["parent_id"]]
    fragiles = set(rnd.sample(themes, 2)) if bon else set()
    level = {sid: (rnd.uniform(0.72, 0.80) if sid in fragiles else rnd.uniform(0.84, 0.96) if bon else rnd.uniform(0.45, 0.92))
             for sid in themes}

    answers, visible = {}, {}
    by_id = {q["id"]: q for q in questions}
    triggers = {q["dep"] for q in questions if q["dep"]}
    # écarts critiques imposés : questions critiques sans condition ni chapeau, regroupées par chapitre BPP
    forced = set()
    if bon:
        by_chap = {}
        for q in questions:
            if q["severite"] == "critique" and not q["dep"] and not q["parent"] and not q["is_part"] and q["id"] not in triggers:
                ref = (q["refs"] or "").split(",")[0].strip()
                chap = ref.split(".")[0] if ref else None
                if chap:
                    by_chap.setdefault(chap, []).append(q["id"])
        for chap in rnd.sample(sorted(by_chap), min(len(by_chap), rnd.randint(2, 3))):
            forced.update(rnd.sample(by_chap[chap], 1))
    rows, files = [], []
    y = date.today().year
    for q in questions:
        # visible si sa condition est remplie et que sa question chapeau / déclencheuse l'est aussi
        ok = True
        if q["parent"] and q["parent"] in by_id and not visible.get(q["parent"], True):
            ok = False
        if q["dep"] and q["dep"] != q["id"] and q["dep"] in by_id:
            d = by_id[q["dep"]]
            if not visible.get(d["id"], True):
                ok = False
            elif not d["is_part"] and not _met(answers.get(d["id"]), q["dep_val"] or "oui"):
                ok = False
        visible[q["id"]] = ok
        if not ok or q["is_part"]:
            continue
        theme = top(q["section_id"])
        p = level[theme]
        sev = q["severite"] or "mineur"
        fragile = theme in fragiles
        # question déclencheuse (d'autres en dépendent) : plutôt « oui » pour déployer le questionnaire
        if q["id"] in triggers:
            p = max(p, 0.97 if bon else 0.88)
        if bon and sev == "critique":
            p = max(p, 0.97 if fragile else 0.985)
        r = rnd.random()
        if q["id"] in forced:
            rep = "non"
        elif r < p:
            rep = "oui"
        elif bon and (q["id"] in triggers or (sev == "critique" and not fragile)):
            rep = "partiel"  # jamais de « Non » sur une question maître ou une exigence critique
        elif r < p + (1 - p) * (0.6 if bon and sev == "majeur" else 0.45):
            rep = "partiel"
        elif r < p + (1 - p) * 0.88:
            rep = "non"
        else:
            rep = "na"
        answers[q["id"]] = rep
        comment = rnd.choice(COMMENTAIRES) if rnd.random() < (0.12 if rep == "oui" else 0.35) else ""
        preuve = ""
        if rep in ("oui", "partiel") and rnd.random() < 0.3:
            preuve = rnd.choice(PREUVES).format(n=rnd.randint(1, 140), v=rnd.randint(1, 6), y=y - rnd.randint(0, 2),
                                                d=f"{rnd.randint(1, 28):02d}/{rnd.randint(1, 12):02d}/{y}")
        criticite = risque = None
        action = ""
        if rep == "non":
            weights = {"mineur": [85, 15, 0], "majeur": [40, 55, 5], "critique": [10, 50, 40]}[sev] if bon else [50, 35, 15]
            criticite = rnd.choices(["mineure", "majeure", "critique"], weights=weights)[0] if rnd.random() < 0.85 else None
            action = rnd.choice(ACTIONS) if criticite or rnd.random() < 0.3 else ""
        elif rep == "partiel":
            risque = rnd.choice(["oui", "non"]) if rnd.random() < 0.85 else None
            action = rnd.choice(ACTIONS) if risque == "non" or rnd.random() < 0.25 else ""
        fname = fpath = None
        if preuve and rnd.random() < 0.35:
            base = rnd.choice(FICHIERS)
            fname = f"{base}_{q['code']}.pdf"
            rel_dir = f"{evaluation_id}/{q['id']}"
            fpath = f"{rel_dir}/{uuid.uuid4().hex[:8]}_{fname}"
            files.append((fpath, _pdf([
                f"{preuve}",
                f"Établissement : {centre}",
                f"Question {q['code']} — document de démonstration",
                (q["question"] or "")[:90],
                f"Généré le {date.today().strftime('%d/%m/%Y')} (données fictives)",
            ])))
        rows.append((evaluation_id, q["id"], rep, bool(comment), comment, preuve, fname, fpath,
                     criticite, risque, action, user_id))

    for rel, content in files:
        os.makedirs(os.path.join(upload_dir, os.path.dirname(rel)), exist_ok=True)
        with open(os.path.join(upload_dir, rel), "wb") as f:
            f.write(content)
    with get_cursor(commit=True) as cur:
        cur.executemany(
            "INSERT INTO responses (evaluation_id, question_id, reponse, comment_actif, commentaire, preuve_texte, "
            "preuve_fichier_nom, preuve_fichier_chemin, criticite, risque_maitrise, action, updated_by, updated_at, version) "
            "VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s, now(), 1)",
            rows,
        )
    stats = {k: sum(1 for r in rows if r[2] == k) for k in ("oui", "partiel", "non", "na")}
    return {"reponses": len(rows), **stats, "commentaires": sum(1 for r in rows if r[4]),
            "preuves": sum(1 for r in rows if r[5]), "fichiers": len(files),
            "criticites": sum(1 for r in rows if r[8]), "actions": sum(1 for r in rows if r[10])}
