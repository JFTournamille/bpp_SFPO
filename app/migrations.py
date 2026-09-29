import glob
import logging
import os

from app.db import get_cursor

MIGRATIONS_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "migrations")

log = logging.getLogger("uvicorn.error")


def run_migrations():
    """Applique au démarrage les scripts migrations/*.sql pas encore passés sur la base
    (ordre alphabétique, chacun dans sa propre transaction). Permet de mettre à jour
    une base existante sans accès au serveur : un redéploiement suffit."""
    files = sorted(glob.glob(os.path.join(MIGRATIONS_DIR, "*.sql")))
    if not files:
        return
    with get_cursor(commit=True) as cur:
        cur.execute(
            "CREATE TABLE IF NOT EXISTS schema_migrations ("
            " filename TEXT PRIMARY KEY, applied_at TIMESTAMPTZ NOT NULL DEFAULT now())"
        )
    for path in files:
        name = os.path.basename(path)
        try:
            with get_cursor(commit=True) as cur:
                # verrou transactionnel : évite une double application si deux conteneurs démarrent ensemble
                cur.execute("SELECT pg_advisory_xact_lock(4242001)")
                cur.execute("SELECT 1 FROM schema_migrations WHERE filename = %s", (name,))
                if cur.fetchone():
                    continue
                with open(path, encoding="utf-8") as f:
                    cur.execute(f.read())
                cur.execute("INSERT INTO schema_migrations (filename) VALUES (%s)", (name,))
            log.info("Migration appliquée : %s", name)
        except Exception:
            # on n'empêche pas l'application de démarrer ; nouvelle tentative au prochain démarrage
            log.exception("Échec de la migration %s", name)
