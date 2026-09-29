-- Historique des acquittements de la mention RGPD (une ligne par acquittement et par version).
-- users.rgpd_version / rgpd_acknowledged_at restent la référence pour le contrôle d'accès.
-- Idempotent : peut être relancé sans risque.

CREATE TABLE IF NOT EXISTS rgpd_acknowledgements (
  id              SERIAL PRIMARY KEY,
  user_id         INT  NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  version         TEXT NOT NULL,
  acknowledged_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS rgpd_ack_user_idx ON rgpd_acknowledgements(user_id);

-- reprise des acquittements déjà enregistrés sur les comptes
INSERT INTO rgpd_acknowledgements (user_id, version, acknowledged_at)
SELECT u.id, u.rgpd_version, u.rgpd_acknowledged_at FROM users u
WHERE u.rgpd_version IS NOT NULL AND u.rgpd_acknowledged_at IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM rgpd_acknowledgements a WHERE a.user_id = u.id AND a.version = u.rgpd_version);
