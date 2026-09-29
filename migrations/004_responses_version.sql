-- Travail à plusieurs sur un même questionnaire : numéro de version par réponse
-- (détection des modifications concurrentes) et auteur de la dernière modification.
-- Idempotent : peut être relancé sans risque.
ALTER TABLE responses ADD COLUMN IF NOT EXISTS version    INT NOT NULL DEFAULT 1;
ALTER TABLE responses ADD COLUMN IF NOT EXISTS updated_by INT REFERENCES users(id) ON DELETE SET NULL;
