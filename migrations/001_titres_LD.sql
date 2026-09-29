-- Titres complets des lignes directrices LD1 / LD2 / LD3 (base déjà initialisée).
-- Idempotent : peut être relancé sans risque.
UPDATE sections SET title = 'Préparations stériles - LD1'      WHERE id = 78 AND parent_id IS NULL;
UPDATE sections SET title = 'Substances à risque (CMR) - LD2'  WHERE id = 92 AND parent_id IS NULL;
UPDATE sections SET title = 'Essais cliniques - LD3'           WHERE id = 98 AND parent_id IS NULL;
