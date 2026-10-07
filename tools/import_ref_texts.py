"""Génère migrations/008_ref_texts.sql : texte officiel de chaque référence BPP.

Source : feuille « ordre question » du référentiel Excel, qui répète chaque question
une fois par référence (colonne E = réf. BPP, colonne F = texte officiel de cette réf.).
Usage : python tools/import_ref_texts.py chemin/vers/referentiel.xlsx > migrations/008_ref_texts.sql
"""
import sys

import openpyxl


def main(path):
    ws = openpyxl.load_workbook(path, data_only=True)["ordre question"]
    texts = {}
    for row in ws.iter_rows(min_row=2, values_only=True):
        code, ref, text = row[0], row[4], row[5]
        if code is None or ref is None or not text:
            continue
        ref = str(ref).strip()
        texts.setdefault(ref, str(text).strip())

    def q(s):
        return "'" + s.replace("'", "''") + "'"

    print("-- Texte officiel de chaque référence BPP (info-bulle de chaque bulle « BPP x.yy »).")
    print("-- Généré par tools/import_ref_texts.py depuis la feuille « ordre question » du référentiel Excel.")
    print("-- Idempotent : un texte existant est remplacé par celui du fichier.")
    print("CREATE TABLE IF NOT EXISTS ref_texts (ref TEXT PRIMARY KEY, texte TEXT NOT NULL);")
    refs = sorted(texts)
    for i in range(0, len(refs), 100):
        print("INSERT INTO ref_texts (ref, texte) VALUES")
        print(",\n".join(f"({q(r)}, {q(texts[r])})" for r in refs[i:i + 100]))
        print("ON CONFLICT (ref) DO UPDATE SET texte = EXCLUDED.texte;")


if __name__ == "__main__":
    main(sys.argv[1])
