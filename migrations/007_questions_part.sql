-- Lignes « PART 1 » du fichier Excel (colonne B) : partie initiale commune à plusieurs
-- questions (ex. Q042 « Le système documentaire mis en place … est » puis Q042.01, Q042.02).
-- Elles ne sont pas des questions : affichées comme intitulé, sans réponse, hors progression
-- et statistiques. Aucune réponse existante n'est supprimée.
-- Idempotent : peut être relancé sans risque.
ALTER TABLE questions ADD COLUMN IF NOT EXISTS is_part BOOLEAN NOT NULL DEFAULT FALSE;
UPDATE questions SET is_part = TRUE WHERE id IN (
  'Q042', 'Q051', 'Q065', 'Q073', 'Q077', 'Q080', 'Q089', 'Q092',
  'Q093', 'Q096', 'Q103', 'Q108', 'Q112', 'Q114', 'Q117', 'Q121',
  'Q122', 'Q124', 'Q131', 'Q132', 'Q134', 'Q157', 'Q168', 'Q176',
  'Q185', 'Q192', 'Q193', 'Q198', 'Q198.02', 'Q198.03', 'Q198.04', 'Q201',
  'Q225', 'Q227', 'Q233', 'Q235', 'Q238', 'Q246', 'Q254', 'Q260',
  'Q261', 'Q268', 'Q270', 'Q271', 'Q272', 'Q276', 'Q297', 'Q298',
  'Q302', 'Q312', 'Q329', 'Q359', 'Q406', 'Q408', 'Q445', 'Q461',
  'Q463', 'Q492', 'Q493', 'Q494', 'Q498', 'Q514', 'Q530', 'Q538',
  'Q547', 'Q548', 'Q549', 'Q550', 'Q558', 'Q561', 'Q581', 'Q585',
  'Q593', 'Q597', 'Q599', 'Q607', 'Q608', 'Q610', 'Q613', 'Q615',
  'Q617', 'Q620', 'Q621', 'Q623', 'Q624.04', 'Q639', 'Q641', 'Q642',
  'Q661', 'Q662', 'Q666', 'Q725', 'Q734', 'Q738', 'Q745'
);
