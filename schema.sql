-- Schéma PostgreSQL — Auto-évaluation BPP (SFPO)
-- À exécuter une seule fois sur la base Postgres (ex: via psql, ou l'onglet SQL de votre client favori).

CREATE TABLE IF NOT EXISTS chapters (
  num        TEXT PRIMARY KEY,
  title      TEXT NOT NULL,
  sort_order INT  NOT NULL
);

CREATE TABLE IF NOT EXISTS subchapters (
  num         TEXT PRIMARY KEY,
  chapter_num TEXT NOT NULL REFERENCES chapters(num) ON DELETE CASCADE,
  title       TEXT NOT NULL,
  sort_order  INT  NOT NULL
);

CREATE TABLE IF NOT EXISTS questions (
  id             TEXT PRIMARY KEY,
  idx            INT  NOT NULL,
  code           TEXT,
  subchapter_num TEXT NOT NULL REFERENCES subchapters(num) ON DELETE CASCADE,
  question       TEXT NOT NULL,
  ref            TEXT,
  ref_text       TEXT,
  sort_order     INT  NOT NULL
);

CREATE TABLE IF NOT EXISTS evaluations (
  id         SERIAL PRIMARY KEY,
  label      TEXT NOT NULL DEFAULT 'Auto-évaluation BPP',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS responses (
  evaluation_id         INT  NOT NULL REFERENCES evaluations(id) ON DELETE CASCADE,
  question_id           TEXT NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  reponse               TEXT CHECK (reponse IN ('oui','non','partiel','na')),
  comment_actif         BOOLEAN NOT NULL DEFAULT FALSE,
  commentaire           TEXT NOT NULL DEFAULT '',
  preuve_texte          TEXT NOT NULL DEFAULT '',
  preuve_fichier_nom    TEXT,
  preuve_fichier_chemin TEXT,
  criticite             TEXT CHECK (criticite IN ('mineure','majeure','critique')),
  risque_maitrise       TEXT CHECK (risque_maitrise IN ('oui','non')),
  action                TEXT NOT NULL DEFAULT '',
  updated_at            TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (evaluation_id, question_id)
);

-- La première évaluation est créée automatiquement par l'API si la table est vide,
-- mais on la crée ici directement pour un démarrage immédiat.
INSERT INTO evaluations (id, label) VALUES (1, 'Auto-évaluation BPP')
ON CONFLICT (id) DO NOTHING;
SELECT setval('evaluations_id_seq', GREATEST((SELECT MAX(id) FROM evaluations), 1));

-- ============================================================
-- Données de référence (chapitres / sous-chapitres / questions)
-- Générées depuis le fichier Excel fourni (Classeur1.xlsx).
-- ============================================================
INSERT INTO chapters (num, title, sort_order) VALUES
('1', 'MANAGEMENT DU SYTEME QUALITE PHARMACEUTIQUE', 1),
('2', 'AUTO-INSPECTION', 2)
ON CONFLICT (num) DO NOTHING;

INSERT INTO subchapters (num, chapter_num, title, sort_order) VALUES
('1.1', '1', 'PRINCIPES', 1),
('1.2', '1', 'SYSTÈME QUALITÉ PHARMACEUTIQUE', 2),
('1.3', '1', 'BONNES PRATIQUES DE PRÉPARATION', 3),
('1.4', '1', 'CONTRÔLE DE LA QUALITÉ', 4),
('1.5', '1', 'REVUE QUALITÉ DES PRÉPARATIONS PHARMACEUTIQUES', 5),
('1.6', '1', 'APPRÉCIATION DU RISQUE DE LA PRÉPARATION PHARMACEUTIQUE', 6),
('2.1', '2', 'PRINCIPES', 7)
ON CONFLICT (num) DO NOTHING;

INSERT INTO questions (id, idx, code, subchapter_num, question, ref, ref_text, sort_order) VALUES
('Q1', 1, '1.1', '1.1', 'Les préparations pharmaceutiques sont-elles réalisées conformément aux exigences du présent texte, de façon à garantir une qualité constante et appropriée à leur usage ?', '1.1', 'Afin de protéger la santé humaine, les préparations pharmaceutiques sont réalisées de façon à garantir une qualité constante, appropriée à leur usage. Pour atteindre cet objectif elles sont réalisées en conformité avec les exigences définies dans le présent texte.', 1),
('Q2', 2, '1.2-a', '1.1', 'Existe-t-il un système d''assurance qualité ?', '1.2', 'Les pharmacies à usage intérieur et les pharmacies d''officine disposent d’un système d’assurance qualité qui intègre l’ensemble des règles de bonnes pratiques présentées dans ce texte. Ce système est documenté et contrôlé et son efficacité est surveillée.', 2),
('Q3', 3, '1.2-b', '1.1', 'Ce système est-il basé sur les Bonnes Pratiques de Préparation publiées par l''ANSM en 2023 ?', '1.2', 'Les pharmacies à usage intérieur et les pharmacies d''officine disposent d’un système d’assurance qualité qui intègre l’ensemble des règles de bonnes pratiques présentées dans ce texte. Ce système est documenté et contrôlé et son efficacité est surveillée.', 3),
('Q4', 4, '1.2-c', '1.1', 'Ce système est-il documenté (MAQ, procédures, MO, enregistrements) ?', '1.2', 'Les pharmacies à usage intérieur et les pharmacies d''officine disposent d’un système d’assurance qualité qui intègre l’ensemble des règles de bonnes pratiques présentées dans ce texte. Ce système est documenté et contrôlé et son efficacité est surveillée.', 4),
('Q5', 5, '1.2-d', '1.1', 'Ce système est-il contrôlé (auto-inspections, audits…) ?', '1.2', 'Les pharmacies à usage intérieur et les pharmacies d''officine disposent d’un système d’assurance qualité qui intègre l’ensemble des règles de bonnes pratiques présentées dans ce texte. Ce système est documenté et contrôlé et son efficacité est surveillée.', 5),
('Q6', 6, '1.2-e', '1.1', 'Des indicateurs qualité sont-ils identifiés et suivis ?', '1.2', 'Les pharmacies à usage intérieur et les pharmacies d''officine disposent d’un système d’assurance qualité qui intègre l’ensemble des règles de bonnes pratiques présentées dans ce texte. Ce système est documenté et contrôlé et son efficacité est surveillée.', 6),
('Q7', 7, '1.3', '1.1', 'Les liens entre gestion de la qualité, BPP et gestion du risque sont-ils pris en compte dans la production et le contrôle des préparations ?', '1.3', 'Les concepts fondamentaux de la gestion de la qualité, des Bonnes Pratiques de Préparation (BPP) et de la gestion du risque sont étroitement liés. Ils sont décrits ci-après en vue de souligner leurs relations réciproques et leur importance fondamentale dans la production et le contrôle des
préparations pharmaceutiques.', 7),
('Q8', 8, '1.4-a', '1.2', 'Le système d''assurance qualité intègre-t-il les BPP (sources bibliographiques intégrant les BPP) ?', '1.4', 'La gestion de la qualité est un concept large qui couvre tout ce qui peut, individuellement ou collectivement, avoir une influence sur la qualité d’un produit. Elle représente l’ensemble des dispositions prises pour garantir que les préparations sont conformes aux spécifications attendues et
de qualité requise pour l’usage auquel elles sont destinées. La gestion de la qualité intègre les BPP.', 8),
('Q9', 9, '1.5-a', '1.2', 'Existe-t-il un système de gestion documentaire ?', '1.5', 'Le système d’assurance qualité est soumis à une évaluation de son efficacité et de son adéquation entre le présent texte et les pratiques mises en oeuvre :
-un système documentaire est mis en place et maîtrisé ;
-les préparations sont formulées et réalisées selon l’état des connaissances scientifiques, médicales et pharmaceutiques ;
-les procédés de préparation et de contrôle sont clairement décrits et les règles figurant dans le présent texte sont appliquées ;
-une fois réalisées, les préparations n’entrent dans le circuit de dispensation qu’une fois contrôlées et libérées conformément aux procédures établies ;
-des dispositions sont prises pour garantir la qualité des préparations jusqu’à leur date de péremption et leur délai limite d’utilisation après ouverture.', 9),
('Q10', 10, '1.5-b', '1.2', 'Ce système est-il connu du personnel impliqué dans la production ?', '1.5', 'Le système d’assurance qualité est soumis à une évaluation de son efficacité et de son adéquation entre le présent texte et les pratiques mises en oeuvre :
-un système documentaire est mis en place et maîtrisé ;
-les préparations sont formulées et réalisées selon l’état des connaissances scientifiques, médicales et pharmaceutiques ;
-les procédés de préparation et de contrôle sont clairement décrits et les règles figurant dans le présent texte sont appliquées ;
-une fois réalisées, les préparations n’entrent dans le circuit de dispensation qu’une fois contrôlées et libérées conformément aux procédures établies ;
-des dispositions sont prises pour garantir la qualité des préparations jusqu’à leur date de péremption et leur délai limite d’utilisation après ouverture.', 10),
('Q11', 11, '1.5-c', '1.2', 'Les préparations sont-elles formulées et réalisées selon l''état des connaissances scientifiques, médicales et pharmaceutiques, avec traçabilité de l''analyse ?', '1.5', 'Le système d’assurance qualité est soumis à une évaluation de son efficacité et de son adéquation entre le présent texte et les pratiques mises en oeuvre :
-un système documentaire est mis en place et maîtrisé ;
-les préparations sont formulées et réalisées selon l’état des connaissances scientifiques, médicales et pharmaceutiques ;
-les procédés de préparation et de contrôle sont clairement décrits et les règles figurant dans le présent texte sont appliquées ;
-une fois réalisées, les préparations n’entrent dans le circuit de dispensation qu’une fois contrôlées et libérées conformément aux procédures établies ;
-des dispositions sont prises pour garantir la qualité des préparations jusqu’à leur date de péremption et leur délai limite d’utilisation après ouverture.', 11),
('Q12', 12, '1.7', '1.3', 'Les dossiers de lot permettent-ils une traçabilité complète, de la fabrication à la dispensation au patient ?', '1.7', 'Les BPP s’appliquent à la fois à la production et au contrôle de la qualité des préparations pharmaceutiques. Les exigences fondamentales des BPP sont les suivantes :
-le personnel est qualifié et formé à la fonction qu’il occupe. Les responsabilités et les compétences sont clairement définies ;
-les locaux et équipements sont adaptés aux préparations à réaliser ;
-tous les facteurs influençant la qualité des préparations sont évalués et sont décrits dans des documents appropriés ;
-tout procédé de préparation respecte le présent texte. Toutes les étapes requises par les procédures sont documentées. Les dossiers de lot sont établis de manière à permettre la traçabilité complète du lot de la préparation concernée jusqu’à sa libération et sa dispensation aux patients, en tenant compte des dispositions décrites au chapitre 7 dans le cas où l’activité est externalisée ;
-la manipulation, le transport et le stockage des matières premières à usage pharmaceutique (MPUP) et des articles de conditionnement se déroulent de façon à garantir leur qualité pendant toute leur durée de validité ;
-la qualité des produits obtenus est évaluée et satisfait aux exigences requises ; l’évaluation est documentée et inclut :
*un examen des documents de préparation ;
*la réalisation de contrôles qualité ;
* une comparaison entre les résultats des contrôles qualité et les spécifications exigées ;
*une analyse des écarts éventuels.
*les lots ne sont libérés qu’après vérification et attestation de leur conformité aux spécifications requises ;
*les réclamations et les non-conformités concernant les préparations pharmaceutiques, les MPUP et les articles de conditionnement sont examinées et étudiées afin de prendre les mesures correctives adaptées.', 12),
('Q13', 13, NULL, '1.3', 'Les MPUP et DM sont-ils manipulés, transportés et stockés de manière à conserver leur qualité jusqu''à péremption ?', '1.7', 'Les BPP s’appliquent à la fois à la production et au contrôle de la qualité des préparations pharmaceutiques. Les exigences fondamentales des BPP sont les suivantes :
-le personnel est qualifié et formé à la fonction qu’il occupe. Les responsabilités et les compétences sont clairement définies ;
-les locaux et équipements sont adaptés aux préparations à réaliser ;
-tous les facteurs influençant la qualité des préparations sont évalués et sont décrits dans des documents appropriés ;
-tout procédé de préparation respecte le présent texte. Toutes les étapes requises par les procédures sont documentées. Les dossiers de lot sont établis de manière à permettre la traçabilité complète du lot de la préparation concernée jusqu’à sa libération et sa dispensation aux patients, en tenant compte des dispositions décrites au chapitre 7 dans le cas où l’activité est externalisée ;
-la manipulation, le transport et le stockage des matières premières à usage pharmaceutique (MPUP) et des articles de conditionnement se déroulent de façon à garantir leur qualité pendant toute leur durée de validité ;
-la qualité des produits obtenus est évaluée et satisfait aux exigences requises ; l’évaluation est documentée et inclut :
*un examen des documents de préparation ;
*la réalisation de contrôles qualité ;
* une comparaison entre les résultats des contrôles qualité et les spécifications exigées ;
*une analyse des écarts éventuels.
*les lots ne sont libérés qu’après vérification et attestation de leur conformité aux spécifications requises ;
*les réclamations et les non-conformités concernant les préparations pharmaceutiques, les MPUP et les articles de conditionnement sont examinées et étudiées afin de prendre les mesures correctives adaptées.', 13),
('Q14', 14, NULL, '1.3', 'La qualité des produits est-elle documentée et évaluée ?', '1.7', 'Les BPP s’appliquent à la fois à la production et au contrôle de la qualité des préparations pharmaceutiques. Les exigences fondamentales des BPP sont les suivantes :
-le personnel est qualifié et formé à la fonction qu’il occupe. Les responsabilités et les compétences sont clairement définies ;
-les locaux et équipements sont adaptés aux préparations à réaliser ;
-tous les facteurs influençant la qualité des préparations sont évalués et sont décrits dans des documents appropriés ;
-tout procédé de préparation respecte le présent texte. Toutes les étapes requises par les procédures sont documentées. Les dossiers de lot sont établis de manière à permettre la traçabilité complète du lot de la préparation concernée jusqu’à sa libération et sa dispensation aux patients, en tenant compte des dispositions décrites au chapitre 7 dans le cas où l’activité est externalisée ;
-la manipulation, le transport et le stockage des matières premières à usage pharmaceutique (MPUP) et des articles de conditionnement se déroulent de façon à garantir leur qualité pendant toute leur durée de validité ;
-la qualité des produits obtenus est évaluée et satisfait aux exigences requises ; l’évaluation est documentée et inclut :
*un examen des documents de préparation ;
*la réalisation de contrôles qualité ;
* une comparaison entre les résultats des contrôles qualité et les spécifications exigées ;
*une analyse des écarts éventuels.
*les lots ne sont libérés qu’après vérification et attestation de leur conformité aux spécifications requises ;
*les réclamations et les non-conformités concernant les préparations pharmaceutiques, les MPUP et les articles de conditionnement sont examinées et étudiées afin de prendre les mesures correctives adaptées.', 14),
('Q15', 15, NULL, '1.3', 'L''évaluation inclut-elle le document de préparation (analyse de faisabilité et validité technico-réglementaire) ?', '1.7', 'Les BPP s’appliquent à la fois à la production et au contrôle de la qualité des préparations pharmaceutiques. Les exigences fondamentales des BPP sont les suivantes :
-le personnel est qualifié et formé à la fonction qu’il occupe. Les responsabilités et les compétences sont clairement définies ;
-les locaux et équipements sont adaptés aux préparations à réaliser ;
-tous les facteurs influençant la qualité des préparations sont évalués et sont décrits dans des documents appropriés ;
-tout procédé de préparation respecte le présent texte. Toutes les étapes requises par les procédures sont documentées. Les dossiers de lot sont établis de manière à permettre la traçabilité complète du lot de la préparation concernée jusqu’à sa libération et sa dispensation aux patients, en tenant compte des dispositions décrites au chapitre 7 dans le cas où l’activité est externalisée ;
-la manipulation, le transport et le stockage des matières premières à usage pharmaceutique (MPUP) et des articles de conditionnement se déroulent de façon à garantir leur qualité pendant toute leur durée de validité ;
-la qualité des produits obtenus est évaluée et satisfait aux exigences requises ; l’évaluation est documentée et inclut :
*un examen des documents de préparation ;
*la réalisation de contrôles qualité ;
* une comparaison entre les résultats des contrôles qualité et les spécifications exigées ;
*une analyse des écarts éventuels.
*les lots ne sont libérés qu’après vérification et attestation de leur conformité aux spécifications requises ;
*les réclamations et les non-conformités concernant les préparations pharmaceutiques, les MPUP et les articles de conditionnement sont examinées et étudiées afin de prendre les mesures correctives adaptées.', 15),
('Q16', 16, NULL, '1.3', 'L''évaluation inclut-elle la description des contrôles qualité réalisés ?', '1.7', 'Les BPP s’appliquent à la fois à la production et au contrôle de la qualité des préparations pharmaceutiques. Les exigences fondamentales des BPP sont les suivantes :
-le personnel est qualifié et formé à la fonction qu’il occupe. Les responsabilités et les compétences sont clairement définies ;
-les locaux et équipements sont adaptés aux préparations à réaliser ;
-tous les facteurs influençant la qualité des préparations sont évalués et sont décrits dans des documents appropriés ;
-tout procédé de préparation respecte le présent texte. Toutes les étapes requises par les procédures sont documentées. Les dossiers de lot sont établis de manière à permettre la traçabilité complète du lot de la préparation concernée jusqu’à sa libération et sa dispensation aux patients, en tenant compte des dispositions décrites au chapitre 7 dans le cas où l’activité est externalisée ;
-la manipulation, le transport et le stockage des matières premières à usage pharmaceutique (MPUP) et des articles de conditionnement se déroulent de façon à garantir leur qualité pendant toute leur durée de validité ;
-la qualité des produits obtenus est évaluée et satisfait aux exigences requises ; l’évaluation est documentée et inclut :
*un examen des documents de préparation ;
*la réalisation de contrôles qualité ;
* une comparaison entre les résultats des contrôles qualité et les spécifications exigées ;
*une analyse des écarts éventuels.
*les lots ne sont libérés qu’après vérification et attestation de leur conformité aux spécifications requises ;
*les réclamations et les non-conformités concernant les préparations pharmaceutiques, les MPUP et les articles de conditionnement sont examinées et étudiées afin de prendre les mesures correctives adaptées.', 16),
('Q17', 17, NULL, '1.3', 'L''évaluation inclut-elle la comparaison entre les résultats des contrôles et les spécifications attendues ?', '1.7', 'Les BPP s’appliquent à la fois à la production et au contrôle de la qualité des préparations pharmaceutiques. Les exigences fondamentales des BPP sont les suivantes :
-le personnel est qualifié et formé à la fonction qu’il occupe. Les responsabilités et les compétences sont clairement définies ;
-les locaux et équipements sont adaptés aux préparations à réaliser ;
-tous les facteurs influençant la qualité des préparations sont évalués et sont décrits dans des documents appropriés ;
-tout procédé de préparation respecte le présent texte. Toutes les étapes requises par les procédures sont documentées. Les dossiers de lot sont établis de manière à permettre la traçabilité complète du lot de la préparation concernée jusqu’à sa libération et sa dispensation aux patients, en tenant compte des dispositions décrites au chapitre 7 dans le cas où l’activité est externalisée ;
-la manipulation, le transport et le stockage des matières premières à usage pharmaceutique (MPUP) et des articles de conditionnement se déroulent de façon à garantir leur qualité pendant toute leur durée de validité ;
-la qualité des produits obtenus est évaluée et satisfait aux exigences requises ; l’évaluation est documentée et inclut :
*un examen des documents de préparation ;
*la réalisation de contrôles qualité ;
* une comparaison entre les résultats des contrôles qualité et les spécifications exigées ;
*une analyse des écarts éventuels.
*les lots ne sont libérés qu’après vérification et attestation de leur conformité aux spécifications requises ;
*les réclamations et les non-conformités concernant les préparations pharmaceutiques, les MPUP et les articles de conditionnement sont examinées et étudiées afin de prendre les mesures correctives adaptées.', 17),
('Q18', 18, NULL, '1.3', 'Les lots sont-ils libérés uniquement après vérification et attestation de conformité aux spécifications requises ?', '1.7', 'Les BPP s’appliquent à la fois à la production et au contrôle de la qualité des préparations pharmaceutiques. Les exigences fondamentales des BPP sont les suivantes :
-le personnel est qualifié et formé à la fonction qu’il occupe. Les responsabilités et les compétences sont clairement définies ;
-les locaux et équipements sont adaptés aux préparations à réaliser ;
-tous les facteurs influençant la qualité des préparations sont évalués et sont décrits dans des documents appropriés ;
-tout procédé de préparation respecte le présent texte. Toutes les étapes requises par les procédures sont documentées. Les dossiers de lot sont établis de manière à permettre la traçabilité complète du lot de la préparation concernée jusqu’à sa libération et sa dispensation aux patients, en tenant compte des dispositions décrites au chapitre 7 dans le cas où l’activité est externalisée ;
-la manipulation, le transport et le stockage des matières premières à usage pharmaceutique (MPUP) et des articles de conditionnement se déroulent de façon à garantir leur qualité pendant toute leur durée de validité ;
-la qualité des produits obtenus est évaluée et satisfait aux exigences requises ; l’évaluation est documentée et inclut :
*un examen des documents de préparation ;
*la réalisation de contrôles qualité ;
* une comparaison entre les résultats des contrôles qualité et les spécifications exigées ;
*une analyse des écarts éventuels.
*les lots ne sont libérés qu’après vérification et attestation de leur conformité aux spécifications requises ;
*les réclamations et les non-conformités concernant les préparations pharmaceutiques, les MPUP et les articles de conditionnement sont examinées et étudiées afin de prendre les mesures correctives adaptées.', 18),
('Q19', 19, NULL, '1.3', 'En cas de non-conformité, des réclamations et analyses sont-elles effectuées pour prendre des mesures correctives adaptées ?', '1.7', 'Les BPP s’appliquent à la fois à la production et au contrôle de la qualité des préparations pharmaceutiques. Les exigences fondamentales des BPP sont les suivantes :
-le personnel est qualifié et formé à la fonction qu’il occupe. Les responsabilités et les compétences sont clairement définies ;
-les locaux et équipements sont adaptés aux préparations à réaliser ;
-tous les facteurs influençant la qualité des préparations sont évalués et sont décrits dans des documents appropriés ;
-tout procédé de préparation respecte le présent texte. Toutes les étapes requises par les procédures sont documentées. Les dossiers de lot sont établis de manière à permettre la traçabilité complète du lot de la préparation concernée jusqu’à sa libération et sa dispensation aux patients, en tenant compte des dispositions décrites au chapitre 7 dans le cas où l’activité est externalisée ;
-la manipulation, le transport et le stockage des matières premières à usage pharmaceutique (MPUP) et des articles de conditionnement se déroulent de façon à garantir leur qualité pendant toute leur durée de validité ;
-la qualité des produits obtenus est évaluée et satisfait aux exigences requises ; l’évaluation est documentée et inclut :
*un examen des documents de préparation ;
*la réalisation de contrôles qualité ;
* une comparaison entre les résultats des contrôles qualité et les spécifications exigées ;
*une analyse des écarts éventuels.
*les lots ne sont libérés qu’après vérification et attestation de leur conformité aux spécifications requises ;
*les réclamations et les non-conformités concernant les préparations pharmaceutiques, les MPUP et les articles de conditionnement sont examinées et étudiées afin de prendre les mesures correctives adaptées.', 19),
('Q20', 20, '1.8-a', '1.4', 'Le périmètre du contrôle de la qualité est-il défini ?', '1.8', 'Le contrôle de la qualité fait partie des BPP (cf. Chapitre 6). Il concerne l’échantillonnage, les spécifications et le contrôle, ainsi que les procédures d’organisation, de documentation et de libération qui garantissent que les contrôles qualité nécessaires et appropriés sont réellement effectués. Les
MPUP, les articles de conditionnement, les produits intermédiaires, les préparations utilisées pour la réalisation d’autres préparations et les préparations terminées ne sont libérées qu’après vérification de leur qualité et de leur conformité aux spécifications.', 20),
('Q21', 21, '1.8-b', '1.4', 'Le contrôle de la qualité couvre-t-il l''échantillonnage (poche mère sur certains robots) ?', '1.8', 'Le contrôle de la qualité fait partie des BPP (cf. Chapitre 6). Il concerne l’échantillonnage, les spécifications et le contrôle, ainsi que les procédures d’organisation, de documentation et de libération qui garantissent que les contrôles qualité nécessaires et appropriés sont réellement effectués. Les
MPUP, les articles de conditionnement, les produits intermédiaires, les préparations utilisées pour la réalisation d’autres préparations et les préparations terminées ne sont libérées qu’après vérification de leur qualité et de leur conformité aux spécifications.', 21),
('Q22', 22, '1.8-c', '1.4', 'Le contrôle de la qualité couvre-t-il les procédures d''organisation, de documentation et de libération garantissant la réalisation des contrôles nécessaires ?', '1.8', 'Le contrôle de la qualité fait partie des BPP (cf. Chapitre 6). Il concerne l’échantillonnage, les spécifications et le contrôle, ainsi que les procédures d’organisation, de documentation et de libération qui garantissent que les contrôles qualité nécessaires et appropriés sont réellement effectués. Les
MPUP, les articles de conditionnement, les produits intermédiaires, les préparations utilisées pour la réalisation d’autres préparations et les préparations terminées ne sont libérées qu’après vérification de leur qualité et de leur conformité aux spécifications.', 22),
('Q23', 23, '1.8-d', '1.4', 'Seuls les MPUP, DM et préparations vérifiés et conformes aux spécifications requises sont-ils libérés ?', '1.8', 'Le contrôle de la qualité fait partie des BPP (cf. Chapitre 6). Il concerne l’échantillonnage, les spécifications et le contrôle, ainsi que les procédures d’organisation, de documentation et de libération qui garantissent que les contrôles qualité nécessaires et appropriés sont réellement effectués. Les
MPUP, les articles de conditionnement, les produits intermédiaires, les préparations utilisées pour la réalisation d’autres préparations et les préparations terminées ne sont libérées qu’après vérification de leur qualité et de leur conformité aux spécifications.', 23),
('Q24', 24, '1.9-a', '1.4', 'La nature des contrôles à effectuer est-elle définie pour chaque préparation ?', '1.9', 'La nature du contrôle de la qualité est définie et justifiée en fonction de l''analyse de risque réalisée pour la préparation concernée.', 24),
('Q25', 25, '1.9-b', '1.4', 'Les contrôles sont-ils justifiés par l''analyse de risque réalisée pour chaque préparation ?', '1.9', 'La nature du contrôle de la qualité est définie et justifiée en fonction de l''analyse de risque réalisée pour la préparation concernée.', 25),
('Q26', 26, '1.10-a', '1.5', 'Des revues qualité sont-elles organisées selon une périodicité définie ?', '1.10', 'Après analyse des réclamations et des non-conformités, il est recommandé de réaliser des revues qualités portant notamment sur les préparations pour lesquelles un écart ou une modification substantielle a été relevée. Ces revues sont menées afin de vérifier la répétabilité des procédés existants, la pertinence des spécifications initialement décrites dans le dossier de préparation (cf. Annexe II) pour les MPUP, les articles de conditionnement, les produits intermédiaires et les préparations terminées. Ces revues permettent de mettre en évidence toute évolution et d’identifier les améliorations à apporter aux produits et aux procédés. Elles alimentent l’analyse globale du risque lié à la préparation et sont normalement menées et documentées selon une périodicité appropriée et justifiée. Elles prennent en compte les revues précédentes. Elles comprennent notamment le suivi des éléments suivants :
-Les MPUP et les articles de conditionnement utilisés pour la préparation, notamment ceux provenant de nouvelles sources d’approvisionnement, ainsi que la traçabilité de la chaîne d’approvisionnement des substances actives ;
-les résultats des contrôles qualité des préparations terminées ;
-les lots non conformes aux spécifications établies ainsi que les investigations correspondantes ;
-les déviations significatives et les non-conformités, les investigations correspondantes et l''efficacité des actions correctives et préventives prises en conséquence ;
-les modifications intervenues sur les procédés ou sur les méthodes d''analyse ;
-les retours, réclamations et rappels liés à des problèmes de qualité ainsi que les investigations correspondantes ;
-la pertinence de toute mesure corrective antérieure relative au procédé de préparation ou aux équipements ;
-la qualification des principaux équipements et de leurs utilités, par exemple les installations de traitement de l’air, de production et de distribution de l’eau ou de gaz comprimés ;
-les contrats et/ou cahiers des charges et/ou plannings de maintenance technique afin de s''assurer qu''ils sont à jour.', 26),
('Q27', 27, '1.10-b', '1.5', 'Les revues qualité sont-elles documentées ?', '1.10', 'Après analyse des réclamations et des non-conformités, il est recommandé de réaliser des revues qualités portant notamment sur les préparations pour lesquelles un écart ou une modification substantielle a été relevée. Ces revues sont menées afin de vérifier la répétabilité des procédés existants, la pertinence des spécifications initialement décrites dans le dossier de préparation (cf. Annexe II) pour les MPUP, les articles de conditionnement, les produits intermédiaires et les préparations terminées. Ces revues permettent de mettre en évidence toute évolution et d’identifier les améliorations à apporter aux produits et aux procédés. Elles alimentent l’analyse globale du risque lié à la préparation et sont normalement menées et documentées selon une périodicité appropriée et justifiée. Elles prennent en compte les revues précédentes. Elles comprennent notamment le suivi des éléments suivants :
-Les MPUP et les articles de conditionnement utilisés pour la préparation, notamment ceux provenant de nouvelles sources d’approvisionnement, ainsi que la traçabilité de la chaîne d’approvisionnement des substances actives ;
-les résultats des contrôles qualité des préparations terminées ;
-les lots non conformes aux spécifications établies ainsi que les investigations correspondantes ;
-les déviations significatives et les non-conformités, les investigations correspondantes et l''efficacité des actions correctives et préventives prises en conséquence ;
-les modifications intervenues sur les procédés ou sur les méthodes d''analyse ;
-les retours, réclamations et rappels liés à des problèmes de qualité ainsi que les investigations correspondantes ;
-la pertinence de toute mesure corrective antérieure relative au procédé de préparation ou aux équipements ;
-la qualification des principaux équipements et de leurs utilités, par exemple les installations de traitement de l’air, de production et de distribution de l’eau ou de gaz comprimés ;
-les contrats et/ou cahiers des charges et/ou plannings de maintenance technique afin de s''assurer qu''ils sont à jour.', 27),
('Q28', 28, '1.10-c', '1.5', 'En cas de réclamation ou de non-conformité, des analyses de risque a posteriori sont-elles réalisées et alimentent-elles l''analyse globale du risque ?', '1.10', 'Après analyse des réclamations et des non-conformités, il est recommandé de réaliser des revues qualités portant notamment sur les préparations pour lesquelles un écart ou une modification substantielle a été relevée. Ces revues sont menées afin de vérifier la répétabilité des procédés existants, la pertinence des spécifications initialement décrites dans le dossier de préparation (cf. Annexe II) pour les MPUP, les articles de conditionnement, les produits intermédiaires et les préparations terminées. Ces revues permettent de mettre en évidence toute évolution et d’identifier les améliorations à apporter aux produits et aux procédés. Elles alimentent l’analyse globale du risque lié à la préparation et sont normalement menées et documentées selon une périodicité appropriée et justifiée. Elles prennent en compte les revues précédentes. Elles comprennent notamment le suivi des éléments suivants :
-Les MPUP et les articles de conditionnement utilisés pour la préparation, notamment ceux provenant de nouvelles sources d’approvisionnement, ainsi que la traçabilité de la chaîne d’approvisionnement des substances actives ;
-les résultats des contrôles qualité des préparations terminées ;
-les lots non conformes aux spécifications établies ainsi que les investigations correspondantes ;
-les déviations significatives et les non-conformités, les investigations correspondantes et l''efficacité des actions correctives et préventives prises en conséquence ;
-les modifications intervenues sur les procédés ou sur les méthodes d''analyse ;
-les retours, réclamations et rappels liés à des problèmes de qualité ainsi que les investigations correspondantes ;
-la pertinence de toute mesure corrective antérieure relative au procédé de préparation ou aux équipements ;
-la qualification des principaux équipements et de leurs utilités, par exemple les installations de traitement de l’air, de production et de distribution de l’eau ou de gaz comprimés ;
-les contrats et/ou cahiers des charges et/ou plannings de maintenance technique afin de s''assurer qu''ils sont à jour.', 28),
('Q29', 29, '1.13-a', '1.6', 'La validation technico-réglementaire des préparations est-elle réalisée (annexe II partie 1) ?', '1.13', 'Une évaluation de la valeur ajoutée et de la faisabilité technique de la préparation est réalisée.
* la valeur ajoutée est estimée en considérant pour chaque préparation notamment :
- l''intérêt pharmaco-thérapeutique ;
- la meilleure acceptabilité possible pour une observance renforcée ;
- l’appréciation du bénéfice/risque.
* la faisabilité technique est estimée en considérant pour chaque préparation :
- la présence de procédures générales et de modes opératoires ;
- la présence de matériel et locaux conformes à la réalisation de la forme pharmaceutique ;
- la présence d’un personnel formé ;
- une analyse de la formule de la préparation.', 29),
('Q30', 30, '1.14', '1.6', 'Un dossier de préparation est-il réalisé pour chaque type de préparation, reprenant la validité technico-réglementaire, le procédé, les spécifications, les contrôles et les éléments d''assurance qualité ?', '1.14', 'D’un point de vue pratique, un dossier de préparation en trois parties est à rédiger afin de regrouper toutes les informations nécessaires au bon déroulement de la préparation (cf. Annexe II).', 30),
('Q31', 31, '1.19', '1.6', 'En cas d''impossibilité de réalisation par la pharmacie, un contrat de sous-traitance est-il établi selon les textes en vigueur ?', '1.19', 'Si le pharmacien n''est pas en mesure de réaliser la préparation, il la sous-traite selon la réglementation en vigueur et dans les conditions prévues par le présent texte.', 31),
('Q32', 32, '1.20', '1.6', 'L''analyse technico-réglementaire est-elle réalisée pour chaque type de préparation (annexe I) et constitue-t-elle la preuve de refus ?', '1.20', 'Le pharmacien refuse de réaliser et de dispenser une préparation s''il estime que celle-ci n''est pas conforme à l''état des connaissances scientifiques, médicales et pharmaceutiques et/ou que celle-ci est dangereuse au regard de l’appréciation du risque décrit ci-dessus.', 32),
('Q33', 33, '1.21', '1.6', 'En cas d''impossibilité de réalisation, la notification et/ou la proposition d''alternative au prescripteur est-elle tracée ?', '1.21', 'En cas d’impossibilité de réalisation de la préparation, il le notifie et propose au prescripteur et/ou donneur d’ordre, si possible, une alternative.', 33),
('Q34', 34, '1.11', '1.6', 'Des analyses de risque portant sur l''intégralité du processus de préparation sont-elles réalisées (annexe III) ?', '1.11', 'L’appréciation du rapport bénéfice/risque permet d’évaluer les dangers potentiels et sert de base pour décider si des mesures de réduction des risques sont à appliquer, ou si le risque existant peut être accepté.', 34),
('Q35', 35, '1.16', '1.6', 'Des analyses de risque concernant les processus de préparation sont-elles réalisées (annexe III) ?', '1.16', 'L’évaluation du risque de la préparation permet de définir les niveaux d’exigences adaptés à la réalisation de cette dernière. Cette évaluation prend en compte notamment la substance active, la voie d''administration, la forme pharmaceutique, les opérations pharmaceutiques réalisées et le
nombre de patients potentiels pour lesquels la préparation est réalisée.
Un tableau permettant une catégorisation des préparations pharmaceutiques est proposé (cf. Annexe III).
La classification des préparations en 3 catégories facilite l’application des conditions requises pour l’exécution et le contrôle des préparations.
Elle permet de discriminer les préparations susceptibles de présenter directement ou indirectement un danger pour la santé : risque faible, risque moyen et risque élevé, en fonction des paramètres critiques de la préparation. Le niveau de production annuel est un facteur susceptible de minorer ou de majorer le risque au regard de l’effectif du groupe de patients amené à recevoir la préparation.', 35),
('Q36', 36, '1.12', '1.6', 'Une analyse pharmaceutique et réglementaire est-elle réalisée pour chaque type de préparation (annexe I) ?', '1.12', 'Quel que soit le risque associé à la réalisation d''une préparation et préalablement à sa réalisation, une analyse pharmaceutique est réalisée par le pharmacien qui reçoit la demande. Un exemple d’outil d’aide à l’analyse pharmaceutique et réglementaire est proposé (cf. Annexe I).', 36),
('Q37', 37, '4.32-b', '1.6', 'Une recherche bibliographique (données toxicologiques et cliniques des PA et excipients) est-elle réalisée et enregistrée pour nourrir l''analyse de risque ?', '4.32', 'Une évaluation du risque lié à la préparation est effectuée par la pharmacie qui la réalise. Une recherche bibliographique appropriée permet de connaître les données toxicologiques et cliniques relatives aux substances actives et aux excipients de la préparation.', 37),
('Q38', 38, 'LD1 34.', '1.6', 'Des analyses de risque sont-elles réalisées pour le choix des installations et équipements, notamment des EPC selon les substances manipulées ?', 'LD1 34.', 'Le choix des installations et équipements fait l’objet d’une analyse de risques préalable et documentée, prenant en compte la nature des produits manipulés,la protection des personnes et de l’environnement.', 38),
('Q39', 39, '5.61', '1.6', 'Une analyse de risque relative à la réattribution des préparations aux patients est-elle réalisée ?', '5.61', 'On entend par réattribution des préparations terminées la dispensation d’une préparation à un patient alors qu’elle était initialement destinée à un autre patient. Elle fait l’objet d’une analyse de risque et d’une procédure.', 39),
('Q40', 40, '9.1', '2.1', 'Le système d''assurance qualité prévoit-il une auto-inspection vérifiant le respect des BPP (procédure et grille d''évaluation) ?', '9.1', 'L’auto-inspection fait partie du système d’assurance de la qualité et est réalisée de façon répétée en vue de contrôler la mise en oeuvre et le respect des Bonnes Pratiques de Préparation (BPP) et de proposer des mesures correctives nécessaires.', 40),
('Q41', 41, '9.2', '2.1', 'Le système d''assurance qualité prévoit-il une auto-inspection régulière ?', '9.2', 'Le personnel, les locaux, le matériel, les documents, la préparation (au sens production), le contrôle de la qualité, la libération pharmaceutique, les dispositions prises pour traiter les réclamations et les rappels et le système d’auto-inspection sont examinés à intervalles réguliers, de façon à vérifier leur conformité avec les principes d’assurance de la qualité.', 41),
('Q42', 42, '9.3', '2.1', 'La procédure précise-t-elle que les auto-inspections sont conduites par des personnes compétentes n''intervenant pas directement dans le procédé observé ?', '9.3', 'Des auto-inspections sont conduites préférentiellement par des personnes n’intervenant pas directement dans le procédé observé mais compétentes dans le domaine.', 42),
('Q43', 43, '9.4-b', '2.1', 'La traçabilité de la personne ayant réalisé l''auto-inspection est-elle assurée ?', '9.4', 'Toutes les auto-inspections font l’objet d’un compte rendu. Les rapports contiennent toutes les observations faites pendant les auto-inspections et, le cas échéant, des propositions de mesures correctives. Des comptes rendus concernant les mesures prises ultérieurement sont également rédigés.', 43),
('Q44', 44, '9.4-c', '2.1', 'Les comptes rendus d''auto-inspection, avec les mesures correctives proposées le cas échéant, sont-ils établis ?', '9.4', 'Toutes les auto-inspections font l’objet d’un compte rendu. Les rapports contiennent toutes les observations faites pendant les auto-inspections et, le cas échéant, des propositions de mesures correctives. Des comptes rendus concernant les mesures prises ultérieurement sont également rédigés.', 44),
('Q45', 45, '9.4-d', '2.1', 'Les comptes rendus sur les résultats des mesures prises à la suite des auto-inspections sont-ils établis ?', '9.4', 'Toutes les auto-inspections font l’objet d’un compte rendu. Les rapports contiennent toutes les observations faites pendant les auto-inspections et, le cas échéant, des propositions de mesures correctives. Des comptes rendus concernant les mesures prises ultérieurement sont également rédigés.', 45)
ON CONFLICT (id) DO NOTHING;
