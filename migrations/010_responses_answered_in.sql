-- Chapitre BPP (1 à 9, LD1 à LD3) dans lequel la question a été renseignée. Une question qui
-- concerne plusieurs chapitres y est présentée partout ; une fois répondue, elle est verrouillée
-- ailleurs avec la mention « déjà répondu dans le chapitre … ». NULL : chapitre d'origine de la
-- question dans le référentiel (réponses antérieures à cette évolution).
ALTER TABLE responses ADD COLUMN IF NOT EXISTS answered_in TEXT;
