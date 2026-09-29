-- Acquittement de la mention d'information RGPD, stocké sur le compte utilisateur.
-- rgpd_version : version de la mention acquittée (NULL = jamais acquittée) ;
-- une nouvelle version de la mention impose un nouvel acquittement à la connexion suivante.
-- Idempotent : peut être relancé sans risque.

ALTER TABLE users ADD COLUMN IF NOT EXISTS rgpd_version         TEXT;
ALTER TABLE users ADD COLUMN IF NOT EXISTS rgpd_acknowledged_at TIMESTAMPTZ;
