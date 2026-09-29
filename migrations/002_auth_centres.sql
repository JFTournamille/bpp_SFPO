-- Comptes (experts / membres), centres, sessions, rattachement des évaluations à un centre.
-- Idempotent : peut être relancé sans risque.

CREATE TABLE IF NOT EXISTS centres (
  id         SERIAL PRIMARY KEY,
  libelle    TEXT NOT NULL,
  finess     TEXT,
  ordre      INT  NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS users (
  id                   SERIAL PRIMARY KEY,
  login                TEXT NOT NULL UNIQUE,
  password_hash        TEXT NOT NULL,
  role                 TEXT NOT NULL CHECK (role IN ('expert','membre')),
  nom                  TEXT NOT NULL DEFAULT '',
  email                TEXT NOT NULL DEFAULT '',
  -- centre de rattachement (obligatoire pour un membre, affecté par un expert)
  centre_id            INT REFERENCES centres(id) ON DELETE SET NULL,
  must_change_password BOOLEAN NOT NULL DEFAULT TRUE,
  active               BOOLEAN NOT NULL DEFAULT TRUE,
  created_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_login_at        TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS sessions (
  token      TEXT PRIMARY KEY,
  user_id    INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  expires_at TIMESTAMPTZ NOT NULL
);
CREATE INDEX IF NOT EXISTS sessions_user_idx ON sessions(user_id);

ALTER TABLE evaluations ADD COLUMN IF NOT EXISTS centre_id    INT REFERENCES centres(id) ON DELETE SET NULL;
ALTER TABLE evaluations ADD COLUMN IF NOT EXISTS status       TEXT NOT NULL DEFAULT 'en_cours';
ALTER TABLE evaluations ADD COLUMN IF NOT EXISTS completed_at TIMESTAMPTZ;
DO $$ BEGIN
  ALTER TABLE evaluations ADD CONSTRAINT evaluations_status_chk CHECK (status IN ('en_cours','termine'));
EXCEPTION WHEN duplicate_object THEN NULL; END $$;
CREATE INDEX IF NOT EXISTS evaluations_centre_idx ON evaluations(centre_id);

-- Recherche de centres insensible à la casse et aux accents (sans dépendre de l'extension unaccent).
CREATE OR REPLACE FUNCTION unaccent_lower(t TEXT) RETURNS TEXT AS $$
  SELECT translate(lower(t), 'àâäáãåçéèêëíìîïñóòôöõúùûüýÿ', 'aaaaaaceeeeiiiinooooouuuuyy')
$$ LANGUAGE sql IMMUTABLE;
