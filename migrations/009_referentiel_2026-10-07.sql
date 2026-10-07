-- Référentiel BPP version 2026-10-07 (généré par tools/referentiel.py depuis referentiel_BPP_SFPO.xlsx).
-- Remplace sections et questions ; les réponses suivent leur question (colonne « Ancien code »).
CREATE TABLE IF NOT EXISTS referentiel_info (id INT PRIMARY KEY DEFAULT 1 CHECK (id = 1), version TEXT NOT NULL, imported_at TIMESTAMPTZ NOT NULL DEFAULT now());
DO $$ BEGIN
  IF COALESCE((SELECT version FROM referentiel_info), 'initiale') <> 'initiale' THEN
    RAISE EXCEPTION 'Référentiel en base : %, attendu : initiale', COALESCE((SELECT version FROM referentiel_info), 'initiale');
  END IF;
END $$;

-- Textes officiels des références
CREATE TABLE IF NOT EXISTS ref_texts (ref TEXT PRIMARY KEY, texte TEXT NOT NULL);
DELETE FROM ref_texts;  -- la feuille « Références BPP » fait foi
INSERT INTO ref_texts (ref, texte) VALUES
('1.01', 'Afin de protéger la santé humaine, les préparations pharmaceutiques sont réalisées de façon à garantir une qualité constante, appropriée à leur usage. Pour atteindre cet objectif elles sont réalisées en conformité avec les exigences définies dans le présent texte.'),
('1.02', 'Les pharmacies à usage intérieur et les pharmacies d''officine disposent d’un système d’assurance qualité qui intègre l’ensemble des règles de bonnes pratiques présentées dans ce texte. Ce système est documenté et contrôlé et son efficacité est surveillée.'),
('1.03', 'Les concepts fondamentaux de la gestion de la qualité, des Bonnes Pratiques de Préparation (BPP) et de la gestion du risque sont étroitement liés. Ils sont décrits ci-après en vue de souligner leurs relations réciproques et leur importance fondamentale dans la production et le contrôle des
préparations pharmaceutiques.'),
('1.04', 'La gestion de la qualité est un concept large qui couvre tout ce qui peut, individuellement ou collectivement, avoir une influence sur la qualité d’un produit. Elle représente l’ensemble des dispositions prises pour garantir que les préparations sont conformes aux spécifications attendues et de qualité requise pour l’usage auquel elles sont destinées. La gestion de la qualité intègre les BPP.'),
('1.05', 'Le système d’assurance qualité est soumis à une évaluation de son efficacité et de son adéquation entre le présent texte et les pratiques mises en oeuvre :
-un système documentaire est mis en place et maîtrisé ;
-les préparations sont formulées et réalisées selon l’état des connaissances scientifiques, médicales et pharmaceutiques ;
-les procédés de préparation et de contrôle sont clairement décrits et les règles figurant dans le présent texte sont appliquées ;
-une fois réalisées, les préparations n’entrent dans le circuit de dispensation qu’une fois contrôlées et libérées conformément aux procédures établies ;
-des dispositions sont prises pour garantir la qualité des préparations jusqu’à leur date de péremption et leur délai limite d’utilisation après ouverture.'),
('1.06', 'Les BPP constituent un des éléments de la gestion de la qualité qui garantit que les préparations pharmaceutiques sont réalisées et contrôlées de façon cohérente, selon leurs spécifications et les normes de qualité adaptées à leur usage.'),
('1.07', 'Les BPP s’appliquent à la fois à la production et au contrôle de la qualité des préparations pharmaceutiques. Les exigences fondamentales des BPP sont les suivantes :
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
-les lots ne sont libérés qu’après vérification et attestation de leur conformité aux spécifications requises ;
-les réclamations et les non-conformités concernant les préparations pharmaceutiques, les MPUP et les articles de conditionnement sont examinées et étudiées afin de prendre les mesures correctives adaptées.'),
('1.08', 'Le contrôle de la qualité fait partie des BPP (cf. Chapitre 6). Il concerne l’échantillonnage, les spécifications et le contrôle, ainsi que les procédures d’organisation, de documentation et de libération qui garantissent que les contrôles qualité nécessaires et appropriés sont réellement effectués. Les
MPUP, les articles de conditionnement, les produits intermédiaires, les préparations utilisées pour la réalisation d’autres préparations et les préparations terminées ne sont libérées qu’après vérification de leur qualité et de leur conformité aux spécifications.'),
('1.09', 'La nature du contrôle de la qualité est définie et justifiée en fonction de l''analyse de risque réalisée pour la préparation concernée.'),
('1.10', 'Après analyse des réclamations et des non-conformités, il est recommandé de réaliser des revues qualités portant notamment sur les préparations pour lesquelles un écart ou une modification substantielle a été relevée. Ces revues sont menées afin de vérifier la répétabilité des procédés existants, la pertinence des spécifications initialement décrites dans le dossier de préparation (cf. Annexe II) pour les MPUP, les articles de conditionnement, les produits intermédiaires et les préparations terminées. Ces revues permettent de mettre en évidence toute évolution et d’identifier les améliorations à apporter aux produits et aux procédés. Elles alimentent l’analyse globale du risque lié à la préparation et sont normalement menées et documentées selon une périodicité appropriée et justifiée. Elles prennent en compte les revues précédentes. Elles comprennent notamment le suivi des éléments suivants :
-Les MPUP et les articles de conditionnement utilisés pour la préparation, notamment ceux provenant de nouvelles sources d’approvisionnement, ainsi que la traçabilité de la chaîne d’approvisionnement des substances actives ;
-les résultats des contrôles qualité des préparations terminées ;
-les lots non conformes aux spécifications établies ainsi que les investigations correspondantes ;
-les déviations significatives et les non-conformités, les investigations correspondantes et l''efficacité des actions correctives et préventives prises en conséquence ;
-les modifications intervenues sur les procédés ou sur les méthodes d''analyse ;
-les retours, réclamations et rappels liés à des problèmes de qualité ainsi que les investigations correspondantes ;
-la pertinence de toute mesure corrective antérieure relative au procédé de préparation ou aux équipements ;
-la qualification des principaux équipements et de leurs utilités, par exemple les installations de traitement de l’air, de production et de distribution de l’eau ou de gaz comprimés ;
-les contrats et/ou cahiers des charges et/ou plannings de maintenance technique afin de s''assurer qu''ils sont à jour.'),
('1.11', 'L’appréciation du rapport bénéfice/risque permet d’évaluer les dangers potentiels et sert de base pour décider si des mesures de réduction des risques sont à appliquer, ou si le risque existant peut être accepté.'),
('1.12', 'Quel que soit le risque associé à la réalisation d''une préparation et préalablement à sa réalisation, une analyse pharmaceutique est réalisée par le pharmacien qui reçoit la demande. Un exemple d’outil d’aide à l’analyse pharmaceutique et réglementaire est proposé (cf. Annexe I).'),
('1.13', 'Une évaluation de la valeur ajoutée et de la faisabilité technique de la préparation est réalisée.
* la valeur ajoutée est estimée en considérant pour chaque préparation notamment :
- l''intérêt pharmaco-thérapeutique ;
- la meilleure acceptabilité possible pour une observance renforcée ;
- l’appréciation du bénéfice/risque.
* la faisabilité technique est estimée en considérant pour chaque préparation :
- la présence de procédures générales et de modes opératoires ;
- la présence de matériel et locaux conformes à la réalisation de la forme pharmaceutique ;
- la présence d’un personnel formé ;
- une analyse de la formule de la préparation.'),
('1.14', 'D’un point de vue pratique, un dossier de préparation en trois parties est à rédiger afin de regrouper toutes les informations nécessaires au bon déroulement de la préparation (cf. Annexe II).'),
('1.15', 'Une analyse technico-réglementaire est un préalable nécessaire à la prise de décision de réalisation de la préparation. Elle est renseignée par le pharmacien qui réalise la préparation ou le donneur d’ordre en cas de sous-traitance. Les questions essentielles portent sur :
- les renseignements concernant la préparation ;
- le positionnement dans l’arsenal thérapeutique (justification de l’intérêt pharmacothérapeutique);
- la valeur ajoutée de la préparation ;
- l’évaluation du risque de la préparation ;
- la faisabilité technique. 
En cas de questionnement, les éléments relatifs à la prise de décision de la réalisation de la préparation ou de sa sous-traitance sont documentés. Un exemple de démarche d’analyse est proposé dans l’annexe II - partie 1.'),
('1.16', 'L’évaluation du risque de la préparation permet de définir les niveaux d’exigences adaptés à la réalisation de cette dernière. Cette évaluation prend en compte notamment la substance active, la voie d''administration, la forme pharmaceutique, les opérations pharmaceutiques réalisées et le nombre de patients potentiels pour lesquels la préparation est réalisée.
Un tableau permettant une catégorisation des préparations pharmaceutiques est proposé (cf. Annexe III).
La classification des préparations en 3 catégories facilite l’application des conditions requises pour l’exécution et le contrôle des préparations.
Elle permet de discriminer les préparations susceptibles de présenter directement ou indirectement un danger pour la santé : risque faible, risque moyen et risque élevé, en fonction des paramètres critiques de la préparation. Le niveau de production annuel est un facteur susceptible de minorer ou de majorer le risque au regard de l’effectif du groupe de patients amené à recevoir la préparation.'),
('1.17', 'La réalisation d’une préparation n’est entreprise qu''après vérification par le pharmacien de sa conformité aux textes en vigueur (notamment au regard de certaines décisions d''interdiction ou de restriction de préparation ou d’inscription sur la liste des substances vénéneuses). Dans le cas où une
préparation est inscrite au Formulaire national de la Pharmacopée française, le pharmacien se conforme à la monographie en vigueur.'),
('1.18', 'Si la décision de donner l’ordre de réaliser la préparation est prise par le pharmacien, les éléments suivants sont documentés :
- la description du procédé de préparation, y compris les contrôles effectués le cas échéant ;
- la documentation relative au développement galénique de la préparation (information sur d’éventuels lots pilotes, recherche bibliographique…) ;
- l''étiquetage et les éventuelles informations liées aux modalités d’administration de la préparation. Cette documentation est adaptée à la catégorie de la préparation.'),
('1.19', 'Si le pharmacien n''est pas en mesure de réaliser la préparation, il la sous-traite selon la réglementation en vigueur et dans les conditions prévues par le présent texte.'),
('1.20', 'Le pharmacien refuse de réaliser et de dispenser une préparation s''il estime que celle-ci n''est pas conforme à l''état des connaissances scientifiques, médicales et pharmaceutiques et/ou que celle-ci est dangereuse au regard de l’appréciation du risque décrit ci-dessus.'),
('1.21', 'En cas d’impossibilité de réalisation de la préparation, il le notifie et propose au prescripteur et/ou donneur d’ordre, si possible, une alternative.'),
('1.22', 'Pour le cas des demandes exceptionnelles de préparations en urgence, une évaluation du risque, ainsi qu’une fiche d’instruction de préparation, sont réalisées. Les éléments du dossier de préparation sont complétés a posteriori. Dans tous les cas, un dossier de lot accompagne la préparation.'),
('2.01', 'La mise en place et le maintien d''un système d''assurance de la qualité satisfaisant, de même que la qualité de la réalisation des préparations, reposent sur l’implication de l''ensemble du personnel. Pour cette raison, la pharmacie dispose d''un personnel qualifié, en nombre suffisant pour mener à bien toutes les tâches qui lui incombent. Les responsabilités individuelles sont clairement définies et comprises par les intéressés et l’ensemble de l’équipe. Tous les membres du personnel ont connaissance des principes d’assurance qualité qui concernent leurs activités ; il convient de leur assurer une formation au poste de travail et une formation continue permettant notamment, de connaître les instructions d''hygiène et de sécurité en rapport avec l''activité exercée.'),
('2.02', 'La réalisation de la préparation est menée, sous la responsabilité du pharmacien, par des personnes compétentes et qualifiées, et suivant une formation continue adaptée aux tâches réalisées conformément aux textes en vigueur. Le secret professionnel s’impose à l’ensemble du personnel.'),
('2.03', 'Le niveau de formation des membres du personnel est adapté aux tâches qu’ils effectuent.'),
('2.04', 'Le personnel a accès à toute la documentation nécessaire relative à son activité.'),
('2.05', 'Le pharmacien a la responsabilité de la décision de la réalisation des préparations.'),
('2.06', 'En cas d’absence du pharmacien désigné comme responsable des préparations, un pharmacien formé pour cette activité est nommé. Le remplaçant prend connaissance des tâches qui lui sont attribuées et est informé de l’engagement de sa responsabilité.'),
('2.07', 'L’établissement dispose d’un effectif suffisant en personnel qualifié et réévalué régulièrement pour assurer, en toutes circonstances, les achats, le stockage, la production, le contrôle, la libération des préparations pharmaceutiques, les tâches d’entretien, de maintenance et de suivi des équipements et des locaux. Certaines de ces opérations peuvent être sous-traitées dans les conditions prévues au chapitre 7.'),
('2.08', 'Un organigramme présentant les liens hiérarchiques et fonctionnels est établi pour l’organisation du secteur de préparation et de contrôle au sens des chapitres 5 et 6.'),
('2.09', 'Les tâches et les domaines de responsabilité des membres du personnel sont détaillés par écrit dans des fiches de poste et/ou de fonction.'),
('2.10', 'Certaines tâches peuvent être déléguées à des personnes présentant des qualifications équivalentes.'),
('2.11', 'Tout le personnel entrant dans les zones de préparation, de contrôle et de stockage respecte les instructions générales et spécifiques d''habillage, de déshabillage, de protection et d''hygiène.'),
('2.12', 'Le pharmacien désigné comme responsable des préparations s’assure du respect des règles des Bonnes Pratiques de Préparation (BPP) et de la qualité des préparations réalisées.'),
('2.13', 'Lorsque le pharmacien désigné comme responsable des préparations n’est plus en mesure d’assurer sa responsabilité, il en informe le pharmacien gérant ou titulaire le cas échéant. Le directeur de l’Agence régionale de santé peut également en être informé.'),
('2.14', 'Les membres du personnel ont reçu une formation initiale, selon les textes en vigueur, appropriée aux tâches qui leur sont attribuées, et suivent un parcours de formation.'),
('2.15', 'Une formation est donnée à tout le personnel appelé à entrer dans les locaux de préparation (personnel d’entretien inclus).'),
('2.16', 'Une formation spécifique est réalisée pour adapter les connaissances et les compétences du personnel affecté aux tâches le nécessitant, comme par exemple, la réalisation de préparations homéopathiques ou à base de plantes, la réalisation de préparations stériles, la manipulation de produits à risque, le contrôle et la maintenance (y compris le nettoyage).'),
('2.17', 'La formation du personnel est documentée et réévaluée périodiquement. Elle peut être organisée au sein de l’établissement ou par des organismes de formation habilités.'),
('2.18', 'Des programmes détaillés consacrés à l''hygiène sont établis et adaptés aux différents besoins du personnel. Ils comportent des procédures relatives à la santé, à l''hygiène et à l''habillage du personnel. Les procédures sont comprises et observées de façon stricte, notamment pour toute personne appelée à pénétrer dans les zones de préparation et de contrôle. Le personnel est formé aux règles d’hygiène et de sécurité.'),
('2.19', 'Des procédures relatives à l’hygiène du personnel, au port de vêtements et chaussures de travail adaptés sont établies en fonction des travaux à effectuer.'),
('2.20', 'Il convient de s’assurer de l’absence de risque de contamination, tant pour le personnel que pour la préparation.'),
('2.21', 'Des mesures appropriées évitent la contamination par contact direct entre les mains de l’opérateur et le produit. Le port de gants est recommandé.'),
('2.22', 'Pour les préparations de catégorie 1 (cf. Annexe III), l’utilisation d’une tenue adaptée et propre est obligatoire, incluant le port de la charlotte.'),
('2.23', 'Pour les préparations de catégories 2 et 3, le port de la charlotte, l’utilisation de sur-chaussures et d’une sur-blouse ou d’une tenue propre, dédiée et adaptée à la zone de préparation est obligatoire. L’utilisation de cache-barbe est, le cas échéant, recommandée.'),
('2.24', 'Des mesures appropriées sont prises en vue d’éviter toute contamination provenant de l’extérieur de la zone de préparation.'),
('2.25', 'Les équipements de protection individuelle (EPI) sont adaptés et mis à disposition en nombre suffisant pour le personnel. Leur utilisation est décrite ainsi que leurs conditions de changements ou de retraits. Les montres-bracelets, le maquillage (incluant le vernis à ongle), les bijoux et autres objets personnels tels que les téléphones portables ne sont pas autorisés dans ces zones.'),
('2.26', 'Il est de la responsabilité du pharmacien désigné comme responsable des préparations de prévoir des instructions qui garantissent que les opérateurs signalent toute affection pouvant avoir une influence sur la qualité de la préparation réalisée. Il prend alors les dispositions nécessaires pour y remédier.'),
('2.27', 'Dans les zones de préparation et de stockage, il est interdit de manger, de boire, de mâcher ou de fumer, ainsi que de garder de la nourriture, des boissons, du tabac ou des effets personnels. D’une façon générale, toute pratique non hygiénique est prohibée dans les zones de préparation et dans toute zone où les préparations pourraient être affectées.'),
('3.01', 'Les matériels et installations sont adaptés aux opérations à effectuer. Ils permettent de prévenir toute atteinte à la qualité des produits.'),
('3.02', 'L’utilisation d’équipements de protection collective (EPC) et/ou d’équipements de protection individuelle (EPI) permet de garantir la protection du personnel.'),
('3.03', 'Les matériels et installations sont conçus, construits, aménagés, utilisés et entretenus de façon à convenir aux opérations à effectuer et à réduire les risques d’erreur. Les matériels et installations sont adaptés au type de préparation à effectuer et aux risques liés aux substances manipulées. Leur taille et leur nombre sont suffisants pour permettre un déroulement logique et cohérent des opérations et une séparation appropriée des activités. Le principe de « marche en avant » est à privilégier.'),
('3.04', 'Des programmes de qualification, de contrôle et de maintenance des locaux et des équipements susceptibles d’intervenir sur la qualité des préparations sont définis :'),
('3.05', 'L’entretien, les maintenances préventives et curatives des locaux et des équipements, sont réalisés sans entraîner de risque pour le personnel et les produits. Le pharmacien désigné comme responsable des préparations est informé de ces opérations.'),
('3.06', 'L’utilisation et l’entretien des installations et matériels permettent de minimiser les risques d’erreur et de contact avec des impuretés, tels que les contaminations croisées ainsi que les accumulations de poussières et de saletés.'),
('3.07', 'Les sols, murs, plafonds et autres surfaces apparentes sont conçus pour permettre un nettoyage et, le cas échéant, une désinfection aisée.'),
('3.08', 'Les opérations de nettoyage n’entraînent pas de contamination.'),
('3.09', 'Des mesures efficaces sont prises pour éviter que des insectes et d’autres animaux ne s’introduisent dans les locaux.'),
('3.10', 'Lorsque la qualité du matériel ou du produit exige des conditions d’environnement maîtrisées, le respect de ces conditions est contrôlé.'),
('3.11', 'Les locaux disposent des aménagements et installations adaptés à l’hygiène, à la protection et à la sécurité du personnel compte tenu de la nature des produits détenus et manipulés.'),
('3.12', 'Toutes les zones sont propres, rangées et éclairées de façon appropriée.'),
('3.13', 'L’accès aux zones de préparation et de contrôle est limité aux personnes autorisées par le pharmacien désigné comme responsable des préparations.'),
('3.14', 'Un local est un endroit fermé par une porte ; une zone est un emplacement dédié à une tâche dans un local.'),
('3.15', 'Pour la réalisation des préparations de catégories 1, 2 et 3 (cf. annexe n°III) non stériles ou non cancérogènes, mutagènes ou génotoxiques (CMR), l’utilisation de zones est possible.'),
('3.16', 'Des locaux, des installations et des équipements spécifiques sont réservés'),
('3.17', 'La destination des locaux et de leurs différentes zones est clairement identifiée.'),
('3.18', 'Les préparations sont réalisées dans des locaux différents et adaptés selon les caractéristiques de chaque préparation. Des installations dédiées sont exigées pour la réalisation des préparations stériles et les préparations présentant un risque pour le personnel et l’environnement (cf. LD2).'),
('3.19', 'Les risques de contamination varient en fonction de la MPUP et du procédé utilisés. Ils sont pris en compte lors de la conception et de l’aménagement des locaux.'),
('3.20', 'Les locaux et zones de préparation sont correctement ventilés par des installations adaptées à la fois aux produits manipulés, aux opérations effectuées et à l’environnement.'),
('3.21', 'Les locaux et zones de préparation sont entretenus selon un plan de nettoyage afin d’éviter tout risque de contamination chimique, microbiologique ou radiopharmaceutique. Les surfaces de travail sont lisses, imperméables, sans fissures et sont facilement nettoyables.'),
('3.22', 'Le matériel et les produits sont stockés et disposés de façon à réduire le risque de confusion entre les différents produits ou leurs composants, à éviter les contaminations croisées et à diminuer le risque de s’affranchir d’une étape de préparation ou de la réaliser incorrectement.'),
('3.23', 'L’organisation de la zone de préparation est adaptée si les productions d’une ou de plusieurs préparations sont organisées « par campagne ».'),
('3.24', 'Les dispositions suivantes sont respectées : * élimination des déchets avec mise en place de filières adaptées à l’élimination des déchets selon leur dangerosité'),
('3.25', 'Lorsque des substances ou des produits solides, pulvérulents et liquides volatiles sont utilisés, des précautions particulières adaptées sont prises afin d’éviter la production et la dissémination de contaminants.'),
('3.26', 'Des locaux distincts sont réservés aux contrôles. En cas d’impossibilité, a minima, une zone dédiée au contrôle est identifiée.'),
('3.27', 'Les locaux et zones de contrôle sont conçus en vue de leur usage. Ils sont suffisamment spacieux pour permettre d’éviter les confusions et les contaminations croisées.'),
('3.28', 'Les locaux et zones de contrôle sont en principe séparés des locaux et zones de préparation. Cependant, pour limiter la dissémination de contaminants ou pour faciliter le contrôle en « ligne » des préparations, l’activité de contrôle peut s’effectuer en zone de préparation.'),
('3.29', 'Lorsque des mises en culture de microorganismes sont réalisées, elles sont effectuées dans un local différent du local de préparation.'),
('3.30', 'Les locaux et zones de stockage sont de taille suffisante pour permettre un stockage convenable des différentes catégories de matériels et de produits. Ces catégories comprennent, par exemple, les MPUP, les articles de conditionnement, les préparations servant à la réalisation d’autres préparations, les préparations terminées, les préparations en attente de conditionnement, le matériel et les produits en quarantaine, le matériel et les produits libérés, refusés, retournés ou rappelés.'),
('3.31', 'Les locaux et zones de stockage sont conçus ou adaptés, de façon à garantir le respect des conditions de stockage requises. Les contrôles sont documentés (température et hygrométrie).'),
('3.32', 'Les MPUP et les articles de conditionnement peuvent être stockés dans les locaux de préparation.
Dans ce cas, le stock est limité et l’agencement des locaux et/ou des équipements est conçu de manière à éviter les contaminations croisées.'),
('3.33', 'Le matériel et les produits en quarantaine, refusés, retournés ou rappelés sont stockés séparément dans un local ou une zone dédiée et identifiée comme telle.'),
('3.34', 'Les vestiaires sont facilement accessibles et d’une taille adaptée au nombre de personnes intervenant dans les activités de préparation. Par ailleurs, les toilettes et les sanitaires ne communiquent pas directement avec les zones de préparation.'),
('3.35', 'Les locaux et zones de nettoyage du matériel sont de taille suffisante pour permettre cette activité. Le bon fonctionnement des équipements et installations est contrôlé périodiquement.'),
('3.36', 'Les locaux et zones techniques sont accessibles, de préférence sans passage via les zones de préparation.'),
('3.37', 'Les locaux et zones prévus pour l’élimination des déchets sont de taille suffisante et permettent la manipulation des déchets de manière ergonomique.'),
('3.38', 'La conception et l’implantation de ces locaux et zones annexes sont prévues pour éviter les risques de contamination des autres zones.'),
('3.39', 'Le matériel de préparation est conçu de façon à permettre un nettoyage facile. Il est maintenu en parfait état de propreté, au sec et à l’abri de la poussière.'),
('3.40', 'Les matériels, les instruments de mesure, de pesée, d’enregistrement et de contrôle présentent la précision nécessaire. Ils sont étalonnés selon la réglementation en vigueur. Leur bon fonctionnement est vérifié à intervalles réguliers et avant utilisation. En outre, les protocoles de ces contrôles et les traces de leur réalisation sont conservés dans leur cahier de suivi.'),
('3.41', 'Le système informatique et les logiciels sont conçus, installés et vérifiés de façon à éviter les erreurs,
permettre le traitement des demandes urgentes et respecter le secret médical. Ils permettent la sauvegarde, l’archivage et la protection des données conformément à la législation en vigueur.'),
('3.42', 'Le système informatique et les logiciels sont prévus pour s’intégrer dans le système d’assurance qualité de l’établissement et de sécurité informatique.'),
('3.43', 'Tout matériel défectueux est retiré des zones de préparation et de contrôle dans les meilleurs délais. En cas d’impossibilité de retrait immédiat de la zone, une identification est portée sur le matériel afin d’en interdire l’utilisation.'),
('3.44', 'Le pharmacien désigné comme responsable des préparations définit une liste qui comprend les matériels, les équipements et les installations de préparation ou de contrôle considérés comme critiques (par exemples, le système informatique, les balances). Ils sont qualifiés avant utilisation : les dossiers de qualification sont conservés pendant toute leur "durée de vie".'),
('3.45', 'La qualification, définie dans le glossaire du présent texte, est divisée en trois étapes :
- qualification d’installation 
- qualification opérationnelle 
- qualification de performance'),
('3.46', 'Lors de la réception des matériels et installations neufs, ces 3 qualifications sont précédées de la qualification de conception pour leur acquisition.'),
('3.47', 'Les matériels et installations de préparation sont adaptés et conçus, installés, entretenus et nettoyés de manière à garantir une production de médicaments de qualité appropriée.'),
('3.48', 'Le pharmacien désigné comme responsable des préparations prend la décision finale de qualification des matériels et des installations. Pour cela, il tient compte des références normatives et peut recourir à une évaluation du risque. Il définit les conditions de requalification et leur périodicité.'),
('3.49', 'Entre deux opérations de qualification, le contrôle de certains paramètres permet de s’assurer du bon fonctionnement des matériels et installations. La fréquence, les modalités de réalisation et les critères d’acceptation de ces contrôles sont définis par le pharmacien désigné comme responsable des préparations.'),
('4.01', 'Une documentation exhaustive, révisée, imprimée ou sur support électronique est un outil de transmission et de conservation de l''information essentiel au système qualité pharmaceutique. Elle permet d’assurer la conformité des opérations aux exigences du présent texte. Que le support soit électronique ou papier, il est nécessaire que le système soit protégé contre des modifications non autorisées, contre les pertes de données et que les données demeurent disponibles pendant toute la durée de conservation exigée pour les documents.'),
('4.02', 'Des documents clairs et lisibles évitent les erreurs inhérentes aux communications orales et garantissent la traçabilité de la préparation pharmaceutique. Les données manuscrites sont limitées et validées.')
ON CONFLICT (ref) DO UPDATE SET texte = EXCLUDED.texte;
INSERT INTO ref_texts (ref, texte) VALUES
('4.03', 'En fonction des risques identifiés par l’établissement, il peut être mis en place un système informatisé pour gérer les aspects documentaires et la réalisation des préparations pharmaceutiques.'),
('4.04', 'La documentation est gérée par une procédure de maîtrise des documents qui intègre et respecte le cadre fixé par les règles générales de gestion documentaire définies au sein de l’établissement.'),
('4.05', 'Il convient de documenter tout évènement significatif ayant trait à la qualité des produits, y compris les appréciations du risque et les justificatifs ayant conduit aux variations par rapport aux exigences figurant dans le présent texte.'),
('4.06', 'Tous les types de documents sont définis et respectés. Les exigences s’appliquent de la même manière à toutes formes de supports documentaires mis en oeuvre. De nombreux documents peuvent exister sous des formes hybrides, c’est-à-dire avec certains éléments sous forme électronique et d’autres sous forme papier. Des contrôles appropriés sont mis en place pour garantir l’intégrité des enregistrements pendant leur durée d’utilisation et d’archivage.'),
('4.07', 'La reproduction des documents ne permet pas l''introduction d''une quelconque erreur au cours du processus de reproduction. Une vigilance particulière est apportée pour la diffusion et l’utilisation de version à jour.'),
('4.08', 'Les documents sont approuvés, signés et datés. Ils sont établis par des personnes autorisées. Le contenu des documents n''est pas ambigu et est identifiable de façon unique. La date de prise d''effet est définie.'),
('4.09', 'Les documents sont présentés de façon ordonnée et sont faciles à vérifier. Les procédures, les instructions de travail et les modes opératoires sont écrits dans un style obligatoirement directif.'),
('4.10', 'Les documents inclus dans le système de gestion de la qualité sont régulièrement révisés et tenus à jour.'),
('4.11', 'Les documents ne sont pas manuscrits ; toutefois, lorsqu''un document nécessite l''inscription de données, l''espace qui leur est réservé est suffisant. Les saisies manuscrites sont faites de manière claire, lisible et indélébile. Le cas échéant leur(s) auteur(s) est identifié(s) ainsi que la date du relevé.'),
('4.12', 'Les documents nécessaires sont :
- les procédures générales qui donnent les indications nécessaires à la réalisation et à l’organisation de l’ensemble des opérations ;
- les dossiers de préparation qui permettent la création des instructions de préparation (fiches de préparation), de conditionnement et de contrôle ;
- les dossiers de lot, comprenant notamment les enregistrements.'),
('4.13', 'Les procédures générales décrivent les différents processus liés aux opérations de préparation et de contrôle, et notamment le nettoyage, l''habillage, le contrôle de l’environnement, la réception des MPUP et des articles de conditionnement, le stockage, l''échantillonnage, l''analyse des prescriptions, l''étiquetage et la faisabilité de la préparation.'),
('4.14', 'Le processus de réception des MPUP ou des articles de conditionnements fait l’objet d’une procédure. Chaque livraison est enregistrée et contrôlée. Les MPUP font l’objet d’un enregistrement dans un registre .'),
('4.15', 'Le contrôle à réception, l’étiquetage interne, la mise en quarantaine, le stockage des MPUP, des articles de conditionnement et des autres produits font également l’objet de procédures.'),
('4.16', 'Des procédures d’échantillonnage pour les MPUP, les articles de conditionnement et les préparations terminées sont établies ; elles comportent notamment des indications sur la (ou les) personne(s) autorisée(s) à prélever des échantillons, les méthodes et le matériel à utiliser, les quantités à prélever. Elles précisent toutes les précautions de manipulation pour la sécurité des personnes et de l’environnement et toutes les précautions à observer en vue d’éviter la contamination du produit ou la détérioration de sa qualité. Des précisions relatives à l’échantillonnage sont disponibles au chapitre 6.'),
('4.17', 'Des procédures décrivant la réalisation des différentes formes pharmaceutiques sont établies.'),
('4.18', 'Des procédures sont établies pour les contrôles des MPUP, des articles de conditionnement et des préparations terminées détaillant les méthodes, le matériel à utiliser et les spécifications. Les contrôles effectués sont enregistrés. Les précisions relatives aux contrôles sont disponibles au chapitre 6.'),
('4.19', 'Des procédures sont établies, en fonction de la classe de propreté ISO et de la nature des préparations réalisées pour l’accès aux locaux ou zones ; l’entretien des locaux ou des zones et le cas échéant leur maintenance ; la gestion des déchets ; la surveillance de l’environnement.;'),
('4.20', 'Des procédures sont établies, en tant que de besoin, pour l''utilisation des matériels et des équipements, leur entretien, leur étalonnage et leur maintenance.'),
('4.21', 'Des procédures sont établies pour les opérations de qualification des matériels et des équipements dont les résultats font partie intégrante de la validation des procédés de préparation et de contrôle.'),
('4.22', 'Les matériels, les équipements et les zones critiques (ex : postes à flux d’air unidirectionnel, isolateurs, balances, dispositifs de traitement d''eau et d’air) sont accompagnés d''un "cahier de suivi" pouvant être dématérialisé et mentionnant, selon les cas, toutes les validations, les étalonnages, les opérations d''entretien, de nettoyage, de qualification ou de maintenance avec les dates et le nom des personnes ayant effectué ces opérations et le nom de la societé en cas d’intervention extérieure. Il mentionne les actions correctives réalisées.'),
('4.23', 'Des procédures sont établies pour la formation, l’habillage, l’hygiène et la protection du personnel.'),
('4.24', 'Des procédures sont établies pour la libération (acceptation ou refus) des MPUP, des articles de conditionnement et des préparations terminées. Elles sont adaptées à la nature des préparations réalisées.'),
('4.25', 'Des procédures de gestion des anomalies et des réclamations sont établies et permettent au pharmacien de préconiser des solutions pour leurs traitements.'),
('4.26', 'Comme pour tout médicament, une procédure de rappel de préparation permet d’organiser le retour à la pharmacie, dans les meilleurs délais, de toute préparation se trouvant dans les services et unités de soins et, le cas échéant, auprès des patients.'),
('4.27', 'Des procédures sont établies pour le recueil des effets indésirables et des évènements indésirables graves (par exemple certaines infections nosocomiales) susceptibles d’être dus aux préparations pharmaceutiques ainsi que pour leur signalement aux autorités compétentes.'),
('4.28', 'En cas de signalement, il est indispensable de recueillir tous les éléments permettant d’étayer les évènements survenus et d’identifier le plus précisément la préparation concernée (par exemple le Code d’Identification de la Préparation Hospitalière [CIPH]).'),
('4.29', 'Pour les déclarations de pharmacovigilance, il est nécessaire d’utiliser le formulaire de déclaration en vigueur des médicaments et de conserver la préparation litigieuse de façon appropriée.'),
('4.30', 'Dans la mesure où il n''existe pas d''autorisation de mise sur le marché pour les préparations pharmaceutiques, l’élaboration d’un dossier regroupant (ou pouvant y faire référence) la documentation (par exemple RCP des spécialités) et le questionnement nécessaire à l’élaboration des fiches de préparation, de conditionnement et de contrôle est à constituer. L’analyse technico-réglementaire de la préparation, sa faisabilité, les spécificités de sa réalisation et de son contrôle sont décrits dans ce dossier. Un exemple de trame de dossier de préparation est proposé en Annexe II.'),
('4.31', 'Le dossier de préparation peut être réalisé pour plusieurs préparations de même composition qualitative quand les procédés de préparation et les méthodes de contrôle sont identiques. Il est rédigé par la pharmacie qui réalise la préparation.'),
('4.32', 'Une évaluation du risque lié à la préparation est effectuée par la pharmacie qui la réalise. Une recherche bibliographique appropriée permet de connaître les données toxicologiques et cliniques relatives aux substances actives et aux excipients de la préparation.'),
('4.33', 'Les éléments permettant la mise en évidence de la faisabilité technique de la préparation sont documentés.'),
('4.34', 'Cette partie du dossier de préparation regroupe les spécifications et instructions des produits intermédiaires, des préparations terminées et des articles de conditionnement. Elle met notamment en évidence les points critiques éventuels de la réalisation de la préparation. Elle est réalisée pour toutes les préparations. Elle permet la rédaction des formules et instructions de préparation et de conditionnement. Tous ces éléments sont à documenter et comprennent notamment :
- les spécifications pour les MPUP et le cas échéant, pour les articles de conditionnement ;
- les spécifications pour les produits intermédiaires et les préparations terminées ;
- les instructions de préparation qui comportent toutes les indications nécessaires pour la réalisation de la préparation (locaux, matériel, procédé…). Le nombre maximal d’unités par lot qui peut être réalisé doit garantir que l’impact d’un lot porte sur un nombre limité de patients.
Le nombre de patients potentiellement traités ne dépasse pas 250 pour une durée de traitement de 28 jours (voir définition du « lot » du glossaire).
- les instructions de conditionnement qui permettent que l’étape de conditionnement soit réalisée conformément aux spécifications attendues ;
- des procédures sont établies pour l''étiquetage des préparations terminées, en conformité avec la réglementation en vigueur (cf. notamment les dispositions des articles R. 5121-146-2 et R. 5121-146-3 du CSP). Un modèle de l’étiquetage utilisé peut-être conservé dans le dossier de préparation notamment dans le cas des préparations réalisées en séries.
De l’ensemble de ces instructions découlent une ou plusieurs fiche(s) de préparation et une ou plusieurs fiche(s) de conditionnement.'),
('4.35', 'La description des contrôles à réaliser en cours et en fin de préparation sont à renseigner dans le dossier de préparation.
De l’ensemble de ces instructions découlent une ou plusieurs fiche(s) de contrôle.'),
('4.36', 'Chaque préparation réalisée fait l’objet d’un dossier de lot fondé notamment sur les fiches issues du dossier de préparation. Il est constitué par la pharmacie qui réalise la préparation.'),
('4.37', 'Le dossier de lot de préparation contient toutes les informations et documents relatifs aux MPUP et aux articles de conditionnement mis en oeuvre, au procédé de préparation, à son étiquetage, à son contrôle (y compris en cas de sous-traitance), à sa conservation, aux incidents survenus lors des opérations de préparation, de contrôles et de transport, aux rappels éventuels et à sa destruction éventuelle ainsi qu''aux raisons de celle-ci.'),
('4.38', 'Un dossier de lot comporte 5 parties :
- une partie préparation ;
-  une partie conditionnement ;
- une partie contrôle ;
- une partie libération pharmaceutique ;
- une partie gestion des anomalies ou retours/réclamations.'),
('4.39', 'Le dossier de lot contient ou fait référence aux enregistrements qui apportent la preuve des différentes actions entreprises pour démontrer la conformité aux instructions. Les enregistrements assurent la traçabilité de chaque lot de préparation, y compris sa délivrance et son expédition le cas échéant. Ils sont effectués au moment où chaque action est réalisée, de telle sorte que toutes les opérations concernant la réalisation et le contrôle des préparations soient tracées et reconstituées. Les enregistrements permettent un suivi des actions correctives éventuelles. Les enregistrements, ou leurs références, sont intégrés dans le dossier de lot correspondant à la préparation réalisée.'),
('4.40', 'Les éléments suivants sont à enregistrer dans le dossier de lot, au moment où chaque action est réalisée : •  pour la préparation : -  dénomination, dosage en substance(s) active(s) et forme pharmaceutique de la préparation ; -  numéro de lot de la préparation ; -  date de réalisation de la préparation et l’heure le cas échéant ; -  nom de la (des) personne(s) ayant contribué à la réalisation de la préparation ; -  s’il y a lieu, le nom et l’adresse de la pharmacie ou de l’établissement pharmaceutique sous-traitant ; -  date de péremption, date limite d’utilisation (DLU) après ouverture, le cas échéant ; -  pour chaque MPUP utilisée (substance(s) active(s) et excipient(s)) : dénomination de la MPUP, nom du fournisseur, numéro de lot ou nom et numéro de lot de la spécialité pharmaceutique utilisée, date de péremption ; -  quantités ou volumes théoriques préparés ; -  quantités pesées ou volumes mesurés (avec mention de la vérification prévue au chapitre 6) ; -  tickets de pesées et autres enregistrements relatifs à la préparation (diagramme de stérilisation par exemple) ; -  relevé des anomalies et incidents éventuels survenus au cours de la préparation. •  pour le conditionnement : -  type de conditionnement ; -  nombre d''unités à conditionner et nombre d’unités conditionnées ; -  étiquette (un exemplaire de l''étiquetage de la préparation peut-être collé ou joint à la fiche de préparation) et éventuellement la contre-étiquette ; -  relevé des anomalies et incidents éventuels survenus au cours du conditionnement ; -  les opérateurs sont identifiés. •  pour les contrôles : -  résultats datés et signés des contrôles réalisés en cours de préparation ; -  résultats datés et signés des contrôles physico-chimiques, pharmacotechniques, microbiologiques, et autres contrôles s''il y a lieu, réalisés sur la préparation terminée ; ces résultats et leurs conclusions sont conservés dans le dossier de lot, y compris en cas de sous-traitance totale ou partielle de ces contrôles ; -  tout autre document de contrôle nécessaire à la libération du lot ; -  relevé des anomalies et incidents éventuels survenus au cours des contrôles ; -  les opérateurs sont identifiés. •  autres documents le cas échéant : -  document relatif aux contrôles de l’environnement ; -  documentation relative aux retours et réclamations et rappels de lots ; -  certificat de destruction ; -  relevé d’anomalie(s) ; -  documents relatifs à la mise en échantillothèque de la préparation terminée. Note : Une copie des prescriptions des préparations magistrales peut être annexée au dossier de lot.'),
('4.41', 'Les éléments du dossier de lot permettent au pharmacien de prendre la décision de libération pharmaceutique de la préparation terminée.'),
('4.42', 'Le dossier de lot comprend la décision d’acceptation ou de refus (libération pharmaceutique) de la préparation terminée. Cette décision de libération comporte la date, le nom et la signature du pharmacien désigné comme responsable des préparations. Les données ne sont ensuite plus modifiables.'),
('4.43', 'Le registre des contrôles réalisés à réception des MPUP et des articles de conditionnement est à documenter le cas échéant.'),
('4.44', 'Le livre-registre des préparations est à documenter. Il correspond à l’ordonnancier des préparations prévu par le texte en vigueur. Chaque transcription ou enregistrement comporte un numéro d’ordre (qui constitue le numéro de lot le cas échéant) différent et chronologique ainsi que les mentions suivantes :
- la date de réalisation ou de délivrance de la préparation avec, s’il y a lieu, le nom, l’adresse de la pharmacie ou de l’établissement pharmaceutique sous-traitant et le numéro de lot de la préparation utilisé par la pharmacie sous-traitante;
- l’identité du prescripteur avec son adresse ou du service de soins de l’établissement pour les préparations magistrales ;
- le nom du patient et son adresse ou le nom et l’adresse de l’officine de pharmacie réalisant la dispensation, ou le nom du service de soins de l’établissement pour les préparations magistrales, le nom du service de soins de l’établissement ou du patient pour les préparations hospitalières ;
- la dénomination de la préparation avec notamment son dosage en substance(s) active(s), sa forme pharmaceutique et son conditionnement ;
- la composition qualitative et quantitative complète de la préparation avec indication du numéro de lot de chaque MPUP et du nom du fournisseur ;
- le nombre d’unités réalisées avec indication de la masse, du volume des substances actives engagées par lot et du nombre d’unités de prise pour les formes unitaires ;
- l’identification de la personne ayant réalisé la préparation avec, s’il y a lieu, le nom et l’adresse de la pharmacie sous-traitante.'),
('4.45', 'Un lien entre les informations contenues dans le dossier de lot et le livre-registre des préparations est possible. Les données conservées dans le dossier de lot sont alors enregistrées dans un système approprié et conservées suivant les mêmes modalités que le livre registre des préparations.'),
('4.46', 'Le numéro de lot de la préparation indiqué par la pharmacie sous-traitante permet d’assurer la traçabilité entre le sous-traitant et le patient.'),
('4.47', 'Aide à l''analyse pharmaceutique et réglementaire : selon règlement interne à l''établissement'),
('5.01', 'Les opérations de préparation suivent des instructions et des procédures définies. Elles répondent aux principes des Bonnes Pratiques de Préparation (BPP) en vue d’obtenir des préparations de qualité requise. Les spécificités de la préparation sont définies dans le dossier de préparation, notamment la partie 3 : « Spécifications, contrôle(s) et assurance de la qualité de la préparation pharmaceutique ».'),
('5.02', 'Une préparation n’est entreprise que si la pharmacie possède les moyens appropriés spécifiques (équipements, matériels, personnels, locaux…) pour la réaliser et la contrôler.'),
('5.03', 'Les écarts dans le procédé et les défauts observés sont tracés dans le relevé d’anomalies présent dans le dossier de lot de la préparation.'),
('5.04', 'Les opérations de préparation sont exécutées par du personnel qualifié au sens du CSP placé sous l’autorité technique du pharmacien désigné comme responsable des préparations.'),
('5.05', 'Les locaux, les équipements, les matériels (incluant les systèmes informatiques) et les installations sont appropriés aux opérations de préparation et sont en état de fonctionner.'),
('5.06', 'La préparation s’effectue sur la base de procédures écrites. Les opérations importantes à effectuer y sont indiquées de façon détaillée. Les différentes étapes de la préparation sont documentées (fiche de préparation).'),
('5.07', 'Toutes les mesures techniques et organisationnelles nécessaires sont prises pour éviter les confusions ou les erreurs.'),
('5.08', 'Les MPUP et les articles de conditionnement réceptionnés et les préparations terminées sont mis en quarantaine physiquement, et informatiquement le cas échéant, immédiatement après leur réception ou leur préparation.'),
('5.09', 'Seuls des MPUP et des articles de conditionnement approuvés et libérés en vue de leur usage peuvent être employés pour la préparation.'),
('5.10', 'Les MPUP et les articles de conditionnement sont stockés dans les conditions appropriées établies par le fabricant et de façon ordonnée en vue de permettre une rotation des stocks.'),
('5.11', 'Tous les matériels sont propres, stériles le cas échéant, et conservés à l’abri de l’humidité et de la poussière.'),
('5.12', 'Dans les opérations de préparation ou de conditionnement où cela se justifie, les rendements sont contrôlés et des bilans comparatifs effectués pour assurer qu’il n’y a pas d’écarts supérieurs aux limites acceptables définies par les spécifications (cf. Annexe II partie 3).'),
('5.13', 'A chaque étape de la préparation, les risques de contamination sont pris en compte.'),
('5.14', 'Lorsque des substances ou des produits pulvérulents sont utilisés, des précautions particulières sont prises en vue d’éviter la production et la dissémination de poussières.'),
('5.16', 'Les MPUP, les articles de conditionnement et les préparations terminées ou non sont clairement étiquetés à chaque étape de la préparation. Les étiquettes et les indications apposées sur les récipients et/ou sur l’équipement sont claires et permettent une identification univoque. Le cas échéant, les locaux ou les zones utilisés sont identifiés.'),
('5.17', 'Toutes les mesures techniques et organisationnelles nécessaires sont prises pour éviter les contaminations croisées.'),
('5.18', 'Les causes de contaminations croisées peuvent être le résultat d’une dissémination incontrôlée :
- de poussières, de gaz, de vapeur, d’aérosols ;
- de matériels ou organismes génétiques issus de substances actives, ou d’autres matières premières ou de produit en cours de préparation ;
- de résidus présents sur les équipements ou les vêtements des opérateurs.'),
('5.19', 'L’importance du risque de contamination croisée varie en fonction du procédé, de la nature du contaminant et de celle du produit potentiellement contaminé.'),
('5.20', 'La contamination croisée peut être évitée en portant une attention particulière à :
- la conception et l’utilisation des locaux et des équipements, tels que décrits au Chapitre 3 ;
- la conception des procédés de préparation et de conditionnement, par exemple l’utilisation de dispositifs à usage unique ;
- la mise en oeuvre de mesures techniques ou organisationnelles adéquates, y compris les procédés de nettoyage.'),
('5.21', 'Les résultats du processus de gestion du risque qualité servent de base pour définir la portée des mesures techniques et organisationnelles devant être mises en place afin de limiter les risques de contaminations croisées.'),
('5.22', 'Pour assurer la qualité des préparations, il convient d’utiliser des installations, des locaux, des équipements, du matériel ainsi que des procédés de préparation adéquats qui tiennent compte de la nature des préparations à réaliser.'),
('5.23', 'Le potentiel de risque inhérent à une préparation est estimé par une évaluation de risque. Plusieurs critères sont utilisés, tels que le mode d’utilisation de la préparation ou la quantité produite chaque année, les risques liés à la substance active ou aux procédés de préparation. A titre d’exemple, une catégorisation des préparations en fonction de ces principaux risques identifiés ci-dessus est proposée (cf. Annexe III).'),
('5.24', 'En cas de modification concernant les installations, les locaux, les équipements et le matériel, de même qu’en cas de changement de la composition, de la qualité des MPUP, des procédés de préparation validés, il incombe à une personne dûment qualifiée (dans le domaine concerné par les modifications) d’évaluer, avant que lesdites modifications ne soient apportées, dans quelle mesure leur effet sur la qualité des produits nécessite une requalification ou une revalidation.'),
('5.25', 'Les validations effectuées sont réexaminées à des intervalles appropriés, en fonction des produits manipulés et préparés et selon des méthodes établies, afin de déterminer si elles sont encore valables. S’il s’avère, par exemple, qu’une validation est devenue caduque à la suite d’une série de petites modifications dont chacune paraît mineure, il est nécessaire de revalider le procédé entier.'),
('5.26', 'On entend par MPUP tous les composants d''une préparation (la ou les substances actives, le ou les excipients et les éléments de mise en forme pharmaceutique comme les gélules vides).'),
('5.27', 'Une substance n’est pas par nature une MPUP mais elle le devient en fonction de l’usage auquel elle est destinée. Les MPUP cédées à une pharmacie sont donc présumées à usage pharmaceutique.'),
('5.28', 'Les MPUP répondent aux spécifications de la Pharmacopée quand elles existent et sont conformes à la monographie de la Pharmacopée Européenne « Substances pour usage pharmaceutique (Ph. Eur. n° 2034)» ou à d’autres monographies générales appropriées.'),
('5.29', 'Les MPUP utilisées pour la préparation répondent aux spécifications mentionnées à l’article L. 5121- 6 du CSP et sont, à la suite des contrôles requis et définis au chapitre 6, libérées par un pharmacien.'),
('5.30', 'Les MPUP sont conservées dans leurs récipients originaux. Si elles sont exceptionnellement transvasées dans des récipients de stockage, ceux-ci sont de nature équivalente, propre, et pourvus d’une étiquette portant toutes les indications spécifiques du lot, de sa durée de validité et du fabricant. Il est interdit de mélanger des lots.'),
('5.31', 'Si l’ouverture du récipient d’une MPUP entraîne une diminution de sa durée de validité, il est indiqué sur l’emballage une nouvelle date limite qui en tient compte.'),
('5.32', 'Les articles de conditionnement utilisés ont le statut de « libéré ». L’approvisionnement, la réception et la conservation des articles de conditionnement font l''objet de la même attention que celle apportée aux MPUP.'),
('5.33', 'Il convient de s’assurer
- d’éventuelles interactions contenant / contenu ;
- de leur adaptation à l’usage auquel ils sont destinés (par exemple pipette de volume adapté, compte-goutte si nécessaire...).'),
('5.34', 'Il est nécessaire de :
- ne réaliser qu’une seule préparation à la fois, sur une même zone de travail, afin d’éviter les risques d’erreurs et de contaminations croisées ;
- confier préférentiellement à la même personne qualifiée au sens du CSP la totalité des opérations d’un lot de préparation ;
- ne pas interrompre cette personne avant la réalisation complète de la préparation ;
- respecter l’ensemble des procédures et instructions établies par écrit ;
- consigner par écrit dans le dossier de lot de la préparation toutes les données utiles à la garantie de sa qualité : les enregistrements sont effectués au moment où chaque action est réalisée.'),
('5.35', 'Avant de commencer toute opération de préparation, il convient de s’assurer qu’un vide de ligne a été réalisé. La propreté de la zone de travail et du matériel est, elle aussi vérifiée. Aucune intervention de maintenance des locaux, équipements, matériels et installations n’est prévue pendant la réalisation de préparations sauf exception justifiée.'),
('5.36', 'Selon le procédé utilisé (décrit dans l’annexe II partie 2) et éventuellement en fonction de la préparation à réaliser, les vérifications de conformité des contrôles d’environnement sont réalisées avant l’utilisation de la zone.'),
('5.37', 'Un dispositif de récupération des déchets convenablement identifié est mis à disposition.'),
('5.38', 'L’opérateur rassemble les éléments nécessaires à la réalisation de la préparation :
- les MPUP ;
- les articles de conditionnement ;
- les matériels ;
- les documents valides (procédures, instructions,…).'),
('5.39', 'La personne qualifiée au sens du CSP vérifie notamment la date de péremption, l’étiquetage et les qualités organoleptiques des MPUP (limpidité, absences de particules visibles et de précipité pour des solutions, absence de changement de coloration, d’état physique des poudres, de déphasage des émulsions…), l’existence d’articles de conditionnement adaptés, l''intégrité des emballages et la date de péremption des matériels stériles éventuellement utilisés.'),
('5.40', 'La personne qualifiée respecte les instructions générales et spécifiques d''habillage, de protection, d''hygiène et de sécurité.'),
('5.41', 'La méthode de mesure des quantités de MPUP à mettre en œuvre est choisie notamment en fonction de leur nature et de la quantité à mesurer.'),
('5.42', 'Le matériel utilisé pour les pesées est de portée et de sensibilité adaptées aux masses mesurées. De même, les matériels de mesure des volumes sont adaptés aux volumes à mesurer.'),
('5.43', 'La mesure du volume ou la pesée des quantités de MPUP font toujours l''objet d''enregistrements et sont reportées dans le dossier de lot de la préparation ; l’édition ou l’enregistrement d’un ticket de pesée est recommandé.'),
('5.44', 'Lors de la réalisation de la préparation, l’identité de chaque MPUP utilisée, ainsi que sa masse ou son volume, sont à vérifier soit indépendamment ou simultanément, soit par un moyen adapté et validé d’enregistrement automatique direct sur le contenant. Ce contrôle peut être réalisé par une deuxième personne qualifiée au sens du CSP, dans ce cas la vérification est réalisée au moment où les MPUP sont utilisées. Dans tous les cas, cette vérification est tracée dans le dossier de lot.'),
('5.45', 'La pesée ou la mesure du volume des MPUP est réalisée de manière à ne pas altérer leurs qualités physico-chimiques et/ou microbiologiques ni, si c''est le cas, rompre leur stérilité. La manipulation des MPUP, notamment pendant cette opération de pesée ou de mesure du volume, ne doit pas représenter un risque de contamination de l’environnement.'),
('5.46', 'Le délai entre les mesures des quantités ou de volumes nécessaires et la préparation est le plus court possible.'),
('5.47', 'La préparation est réalisée en respectant les instructions de la préparation issue du dossier de préparation (annexe II partie 2), comportant notamment la composition qualitative et quantitative détaillée de la préparation.'),
('5.48', 'Dans le cas de préparations orales pulvérulentes, réalisées à partir d’une spécialité pharmaceutique autorisée en France, l’utilisation de l''excipient majoritaire de sa formulation correspondant au diluant est privilégiée.'),
('5.49', 'Les contrôles en cours de préparation et les contrôles de l’environnement qui ont été définis dans le dossier de préparation (cf. Annexe II partie 3) sont effectués et enregistrés.'),
('5.50', 'La préparation est réalisée d’une manière continue de la mise en oeuvre des MPUP jusqu’à la préparation terminée en excluant, sauf justification technique, la conservation d’un produit à un stade intermédiaire. Dans le cas d’une conservation à un stade intermédiaire, le conditionnement est muni d’un étiquetage permettant son identification précise.'),
('5.51', 'Dans la zone de préparation et de contrôle, tout contenant est identifié par le nom et le statut du contenu (par exemple : préparation en cours, préparation en attente de contrôle).'),
('5.52', 'Cette identification est apposée dès la fin du remplissage et de la fermeture des récipients, afin d’éviter toute substitution ou erreur. Toute autre manière de procéder doit garantir une sécurité comparable.'),
('5.53', 'Les éventuels résidus restant après la préparation sont détruits selon la réglementation en vigueur.'),
('5.54', 'Avant de commencer toute opération de conditionnement, il convient de s’assurer qu’un vide de ligne a été réalisé. La propreté de la zone de travail et du matériel sont elles aussi vérifiée.'),
('5.55', 'Selon le procédé utilisé et éventuellement en fonction de la préparation à conditionner, les vérifications des contrôles d’environnement sont réalisées avant l’utilisation de la zone.'),
('5.56', 'Les opérations de conditionnement sont effectuées en respectant les instructions de conditionnement définies dans le dossier de préparation.')
ON CONFLICT (ref) DO UPDATE SET texte = EXCLUDED.texte;
INSERT INTO ref_texts (ref, texte) VALUES
('5.57', 'L’identité et l’état de propreté des articles de conditionnement sont vérifiés.'),
('5.58', 'Les contrôles en cours de conditionnement et le cas échéant, les contrôles de l’environnement qui ont été définis dans le dossier de préparation sont effectués et enregistrés.'),
('5.59', 'A la fin des opérations de conditionnement, un bilan comparatif est fait. S’il y a lieu, l’excédent d’articles pré-imprimés est détruit avec enregistrement de la destruction.'),
('5.60', 'Toute préparation terminée est pourvue d’articles de conditionnement, et le cas échéant d’un emballage extérieur adéquat suffisamment solide pour exclure toute altération du contenu et permettre, en toute sécurité, les manipulations nécessaires liées à l’acheminement des préparations en-dehors du lieu de production. L’acheminement est réalisé en tenant compte des conditions de conservation de la préparation définies dans le dossier de préparation.'),
('5.61', 'On entend par réattribution des préparations terminées la dispensation d’une préparation à un patient alors qu’elle était initialement destinée à un autre patient. Elle fait l’objet d’une analyse de risque et d’une procédure.'),
('5.62', 'Les préparations retournées directement par les patients sont exclues de la réattribution.'),
('5.63', 'La réattribution des préparations terminées est à limiter et nécessite, au préalable, la réalisation d’une évaluation des risques encourus, en prenant en compte notamment :
- les effets éventuels sur la qualité de la préparation et sur sa conservation ;
- la conservation de l’intégrité de la préparation.'),
('5.64', 'La réattribution s’appuie sur une nouvelle prescription et nécessite la mise en place d’une gestion et d’une traçabilité spécifique des préparations concernées. La réattribution est documentée dans le ou les dossiers de lot des préparations correspondantes.'),
('5.65', 'Pour les préparations ayant des conditions particulières de conservation (par exemple 5 ± 3°C), il convient de s’assurer qu’aucune rupture de ces conditions ne s’est produite.'),
('5.66', 'Les modifications apportées sur le conditionnement final (ré-étiquetage par exemple) sont enregistrées dans le ou les dossiers de lot correspondant et font l’objet d’un contrôle. Il convient de s’assurer que les enregistrements réglementaires sont concordants.'),
('5.67', 'La personne responsable du contrôle, et le cas échéant, la personne responsable des opérations de préparation évalue s’il est nécessaire d’effectuer des contrôles supplémentaires sur la préparation.'),
('5.68', 'La personne en charge de la libération des préparations décide, après évaluation de tous les documents pertinents, notamment des résultats de contrôles supplémentaires, si la préparation en cours de réattribution peut être libérée. Cette libération est enregistrée dans le dossier de lot de la préparation correspondante.'),
('5.69', 'Dans le cas d’une sous-traitance, les éléments relatifs à la réattribution sont à contractualiser.'),
('6.01', 'Le contrôle de la qualité pharmaceutique consiste en la mise en oeuvre d’opérations de mesure (analyses) ou d’examen des caractéristiques des MPUP, des articles de conditionnement, des préparations en cours de réalisation et des préparations terminées en comparant les résultats obtenus aux exigences spécifiées. L’objectif est de déterminer s’ils sont conformes pour chacune de leurs caractéristiques et de prendre pour chacun une décision d’acceptation ou de refus.'),
('6.02', 'Le contrôle de la qualité concerne l’échantillonnage (MPUP, articles de conditionnement, préparations terminées…), l’établissement de spécifications et leur analyse, ainsi que l’organisation, l’établissement des documents et des procédures de libération. L’ensemble garantit que les contrôles nécessaires et appropriés ont été bien effectués et que les MPUP, les articles de conditionnement et les préparations ne sont libérés qu’une fois que leur qualité a été jugée satisfaisante. Le contrôle de la qualité participe à toutes les décisions qui peuvent concerner la qualité d’une préparation. Dans le cadre de la réalisation des préparations pharmaceutiques, le contrôle permet de garantir que les analyses et opérations nécessaires et appropriées ont été effectuées en vue d’évaluer leur qualité pharmaceutique.'),
('6.03', 'Les différents contrôles entrant dans le cycle de vie des préparations sont :
- le contrôle à réception (MPUP, articles de conditionnement, préparations sous-traitées, etc.…) ;
- le contrôle en cours de préparation, si nécessaire (enregistrement, autocontrôles) ;
- le contrôle des préparations pharmaceutiques terminées ;
- le contrôle libératoire des préparations ;
- le cas échéant, le contrôle de la stabilité des préparations et de l’absence d’interactions contenant/contenu.'),
('6.04', 'Les contrôles pouvant être mis en oeuvre afin d’assurer la qualité des préparations pharmaceutiques sont :
- des contrôles de recevabilité documentaire (MPUP, réactifs, étalons de référence…) ;
- des contrôles physico-chimiques ;
- des contrôles pharmacotechniques ;
- des contrôles microbiologiques ;
- des contrôles de radioactivité le cas échéant ;
- des contrôles de l’environnement (air, surfaces, eau) ;
- et tous autres contrôles jugés nécessaires.'),
('6.05', 'Les référentiels de contrôle à utiliser pour les préparations pharmaceutiques et les MPUP qui les constituent sont listés ci-après, par ordre de priorité.'),
('6.06', 'Les référentiels officiels sont :
-la Pharmacopée Européenne (monographies générales, monographies spécifiques et
prescriptions générales) ;
-la Pharmacopée Française et en particulier le Formulaire national.
Si les monographies existent dans ces référentiels, leur application est obligatoire.'),
('6.07', 'A défaut, d’autres référentiels officiels peuvent être utilisés, tels que, par ordre de priorité :
-les Pharmacopées et Formulaires nationaux des autres Etats membres de l’Union européenne ;
-les Pharmacopées et Formulaires de pays tiers (comme par exemple l’US Pharmacopeia).'),
('6.08', 'En l’absence de référentiel disponible, d’autres méthodes de contrôle sont utilisées :
-les méthodes développées en interne par l’établissement qui réalise les préparations ;
-les méthodes des fabricants et/ou des fournisseurs ;
-les méthodes décrites dans la littérature (dont les recommandations publiées de sociétés
savantes).'),
('6.09', 'Les méthodes analytiques validées issues des référentiels officiels nécessitent au minimum une phase de mise en oeuvre technique au sein de l’établissement qui réalise les contrôles.'),
('6.10', 'La validation des méthodes non officielles est à réaliser selon les référentiels tels qu’ICH13 Q2
(Validation des méthodes d’analyse).'),
('6.11', 'Pour les contrôles de l’environnement, l’utilisation de référentiels adaptés est nécessaire.'),
('6.12', 'Les contrôles peuvent s’effectuer au sein de la structure qui réalise les préparations ou être soustraités sous couvert d’un contrat. Ce recours est mentionné dans le dossier de préparation.'),
('6.13', 'Pour chaque préparation, le contrôle concerne la ou les substance(s) active(s), le ou les excipient(s), le ou les produit(s) intermédiaire(s), la préparation terminée ainsi que les articles de conditionnement.'),
('6.14', 'L''activité de contrôle est organisée de façon à permettre un contrôle indépendant de l''activité de préparation. Afin de garantir l’efficacité et la fiabilité des contrôles, des moyens suffisants et appropriés sont mis en en oeuvre.'),
('6.15', 'Les locaux ou zones de contrôle sont adaptés aux tâches imposées par la nature et l’importance des opérations de contrôle (Chapitre 3).'),
('6.16', 'Les contrôles sont placés sous l''autorité d''une personne compétente permettant de les conduire. Sa formation initiale, son expérience et l’actualisation de ses connaissances constituent les garanties de ses compétences dans les différents domaines couverts par le contrôle de la qualité pharmaceutique.'),
('6.17', 'L’ensemble du personnel réalisant les contrôles est qualifié et régulièrement formé.'),
('6.18', 'Sauf exception justifiée, les contrôles sont effectués par une personne différente de celle ayant réalisé la préparation.'),
('6.19', 'Les équipements et le matériel (comme par exemple les balances, les pipettes, les caméras, les automates et d’une manière générale les instruments analytiques utilisés pour le contrôle qualité et les contrôles d’environnement) sont adaptés aux contrôles à réaliser. Ils sont maintenus à l’état qualifié et sont requalifiés périodiquement.'),
('6.20', 'La verrerie utilisée pour les opérations de contrôle est propre et adaptée à son usage.'),
('6.21', 'Chaque appareil utilisé pour le contrôle possède un dossier. Ce dossier comprend notamment :'),
('6.22', 'L’équipement et le matériel d’analyse sont entretenus de façon à maintenir leurs performances.'),
('6.23', 'Les contrôles analytiques nécessitent l’utilisation d’étalons de référence : substances, spectres et
matériaux de référence.'),
('6.24', 'Les méthodes de contrôle officielles indiquent l’(les) étalon(s) de référence requis. Ces étalons primaires sont qualifiés et certifiés. Dès lors qu’ils sont disponibles, ils sont préférentiellement utilisés. Des étalons secondaires peuvent être utilisés à condition qu’ils soient adaptés et qualifiés par rapport à un étalon primaire certifié officiel.'),
('6.25', 'Chaque étalon de référence possède un dossier comportant le certificat d’origine de l’étalon ou les comptes rendus d’analyse d’étalonnage dans le cas d’un étalon secondaire.'),
('6.26', 'Une procédure décrit le mode de préparation des réactifs et des solutions titrées, leurs étiquetages, leurs conditions de conservation et leur date limite de validité. Le cas échéant, la périodicité du recontrôle et le protocole de qualification sont décrits.'),
('6.27', 'Chaque solution titrée et chaque réactif préparés au laboratoire possède une fiche individuelle comportant l’identité de l’opérateur ayant exécuté cette opération, la date de réalisation, les quantités et/ou volumes exacts mis en oeuvre, la date limite de validité. Les réactifs et solutions titrées comportent eux-mêmes un étiquetage.'),
('6.28', 'La documentation du contrôle de la qualité suit les principes énoncés au chapitre 4.'),
('6.29', 'Les documents suivants sont accessibles au personnel en charge du contrôle de la qualité (liste non exhaustive) : les procédures d''échantillonnage ; les procédures de contrôle (matériel, méthode et spécifications) ainsi que les enregistrements (y compris les documents de travail et/ou les cahiers de laboratoire) ; les résultats des contrôles réalisés ; les rapports et/ou les certificats d''analyse ; les rapports de validation des méthodes de contrôle ; les procédures et les enregistrements concernant l''étalonnage des instruments, la maintenance du matériel ainsi que la qualification des logiciels ; le cas échéant, les résultats concernant la surveillance de l''environnement'),
('6.30', 'Des procédures sont disponibles et précisent : les types de contrôle à effectuer (vérification administrative de conformité de réception par rapport à la commande, examen visuel, contrôles analytiques donnant lieu à des résultats chiffrés) ; le référentiel utilisé ; la (les) technique(s) et la (les) méthode(s) de contrôle utilisées ; l''équipement analytique, le matériel, les réactifs et les substances de référence utilisés ; le mode opératoire ; la procédure d''échantillonnage utilisée ; le nombre d''essais réalisés ; les spécifications attendues ; le format du rendu de résultats (certificat d''analyse, fiche de contrôle...) ; le format de l''archivage des résultats (enregistrements).'),
('6.31', 'Pour chaque MPUP utilisée, le pharmacien dispose d’un certificat d’analyse demandé auprès de son fournisseur. Ce certificat est signé du fournisseur et comporte le nom et l’adresse du fabricant d’origine ainsi que le référentiel des contrôles effectués.'),
('6.32', 'La réception des MPUP est enregistrée chronologiquement. Les MPUP reçoivent un numéro d’ordre d’identification qui est reporté sur le conditionnement primaire. En cas de réception de plusieurs lots, ceux-ci sont considérés individuellement pour l’enregistrement, l’échantillonnage, le contrôle et l’acceptation.'),
('6.33', 'La décision d’acceptation des MPUP et des articles de conditionnement stériles par le pharmacien est portée sur un registre manuscrit ou informatisé. Son statut est reporté sur l’étiquetage du récipient en contact avec la MPUP.'),
('6.34', 'En cas de refus, la décision est reportée sur le registre et sur le récipient ou sur l’article de conditionnement.'),
('6.35', 'Les MPUP ou les articles de conditionnement refusés sont renvoyés aux fournisseurs dans les plus brefs délais ou détruits conformément aux textes en vigueur. Dans l’attente de leur renvoi ou de leur destruction, ces produits sont stockés dans un endroit isolé avec une étiquette «produit refusé».'),
('6.36', 'L’un des paramètres critiques à prendre en compte pour orienter le contrôle des MPUP est leur source d’approvisionnement.'),
('6.37', 'Les MPUP peuvent être répertoriées en 3 catégories selon leur provenance et leurs caractéristiques. Les contrôles à réaliser sont indiqués pour chaque catégorie.'),
('6.38', 'Les MPUP répondant aux critères listés ci-dessous font l’objet d’une vérification de recevabilité. Les MPUP émanant d’un établissement pharmaceutique de fabrication autorisé (conformément aux dispositions des articles L. 5124-1 et L. 5124-3 du CSP), ou émanant, selon les dispositions des articles L. 5138-1 et L. 5138-2 du CSP, d’un établissement ayant des activités de fabrication (complète ou partielle ou réalisant divers procédés de division ou de conditionnement) ou de distribution (ayant des activités de reconditionnement et de réétiquetage) de MPUP fabriquées en France ou dans l’Union Européenne, et autorisé ou déclaré soit à l’ANSM, soit auprès de l’autorité compétente dans les pays de l’Union Européenne et détenteur pour les substances actives d’un certificat de conformité aux bonnes pratiques délivré par l’ANSM ou par l’autorité compétente dans les pays de l’Union Européenne et disposant pour chaque contenant d’un système d’inviolabilité et disposant du certificat d’analyse du lot correspondant.'),
('6.39', 'La vérification de la recevabilité de la MPUP consiste à s’assurer de :'),
('6.40', 'La traçabilité de cette vérification est assurée.'),
('6.41', 'La constitution d’une échantillothèque n’est pas obligatoire pour ces MPUP.'),
('6.42', 'Utilisation comme MPUP d’une spécialité pharmaceutique disposant d’une AMM ou d’une autorisation d’importation. Si, à défaut d''une MPUP disponible adaptée, une spécialité pharmaceutique est utilisée, aucun contrôle de celle-ci n''est exigé au titre de « matière première ».'),
('6.43', 'Le déconditionnement fait toujours l’objet d’une évaluation des conséquences d’une telle opération sur la qualité, la stabilité, la sécurité et l’efficacité de la préparation, en prenant compte de l’Annexe IV du présent guide.'),
('6.44', 'L’utilisation d’une spécialité comme MPUP n’exonère pas du contrôle de la préparation pharmaceutique terminée.'),
('6.45', 'La constitution d’une échantillothèque n’est pas obligatoire pour cette catégorie.'),
('6.46', 'Les MPUP dont les critères figurent ci-dessous font l’objet d’un contrôle complet, en plus des points vérifiables de la recevabilité : * Les MPUP émanant d’autres établissements pharmaceutiques autorisés (non fabricants) ; * Ou émanant de distributeurs (n’ayant pas d’activité de reconditionnement et de ré-étiquetage), ou émanant d’un importateur de MPUP définis à l’article L. 5138-2 du CSP autorisés ou déclarés à l’ANSM ou bien déclarés ou autorisés auprès de l’autorité compétente dans les pays de l’Union Européenne * Ou d’autres fournisseurs non déclarés ni autorisés par l’ANSM ou par une autre autorité compétente dans les pays de l’Union Européenne. Ou d’autres fournisseurs non déclarés ni autorisés par l’ANSM ou par une autre autorité compétente dans les pays de l’Union Européenne.'),
('6.47', 'De plus, en l’absence d’au moins un des éléments listés ci-dessous, un contrôle complet est à réaliser sur la MPUP :'),
('6.48', 'Le contrôle complet consiste à s’assurer de la conformité de la MPUP aux exigences de la Pharmacopée.'),
('6.49', 'En l’absence de référentiel disponible, des contrôles physico-chimiques et d’éventuelles études toxicologiques ou microbiologiques sont mis en oeuvre afin de prouver que la qualité de la MPUP est adaptée à son usage.'),
('6.50', 'La constitution d’une échantillothèque pour cette catégorie de MPUP est obligatoire.'),
('6.51', 'Pour les MPUP décrites à la Pharmacopée, la conformité à la monographie est démontrée. L’existence d’un certificat de conformité à la Pharmacopée Européenne (CEP) délivré par l’EDQM17 donne des garanties supplémentaires. Sa présence est un critère de choix pour la sélection de la source d’approvisionnement des MPUP.'),
('6.52', 'La date de péremption ou de re-contrôle figure sur chaque conditionnement.'),
('6.53', 'En l’absence de date de péremption ou de re-contrôle indiquée sur le conditionnement par le fabricant ou le fournisseur, le pharmacien refuse le conditionnement.'),
('6.54', 'Le re-contrôle consiste à un contrôle complet tel que défini au point 6.48.'),
('6.55', 'Pour les MPUP pour lesquelles le fournisseur ou le fabricant donne l’information, les dates d’ouverture et de fin d’utilisation sont indiquées ; cette information est clairement notée sur le conditionnement.'),
('6.56', 'La vérification de la recevabilité des articles de conditionnement consiste à s’assurer de : * La concordance entre la commande et les articles de conditionnement réceptionnés * La vérification de l’intégrité de l’emballage et du conditionnement primaire * La vérification, le cas échéant, de la présence d’un certificat d’analyse de conformité à la Pharmacopée, et/ou de spécifications internes (stérilité, certificat de stérilisation …) * La vérification, le cas échéant, du marquage CE'),
('6.57', 'Les contrôles comprennent :
- les paramètres critiques du procédé de préparation nécessitant éventuellement des contrôles intermédiaires ;
- les aspects pharmacotechniques ;
- les aspects physico-chimiques ;
- les aspects microbiologiques, le cas échéant ;
- les systèmes d’enregistrement (chromatogrammes, vidéo…) ;
- la conformité de l’étiquetage ;
- l’adéquation entre la prescription et l’étiquetage de la préparation terminée.'),
('6.58', 'Les contrôles sont réalisés conformément aux procédures et modes opératoires. Pour chaque préparation, ils sont listés dans l’Annexe II partie 3 du dossier de préparation.'),
('6.59', 'Les contrôles à effectuer sont fonction de l’évaluation du risque, basée sur les critères suivants : •  le type de préparation pharmaceutique : extemporanée et/ou pouvant être stockée ; •  la destination de la préparation ou du lot de préparations : préparation destinée à un seul patient ou lot destiné à plusieurs patients ; •  la forme pharmaceutique réalisée ; •  la classification de la préparation au regard de l’Annexe III ou d’une analyse de risque formalisée ; •  le type d’opération pharmaceutique nécessaire à la réalisation de la préparation ; •  le nombre d’unités préparées ; •  le caractère destructif ou non des opérations de contrôle.'),
('6.60', 'Exemples de contrôles pouvant être attendus (liste non limitative) :
* pour toutes les formes pharmaceutiques :
- des contrôles sur la quantité et qualité de MPUP mises en oeuvre, les caractères organoleptiques de la préparation, le rendement… ;
- un contrôle de l’étiquetage.
* pour les formes pharmaceutiques multi-doses :
- une vérification des quantités (volume, masse…) ;
- le contrôle du dispositif d’administration le cas échéant.'),
('6.61', 'Pour les formes pharmaceutiques unitaires, une uniformité de masse est réalisée selon les normes de la Pharmacopée ou selon une méthode adaptée et équivalente à la Pharmacopée.'),
('6.62', 'Pour les préparations destinées à être stockées, ou lorsqu’un lot de préparations est destiné à plus de 10 patients, une uniformité de teneur est réalisée. Si ce contrôle n’est pas mis en place, la mise en oeuvre d’un ou plusieurs contrôles intermédiaire(s) ou final(aux) permettant de s’assurer de la bonne qualité de la préparation terminée, est organisé. Ce peut être le cas par exemple lors de la réalisation de gélules contenant uniquement la substance active.'),
('6.63', 'L’absence de contrôles ou un nombre restreint de contrôles est justifié dans le dossier de préparation.'),
('6.64', 'Un échantillon de chaque lot de préparations terminées est conservé, sauf exception justifiée. La quantité minimale conservée permet de réaliser au moins l’analyse complète décrite dans la procédure de contrôle.'),
('6.65', 'Pour les préparations dont le lot est destiné à moins de 10 patients, cette échantillothèque n’est pas obligatoire.'),
('6.66', 'Ces échantillons sont conservés dans les conditions prévues pour la préparation pendant une durée au moins égale à leur date de péremption augmentée d''un an, sauf exception justifiée.'),
('6.67', 'Un registre pouvant être informatisé permet d’assurer la gestion de l’échantillothèque :
- Les entrées et les sorties d’échantillons de l’échantillothèque font l’objet d’un enregistrement avec notification de leur utilisation en cas de sortie ;
- Les récipients contenant des échantillons sont clairement identifiés en mentionnant, notamment au minimum de façon apparente, le numéro de lot, la date d''échantillonnage, la date de péremption, le numéro d’enregistrement dans l’échantillothèque et la mention « Ne pas dispenser », ou via un code permettant de tracer l’ensemble de ces informations.'),
('6.68', 'L’évaluation de la conformité de la préparation terminée et la décision de libération prennent en compte l’examen de l’ensemble des éléments pertinents :
- le dossier du lot de la préparation ;
- les conditions de préparation notamment les résultats des contrôles de l’environnement ;
- les résultats des contrôles et ceux en cours de préparation, le cas échéant ;
- les documents de préparation et de conditionnement ;
- la conformité aux spécifications de la préparation terminée ;
- l’examen du conditionnement final notamment la vérification de l’étiquetage ;
- le bon respect des procédures d’assurance qualité.'),
('6.69', 'La décision de libération de la préparation et son enregistrement sont réalisés par un pharmacien. C’est cette libération qui est appelée libération pharmaceutique de la préparation.'),
('6.70', 'La stratégie de libération des préparations est fondée sur une évaluation du risque appropriée.'),
('6.71', 'L’étendue et la pertinence des contrôles sont fonction des caractéristiques de la préparation et de son utilisation.'),
('6.72', 'Le contrôle peut s’appliquer à toutes les entités reçues ou produites (contrôle à 100%) ou s’opérer sur un nombre limité d’entités représentatives (contrôle par échantillonnage). Il peut s’appliquer à une seule unité ou à un lot de préparations.'),
('6.73', 'L’échantillonnage est représentatif du lot. A certains stades de la préparation, il peut être nécessaire de diviser un lot en un certain nombre de sous-lots qui sont ultérieurement rassemblés en vue de former un lot homogène.'),
('6.74', 'Dans le cas où le lot se composerait de plusieurs sous-lots, un plan d’échantillonnage de chaque sous-lot est réalisé afin de s’assurer que le lot est bien homogène.'),
('6.75', 'Dans le cas d’un contrôle par échantillonnage, la procédure précise s’il s’agit :
- d’un échantillonnage simple : 1 seul prélèvement de n unités ;
- d’un échantillonnage multiple : plusieurs prélèvements de n unités.'),
('6.76', 'Dans le cas d’un échantillonnage multiple, la procédure indique la destination de chaque prélèvement :
- prélèvement de n unités destiné aux contrôles pharmacotechniques ;
- prélèvement de n unités destiné aux contrôles physico-chimiques ;
- prélèvement de n unités destiné aux contrôles microbiologiques, notamment pour les
préparations terminées stériles ;
- prélèvement de n unités destiné à un éventuel contrôle supplémentaire suite à une nonconformité du premier prélèvement ;
- prélèvement de n unités destiné à l’échantillothèque quand elle est requise ou prévue par laprocédure.'),
('6.77', 'Ce contrôle est mis en oeuvre à partir du moment où la préparation est réalisée à l’avance et destinée à être conservée sur des périodes prolongées, en rapport avec la forme pharmaceutique (solution parentérale, collyre, solution/suspension buvable, topique, forme sèche…).'),
('6.78', 'La durée de stabilité d’une préparation pharmaceutique correspond à la durée pendant laquelle une préparation terminée, conserve, dans des limites spécifiées et tout au long de la période de conservation et d’utilisation, les mêmes propriétés et caractéristiques qu’elle possédait au moment de sa réalisation.'),
('6.79', 'La date de péremption de la préparation est la date au-delà de laquelle une préparation ne peut plus être utilisée. Elle est déterminée à partir de la date où la préparation est réalisée.'),
('6.80', 'La mention d’une indication de péremption sur une préparation pharmaceutique est obligatoire et implique de mener une réflexion sur sa stabilité au cours du temps. Cette réflexion prend en considération :
- les propriétés physico-chimiques des MPUP et des articles de conditionnement ;
- les données bibliographiques ;
- les analyses réalisées ;
- la forme pharmaceutique ;
- le type de conditionnement utilisé (multi-dose versus unitaire par exemple) ;
- la présence ou l’absence de conservateur.'),
('6.81', 'La date de péremption déterminée par le fabricant d’une spécialité pharmaceutique autorisée ne peut pas être utilisée directement comme date de péremption de la préparation terminée dans laquelle elle est incluse.'),
('6.82', 'Les durées de stabilité établies à partir d’analyses sont privilégiées.'),
('6.83', 'Les méthodes analytiques utilisées pour l’étude de la stabilité des préparations permettent la quantification de la ou les substance(s) active(s) et des produits de dégradation et de détecter toute autre modification des caractéristiques de la préparation. Elles font l’objet d’une validation.'),
('6.84', 'La stabilité microbiologique concerne l’ensemble des préparations réalisées et conservées avec pour objectif de démontrer au cours du temps le maintien de la qualité microbiologique en accord avec les monographies de la Pharmacopée Européenne.'),
('6.85', 'L''absence d''interactions contenant-contenu doit être recherchée. Une analyse du risque d''interactions est conduite en se basant notamment sur la présence d''excipients à risque dans la formule (agents de surface, solutions hydroalcooliques, excipients lipidiques ou lipophiles...). Les données disponibles sont recherchées à partir des données de la littérature, des données fournisseurs, ou de données issues de recherches développées et validées en interne par l''établissement.'),
('7.01', 'Toute sous-traitance s’effectue dans un cadre contractuel, dans le respect des textes en vigueur, des présentes bonnes pratiques (BPP) et le cas échéant des Bonnes Pratiques de Fabrication (BPF) pour les établissements pharmaceutiques.'),
('7.02', 'Une sous-traitance est envisageable pour les activités suivantes :
- la totalité des opérations de préparation (incluant le conditionnement primaire et l’étiquetage) ;
- le contrôle : MPUP et/ou préparations terminées ;
- le transport de la préparation.')
ON CONFLICT (ref) DO UPDATE SET texte = EXCLUDED.texte;
INSERT INTO ref_texts (ref, texte) VALUES
('7.03', 'Le cadre de la sous-traitance est défini de manière appropriée, convenue et contrôlée afin d’éviter tout malentendu susceptible de conduire à un travail ou une préparation de qualité insuffisante.'),
('7.04', 'Un contrat écrit est établi entre le donneur d’ordre et le sous-traitant en vue de fixer clairement les obligations de chaque partie ainsi que les exigences, les tâches et les responsabilités dévolues à chaque partie.'),
('7.05', 'Pour des raisons pratiques et pour clarifier les responsabilités de chacun, un contrat global est à privilégier. Dans le cas où un contrat global ne serait pas possible, les différents contrats sont réunis pour être consultables ensemble.'),
('7.06', 'Le contrat indique que les activités externalisées peuvent être inspectées par les autorités compétentes, y compris la sous-traitance des contrôles.'),
('7.07', 'Le donneur d’ordre indique clairement, au moyen de stipulations contractuelles, quelle est la portée des prestations qu’il attend et quelles sont les exigences qui s’appliquent.'),
('7.08', 'Le donneur d’ordre est tenu de s’assurer que le sous-traitant a la compétence de mener à bien les activités sous-traitées et qu’il est titulaire d’une autorisation correspondant aux opérations à effectuer.'),
('7.09', 'Le donneur d’ordre s’assure que toutes les tâches effectuées en sous-traitance l’ont été conformément aux textes en vigueur et aux exigences des présentes bonnes pratiques ou le cas échéant conformément aux BPF pour les sous-traitances aux établissements pharmaceutiques, et que les préparations réalisées qui lui sont livrées par le sous-traitant répondent bien à leurs spécifications.'),
('7.10', 'Le donneur d’ordre fournit au sous-traitant toutes les informations et connaissances nécessaires à la réalisation correcte du contrat comme, par exemple, la connaissance d’une allergie à une substance pouvant être présente dans la préparation. L’annexe I peut servir de support pour transmettre ces informations.'),
('7.11', 'Le donneur d’ordre s’assure que son prestataire dispose d’un système d’assurance de la qualité permettant de lui garantir que les présentes bonnes pratiques sont respectées.'),
('7.12', 'Dans tous les cas, le pharmacien qui dispense la préparation réalise et trace un contrôle à réception de la préparation afin de s’assurer notamment :
- du bon étiquetage de la préparation ;
- de la concordance entre la préparation et la prescription ou la commande de préparations pharmaceutiques ;
- de l’intégrité physique du conditionnement ;
- du bon respect des conditions de conservation pendant le transport (par exemple : chaine du
froid, abri de la lumière).'),
('7.13', 'Il est responsable de la dispensation de la préparation ayant fait l’objet d’un contrat de sous-traitance.'),
('7.14', 'Le sous-traitant est en mesure d’effectuer de manière satisfaisante le travail confié par le donneur d’ordre. Il dispose des autorisations, des locaux, de l’équipement, des connaissances appropriées et du personnel compétent en vue d’effectuer le contrat conformément aux règles des BPP et le cas échéant aux BPF pour les établissements pharmaceutiques. Le sous-traitant fournit au donneur d’ordre la garantie qu’il a mis en place un système d’assurance de la qualité.'),
('7.15', 'Toutes les activités sont exécutées conformément au contrat.'),
('7.16', 'Tout élément connu après la libération susceptible de remettre en cause cette décision de libération est signalé sans délai au pharmacien donneur d’ordre.'),
('7.17', 'Le sous-traitant ne peut pas sous-traiter à un tiers tout ou partie du travail qui lui a été confié par contrat. Toutefois, un contrat entre le sous-traitant et une troisième partie est possible pour les activités de contrôle et de transport. Le donneur d’ordre en est informé.'),
('7.18', 'Le sous-traitant des opérations de préparation rédige la totalité du dossier de préparation (Annexe II).'),
('7.19', 'Le sous-traitant est responsable de la libération pharmaceutique de la préparation qu’il réalise. L’émission d’un certificat de libération des lots daté et signé par le pharmacien désigné comme responsable des préparations est envoyé au donneur d’ordre avec la préparation terminée.'),
('7.20', 'Le sous-traitant peut refuser la réalisation d’une préparation pharmaceutique. Sa décision est motivée.'),
('7.21', 'Le contrat établi entre le donneur d’ordre et le sous-traitant précise leurs responsabilités respectives et les processus de communication concernant les activités externalisées. Pour les officines, l’autorisation de sous-traitance est annexée au contrat.'),
('7.22', 'Les aspects techniques du contrat sont établis par des personnes compétentes, possédant desconnaissances appropriées en matière de sous-traitance d’activités et de BPP ou de BPF ; ces aspects peuvent être annexés au contrat.'),
('7.23', 'Le contrat précise clairement les responsabilités et les processus concernant par exemple :
- la préparation ainsi que le conditionnement (incluant l’étiquetage) ;
- le contrôle de la qualité des MPUP, des produits intermédiaires, des préparations terminées et des articles de conditionnement ;
- la libération pharmaceutique du lot ;
- les conditions de conservation de la préparation ;
- les conditions de transport ;
- les conditions de rappel de lots et de la gestion des non-conformités ;
- la durée du contrat et la reconduction de celui-ci le cas échéant.'),
('7.24', 'Le contrat accorde au donneur d’ordre le droit d’auditer, le cas échéant, le ou les sous-traitants et de consulter, s’il en fait la demande, les documents pertinents pour la qualité.'),
('7.25', 'Le contrat peut préciser des cas de refus de prestations qui seront à motiver.'),
('7.26', 'La sous-traitance d’une préparation n’est envisageable que pour la totalité des opérations de préparation, y compris le conditionnement.'),
('7.27', 'En cas de sous-traitance d’une préparation, le prestataire procède à l’étiquetage de la préparation terminée comportant la totalité des mentions requises aux articles R. 5121-146-2 et R. 5121-146-3 du CSP, (notamment le numéro d’enregistrement de la préparation réalisée), à l’exception du numéro d’ordonnancier défini et apposé sur l’étiquette par la pharmacie lors de la dispensation. Par ailleurs, le nom du sous-traitant et celui de la pharmacie donneur d’ordre sont clairement indiqués sur l’étiquetage.'),
('7.28', 'Outre les points mentionnés au 7.23, le contrat précise notamment :
- les modalités de commande ;
- les formes pharmaceutiques réalisées par le sous-traitant ;
- les délais de réalisation incluant éventuellement la libération des lots et la prise en charge de préparations urgentes;
- les conditions et délais de conservation ;
- les documents utiles à la réalisation du contrat.'),
('7.29', 'Le recours à la sous-traitance pour les contrôles est justifié notamment par l’absence ou l’indisponibilité de certains équipements nécessaires à la réalisation de contrôles, et/ou lorsque ceuxci sont peu fréquents et/ou requièrent une compétence particulière.'),
('7.30', 'Les responsabilités sont clairement définies notamment pour les MPUP et pour les préparations terminées pour :
- les contrôles physico-chimiques ;
- les contrôles pharmacotechniques ;
- les contrôles microbiologiques.'),
('7.31', 'En cas de sous-traitance de la totalité des contrôles des MPUP et des préparations terminées, le pharmacien donneur d’ordre fournit au pharmacien prestataire la totalité des éléments en sa possession concernant la formule et les conditions de préparation.'),
('7.32', 'Le prestataire émet un certificat d’analyse comportant les résultats des contrôles quantitatifs et qualitatifs réalisés avec leurs spécifications, ainsi que les méthodes d’analyses et référentiels utilisés. Une conclusion sur la conformité ou la non-conformité, au regard des analyses réalisées, est à mentionner sur le certificat d’analyse correspondant au lot contrôlé, daté et signé par le responsable.'),
('7.33', 'Bien que certains contrôles puissent être sous-traités, le pharmacien prestataire des opérations de préparation demeure responsable in fine de la qualité de la MPUP qu’il met en oeuvre lors de la réalisation de la préparation et ce, au vu des résultats des contrôles fournis par le sous-traitant.'),
('7.34', 'Le contrat précise notamment :
- la durée moyenne de transport ;
- les conditions particulières de conservation ;
- la localisation exacte du lieu de livraison ;
- la localisation et les conditions de remise avec le lieu de prise en charge ;
- les lieux et délais de ruptures de charge quand ils existent ;
- les délais de recours.'),
('7.35', 'En cas d’utilisation d’un service de colis postaux, il convient de s’assurer que les conditions de conservation et les délais d’acheminement sont compatibles avec la préparation.'),
('7.36', 'Toute préparation terminée destinée à être transportée est pourvue d''un emballage adéquat suffisamment solide pour exclure toute altération du contenu et permettre en toute sécurité les manipulations nécessaires, liées à l’acheminement des préparations en-dehors du lieu de production. Le transport respecte les mesures d’hygiène en vigueur.'),
('7.37', 'Le transport des préparations terminées se fait dans des conteneurs ou des paquets clos, scellés ou disposant d''un système de fermeture assurant la même sécurité et comportant les noms et adresses de l’expéditeur et du destinataire.'),
('7.38', 'Lorsqu’elles sont requises, les conditions particulières de conservation (comme la sensibilité à la chaleur, au froid, à la lumière, à la congélation et aux mouvements) sont respectées. Elles sont décrites dans le contrat. Le sous-traitant assurant la responsabilité du transport est en mesure d’établir que ces conditions sont respectées pour chaque envoi (qualification des emballages, enregistrements de suivi des températures, contrôle de la durée du transport).'),
('7.39', 'Toute activité externalisée, couverte par le guide des BPP, est définie de manière appropriée, convenue et contrôlée afin d’éviter tout malentendu susceptible de conduire à un travail ou une préparation de qualité insuffisante. Un contrat écrit est établi entre le donneur d’ordre et le sous-traitant en vue de fixer clairement les obligations de chaque partie.'),
('7.40', 'En fonction des conditions locales, les contrats de sous-traitance peuvent inclure des prestations ayant des répercussions notables sur la qualité des produits fabriqués ou sur les résultats des analyses. Ces prestations, souvent confiées à un autre service ou organisme, peuvent comprendre :
- les maintenances des systèmes de traitement d’air et d’eau ;
- la maintenance des principaux appareils comme les isolateurs, les postes à flux d’air unidirectionnel, les stérilisateurs, les balances ;
- la surveillance des ZAC ;
- la mise à disposition des consommables stériles tels que les vêtements, articles de conditionnement ;
- la manipulation des déchets et leur élimination ;
- le nettoyage et la désinfection des locaux et équipement.'),
('8.01', 'Toute réclamation concernant la qualité des préparations pharmaceutiques terminées (erreur, défaut, et autres signes de problèmes de qualité) est examinée selon des procédures écrites.'),
('8.02', 'Un système de rappel des préparations est organisé permettant de retirer rapidement et efficacement une préparation défectueuse.'),
('8.03', 'Le pharmacien s''assure de la mise en oeuvre d''un système permettant l''enregistrement, le traitement des réclamations et, si  nécessaire, le rappel des préparations concernées'),
('8.04', 'Des procédures documentées décrivent ces opérations qui sont à effectuer rapidement et rigoureusement.'),
('8.05', 'Les réclamations concernant les préparations délivrées sont examinées. Les causes des défauts sont recherchées et les mesures appropriées prises, non seulement en ce qui concerne la préparation défectueuse elle-même, mais également en vue de prévenir le renouvellement de ces défauts.'),
('8.06', 'L''ensemble des analyses et des mesures prises est enregistré et conservé dans le dossier de lot.'),
('8.07', 'Le pharmacien met en oeuvre un plan d''action (actions correctives et délai de mise en oeuvre, modification des procédures) afin d''éviter que le problème constaté ne se reproduise.'),
('8.08', 'Des procédures écrites concernant l’organisation du rappel sont établies.'),
('8.09', 'Lorsqu’un défaut susceptible de porter atteinte à la santé est constaté, il convient de procéder sans délai au retrait de la préparation et à l’information de l’autorité concernée.'),
('8.10', 'Le rappel de toutes les préparations incriminées est réalisé, notamment en informant les donneurs d’ordre, grâce aux données présentes dans le dossier de lot de la préparation dans lequel figurent les copies des prescriptions ou tout autre élément permettant d''en assurer la traçabilité.'),
('8.11', 'Toutes les préparations rappelées sont identifiées en tant que telles et stockées dans un endroit séparé en attendant la décision de destruction par le pharmacien.'),
('8.12', 'Un rapport détaillé des opérations de rappel comprenant notamment un bilan comparatif des quantités distribuées et récupérées est rédigé et conservé dans le dossier de lot.'),
('9.01', 'L’auto-inspection fait partie du système d’assurance de la qualité et est réalisée de façon répétée en vue de contrôler la mise en oeuvre et le respect des Bonnes Pratiques de Préparation (BPP) et de proposer des mesures correctives nécessaires.'),
('9.02', 'Le personnel, les locaux, le matériel, les documents, la préparation (au sens production), le contrôle de la qualité, la libération pharmaceutique, les dispositions prises pour traiter les réclamations et les rappels et le système d’auto-inspection sont examinés à intervalles réguliers, de façon à vérifier leur conformité avec les principes d’assurance de la qualité.'),
('9.03', 'Des auto-inspections sont conduites préférentiellement par des personnes n’intervenant pas directement dans le procédé observé mais compétentes dans le domaine.'),
('9.04', 'Toutes les auto-inspections font l’objet d’un compte rendu. Les rapports contiennent toutes les observations faites pendant les auto-inspections et, le cas échéant, des propositions de mesures correctives. Des comptes rendus concernant les mesures prises ultérieurement sont également rédigés.'),
('LD1.001', 'Le procédé et l’environnement de préparation sont choisis afin de maitriser les risques de contamination ; ils font régulièrement l’objet d’une évaluation et de contrôles appropriés.'),
('LD1.002', 'Il existe trois principaux procédés de préparation des médicaments stériles :
• la stérilisation terminale ;
• la filtration stérilisante ;
• la préparation aseptique.'),
('LD1.003', 'Lorsqu’elle est envisageable et que l’établissement dispose de l’équipement nécessaire, la stérilisation par la chaleur humide ( autoclave) est la méthode de choix, sauf justification.'),
('LD1.004', 'La préparation, en particulier sa ou ses substance(s) active(s), doit présenter des caractéristiques physico-chimiques lui permettant d’être stérilisée. Les conditions de stérilisation font l’objet d’une validation appropriée. Les paramètres de chaque cycle de stérilisation font l’objet d’un enregistrement.'),
('LD1.005', 'La préparation terminée est présentée dans un conditionnement d''une qualité répondant aux exigences de la Pharmacopée pour les produits stériles.'),
('LD1.006', 'Des mesures sont prises afin d’éviter la présence d’endotoxines bactériennes dans les contenants intermédiaires utilisés lors de la préparation et dans le contenant final.'),
('LD1.007', 'Certaines MPUP qui ne peuvent pas faire l’objet d’une stérilisation terminale peuvent être traitées par filtration, avec un type de filtre adapté, en conformité avec les exigences de la Pharmacopée.'),
('LD1.008', 'L’équipement, les récipients, les fermetures et les fluides en contact avec la solution, et si possible, les composants de la préparation, sont soumis à un procédé de stérilisation approprié.'),
('LD1.009', 'La filtration est à effectuer aussi près que possible du point de remplissage. Les opérations qui suivent la filtration stérilisante sont réalisées dans des conditions et environnement aseptiques de classe A.'),
('LD1.010', 'Les solutions sont filtrées sur un filtre stérile à usage unique à pores de diamètre nominal inférieur ou égal à 0,22 μm. La nature et les caractéristiques du filtre stérilisant sont précisés. La conformité de chaque lot de filtre est garantie par un certificat du fournisseur.'),
('LD1.011', 'Il convient de s’assurer avant filtration de la compatibilité physico-chimique et de la capacité de filtration du filtre avec la solution à filtrer.'),
('LD1.012', 'Il convient de tenir compte de la contamination microbienne (biocharge) avant filtration. Du fait des risques supplémentaires que comporte la filtration, par rapport aux autres méthodes de stérilisation, il peut être recommandé de procéder à une pré-filtration sur un filtre antibactérien dans les cas où il est impossible de limiter la contamination microbienne initiale par d’autres moyens.'),
('LD1.013', 'L’intégrité des filtres est à vérifier après usage, quand la conception du filtre le permet.'),
('LD1.014', 'Toute anomalie observée durant le processus de filtration est enregistrée et examinée. Des actions adaptées sont mises en oeuvre.'),
('LD1.015', 'L’objectif de la préparation aseptique est de maintenir la stérilité d’un produit obtenu à partir de composants stériles en utilisant des matériels de préparation (dispositifs de transfert, articles de conditionnement) stérilisés selon les méthodes décrites à la Pharmacopée.'),
('LD1.016', 'Le moyen d’atteindre cet objectif est d’opérer dans des conditions et au sein d’installations conçues pour empêcher la contamination microbienne, c’est-à-dire dans une zone d’atmosphère contrôlée (ZAC).'),
('LD1.017', 'La préparation aseptique peut être réalisée selon deux procédés différents : le procédé dit « en système clos » et le procédé dit « en système ouvert ».'),
('LD1.018', 'Il s’agit d’un procédé de répartition aseptique permettant le prélèvement et le transfert d’un produit stérile vers un autre contenant stérile dans lequel les systèmes de fermeture des contenants et le matériel de transfert restent en place pendant toute la durée du processus. Le transfert du produit stérile est réalisé à l’aide d’un dispositif de prélèvements (une seringue, une aiguille stérile, une tubulure stérile ou tout autre dispositif de transfert stérile), de telle manière qu’il ne soit jamais en contact avec l’environnement.'),
('LD1.019', 'La préparation est exclusivement réalisée avec du matériel stérile et non réutilisable (par exemple seringues, dispositifs de prélèvement, système de transfert, système de filtration, contenant final) et avec des MPUP stériles ou rendues stériles.'),
('LD1.020', 'Les MPUP utilisées sont principalement des spécialités pharmaceutiques stériles autorisées en France. Elles sont présentées sous forme de poudre, de lyophilisat, de solution, de suspension ou d’émulsion.'),
('LD1.021', 'L’utilisation comme MPUP de préparations hospitalières réservées à la réalisation d’autres préparations est possible à condition qu’elles soient stériles.'),
('LD1.022', 'Les préparations terminées sont des solutions stériles ou des systèmes dispersés stériles issus d’une ou plusieurs opérations (transfert, dissolution, dilution) en système clos et présentées dans un contenant stérile pouvant être adapté à l’administration.'),
('LD1.023', 'La préparation aseptique est considérée en système ouvert dès lors qu’une des étapes de préparation n’est pas réalisée en système clos selon la définition donnée dans le présent document.'),
('LD1.024', 'Une attention particulière est portée sur les contenants intermédiaires, concernant leur qualité microbiologique et la présence éventuelle d’endotoxines bactériennes.'),
('LD1.025', 'La préparation aseptique en système ouvert est associée à une filtration stérilisante (filtre stérilisant à 0,22 μm) sauf exception justifiée.'),
('LD1.026', 'Deux types de risques sont identifiés :
- le risque « produit » c’est-à-dire pour la préparation et donc pour le patient. C’est le risque de contamination microbiologique ;
- le risque pour le personnel et pour l’environnement :
o Les substances actives toxiques comme les médicaments présentant des risques Cancérogène Mutagène Reprotoxique (CMR) répertoriés ou dont les données scientifiques démontrent un risque toxique (par exemple les médicaments antibiotiques, cytotoxiques, antiviraux et radiopharmaceutiques) ;
o Les médicaments d’origine biologique et les médicaments composés en tout ou partie d’Organismes Génétiquement Modifiés (OGM) y compris lorsqu’ils sont des médicaments de thérapie innovante (MTI).'),
('LD1.027', 'Pour chacun de ces deux risques, il est possible d’individualiser des niveaux qui conditionnent le choix de l’équipement et de l’environnement.'),
('LD1.028', 'Risque « faible » de contamination microbiologique
Si la préparation est réalisée par un procédé de transfert en système clos avec du matériel stérile et à usage unique dans une ZAC adaptée et avec des MPUP stériles ou des spécialités pharmaceutiques stériles, alors le risque de contamination microbiologique est considéré comme faible.'),
('LD1.029', 'Risque « élevé » de contamination microbiologique
Si au moins une des étapes de la préparation est réalisée selon un procédé en système ouvert, alors le risque de contamination est considéré comme élevé.'),
('LD1.030', 'Risque potentiel de contamination microbiologique
Un risque potentiel de contamination microbiologique du produit peut apparaitre si, par exemple :
- le produit constitue un milieu favorable à la croissance des micro-organismes,
- le procédé de préparation implique une période d’attente avant la stérilisation.'),
('LD1.031', 'Deux niveaux de risques sont identifiés en fonction de la présentation et des manipulations réalisées sur les produits à risque. Par exemple :
- Un risque élevé peut correspondre à la manipulation de produits pulvérulents en système ouvert.
- Un risque faible peut correspondre à la manipulation de spécialités pharmaceutiques stériles en transfert clos.'),
('LD1.032', 'Les locaux de préparation de médicaments stériles sont constitués d’un ensemble de pièces et/ou de zones de dimensions appropriées dont les fonctions sont liées directement à l’acte de préparation des médicaments stériles. Ils comprennent notamment les zones de préparation et les locaux annexes (vestiaires, zones de supervision, locaux de stockage, locaux pour déchets, locaux pour ménage …). La disposition des locaux tient compte de l’objectif de maîtrise de la contamination liée aux flux depersonnel, de matériel et de produits.'),
('LD1.033', 'Pour la préparation de médicaments stériles, quatre classes de ZAC sont utilisées (A, B, C et D). Ces classes se définissent notamment par un nombre maximal autorisé de particules par unité de volume dans la zone.'),
('LD1.034', 'Le choix des installations et équipements fait l’objet d’une analyse de risques préalable et documentée, prenant en compte la nature des produits manipulés,la protection des personnes et de l’environnement.'),
('LD1.035', 'Les zones d’atmosphère contrôlée (ZAC) sont constituées de locaux et d’équipements dont les qualités microbiologique et particulaire sont maîtrisées. Ces locaux et équipements sont qualifiés et leur maintenance est assurée.'),
('LD1.036', 'Les ZAC destinées à la préparation des médicaments stériles sont classées selon les qualités requises pour leur environnement. Chaque opération de préparation requiert un niveau approprié de propreté de l’environnement « en activité » de façon à réduire au minimum le risque de contamination particulaire ou microbienne des produits ou des substances manipulés.'),
('LD1.037', 'Les ZAC sont classées selon le tableau 1 qui indique le nombre maximal autorisé de particules de taille égale ou supérieure à 0,5 μm et 5 μm par m3. Cette classification est distincte de la surveillance microbiologique de l’environnement. Ce tableau donne les caractéristiques particulaires de ces différentes zones « au repos » et « en activité ».'),
('LD1.038', 'Afin de satisfaire aux conditions requises « en activité », ces zones sont conçues de manière à atteindre des niveaux définis de propreté de l’air au « repos ». On entend par « au repos », la situation où l’installation avec le matériel de production en place est achevée et opérationnelle, sans que les opérateurs soient à leur poste. On entend par « en activité », la situation où les installations fonctionnent selon le mode opératoire défini et en présence du nombre prévu d’opérateurs.'),
('LD1.039', 'Les caractéristiques particulaires indiquées dans la colonne « au repos » sont à respecter en l’absence de personnel, à l’arrêt de la production après un temps d’épuration dépendant des caractéristiques de l’installation.'),
('LD1.040', 'L’entrée et la sortie dans une ZAC se fait par des sas. Les sas sont des volumes de transit entre les zones propres et non classées ou entre des locaux classés mais de risques différents. Les sas peuvent être des locaux ou des zones de circulation.'),
('LD1.041', 'Les sas participent au maintien du gradient de pression et de la classification de la ZAC dans laquelle ils donnent accès. Les sas font partie de la ZAC et leur surveillance et leur contrôle sont identiques à celui des ZAC.'),
('LD1.042', 'Les sas personnels et les vestiaires sont distincts. Les vestiaires sont conçus pour séparer les vêtements de ville et de travail et participent à la maîtrise des flux du personnel. Les sas personnels permettent au personnel de revêtir la tenue appropriée à la classe cible du local de la ZAC dans lequel il entre.'),
('LD1.043', 'Les différentes portes d’un sas ne peuvent pas être ouvertes en même temps. Un système de blocage alterné (asservissement mécanique ou électronique des portes) est utilisé en vue d’empêcher l’ouverture de plus d’une porte à la fois. Le cas échéant, une temporisation est programmée.'),
('LD1.044', 'Dans les ZAC, toutes les surfaces apparentes (y compris les plafonds) sont lisses, lavables, imperméables et sans fissure afin de réduire la libération ou l’accumulation de particules ou de microorganismes et de permettre l’usage répété de produits de nettoyage et, le cas échéant, de désinfectants.'),
('LD1.045', 'La pose de carrelage est à proscrire en lien avec la difficulté de nettoyage des joints. Les remontées en plinthes affleurantes évitent l’accumulation de poussières.'),
('LD1.046', 'Les faux plafonds sont scellés pour éviter les contaminations provenant de l’espace supérieur. Ils sont étanches pour garantir le maintien du gradient de pression dans une ZAC.')
ON CONFLICT (ref) DO UPDATE SET texte = EXCLUDED.texte;
INSERT INTO ref_texts (ref, texte) VALUES
('LD1.047', 'Les canalisations et les gaines sont installées de façon à ne pas créer de recoins, d’orifices non scellés et de surface difficiles à nettoyer.'),
('LD1.048', 'Les éviers et les canalisations d’évacuation sont exclus des zones de classe A et B.'),
('LD1.049', 'Une cascade de pression positive est maintenue en toute circonstance afin d’obtenir la classe de propreté la plus adaptée au niveau de la zone de préparation. Les zones entre lesquelles il est important de maintenir une différence de pression sont équipées d’indicateurs de différentiel de pression. Un relevé de ces indicateurs est effectué.'),
('LD1.050', 'Une zone est prévue pour le décartonnage. En effet, pour la réalisation de préparations stériles, les produits sont déconditionnés de leurs conditionnements externes en dehors de la zone de préparation.'),
('LD1.051', 'Une alimentation en air filtré est maintenue en toutes circonstances afin de garantir une pression positive et une circulation d’air par rapport aux zones voisines de classe inférieure. Les écarts de pression entre locaux adjacents relevant de classes différentes sont compris entre 10 et 15 pascals.'),
('LD1.052', 'L’alimentation en air filtré est munie d’un système d’alarme détectant et enregistrant toute déficience. Le pharmacien désigné comme responsable des préparations est informé dans les meilleurs délais de toute déficience.'),
('LD1.053', 'Il est démontré que le schéma aéraulique ne présente pas de risque de contamination. Il faut éviter que la circulation de l’air n’entraîne les particules provenant d’une personne, d’une opération ou d’une machine, vers une zone de plus haut risque pour la préparation. Les bouches de soufflage et de reprise d’air sont positionnées de façon adaptée.'),
('LD1.054', 'Le pharmacien désigné comme responsable des préparations dispose du schéma aéraulique de la zone de préparation et des zones contrôlées attenantes.'),
('LD1.055', 'L’accès aux locaux techniques contenant notamment les Centrales de Traitement d’Air (CTA) ne se fait pas à partir des zones classées.'),
('LD1.056', 'Pour atteindre les classes B, C et D, le taux de brassage horaire d’air est connu et adapté à la taille du local ainsi qu’aux équipements et effectifs qui y sont présents. Le système du traitement d’air est muni de filtres appropriés, tel que des filtres à air à haute efficacité (HEPA).'),
('LD1.057', 'Le taux de renouvellement d’air est adapté à l’utilisation de la ZAC.'),
('LD1.058', 'Pour ces produits, le système de traitement d’air est conçu dans le respect des normes environmentales et de sécurité du personnel.'),
('LD1.059', 'Pour les préparations de médicaments à risque pour le personnel, il peut être nécessaire de placer certaines zones en dépression (notamment lors de la manipulation de produits pulvérulents). Dans ce cas, il est nécessaire de mettre en oeuvre une conception des locaux et équipements permettant de garantir la qualité microbiologique de la préparation terminée.'),
('LD1.060', 'Les zones de stockage et de dé-cartonnage permettent un confinement. Un gradient de pression négatif par rapport aux locaux adjacents est un moyen d’y parvenir. Une attention particulière est portée sur l’organisation de ces zones afin de diminuer le risque de contamination.'),
('LD1.061', 'L’air d’un poste à flux d’air unidirectionnel peut présenter un écoulement dans deux sens : horizontal ou vertical. L’air est distribué dans une seule direction sur toute la surface à protéger.'),
('LD1.062', 'Un local contenant le ou les postes à flux d’air unidirectionnel répond à une classe d’atmosphère contrôlée de grade B ou C en fonction du procédé.'),
('LD1.063', 'Les opérations de transfert vers l’intérieur et vers l’extérieur du flux d’air unidirectionnel sont les plus importantes sources potentielles de contamination microbiologique. Ces opérations d’entrée et de sortie font l’objet de procédures validées et mises en application.'),
('LD1.064', 'Pendant la préparation, une alimentation en air filtré maintient une pression positive en toutes circonstances.'),
('LD1.065', 'Tout dysfonctionnement du système de traitement d’air est détecté et signalé par une alarme.'),
('LD1.066', 'Une surveillance régulière des paramètres physiques et microbiologiques est effectuée.'),
('LD1.067', 'Dans ce cas, seuls les postes de sécurité microbiologique de types II ou III peuvent être utilisés avec un rejet à l’extérieur du bâtiment de l’air extrait. Pendant la préparation, l’alimentation en air filtré est maintenue en toutes circonstances.'),
('LD1.068', 'Le schéma aéraulique tient compte du risque pour l’opérateur et pour l’environnement.'),
('LD1.069', 'L’isolateur est un équipement qui emploie des techniques de barrière physique étanche pour effectuer la séparation entre un environnement maîtrisé interne et un environnement extérieur, entre un procédé et le personnel. C’est un équipement clos qui n’échange pas d’air non filtré ou de contaminants avec l’environnement adjacent et dont les surfaces intérieures subissent régulièrement une stérilisation de contact, selon un procédé et une fréquence validés. Tout objet (matériel, médicament, dispositif médical…) introduit dans l’isolateur subit un cycle de stérilisation de contact lors de son introduction dans l’enceinte.'),
('LD1.070', 'Les isolateurs peuvent être constitués d’une paroi souple ou rigide dont l’étanchéité est régulièrement vérifiée. L’isolateur est équipé d’un système de ventilation autonome, pourvu en amont et en aval de filtres HEPA. Le système de ventilation permet de placer l’isolateur en surpression ou en dépression avec un différentiel de pression correspondant aux recommandations du fabricant.'),
('LD1.071', 'Une surveillance régulière est effectuée et comprend notamment des essais d’étanchéité de l’isolateur, de ses annexes et des gants de manipulation.'),
('LD1.072', 'Les gants de l’isolateur ne sont pas réutilisables et sont remplacés selon une fréquence à déterminer en fonction de l’activité.'),
('LD1.073', 'Les isolateurs permettant de préparer des médicaments stériles sont essentiellement en pression positive (surpression) par rapport à l’environnement externe. Au minimum, ils sont situés dans une ZAC de classe D.'),
('LD1.074', 'Les opérations de transfert vers l’intérieur et vers l’extérieur de l’isolateur sont les plus importantes sources potentielles de contamination microbiologique. Ces opérations d’entrée et de sortie font l’objet de procédures validées et mises en application. Les dispositifs de doubles-portes à connexion étanches permettant de garantir un continuum stérile et un confinement des produits ou des déchets toxiques sont à privilégier.'),
('LD1.075', 'Les dispositifs de préparation et l’ensemble du matériel nécessaire à la préparation ou à son contrôle sont stériles et sont introduits par l’intermédiaire de sas dans l’isolateur de travail. Ils sont obligatoirement soumis à un procédé validé de stérilisation de contact. Alternativement, des dispositifs double-portes à connexion étanche peuvent permettre l’entrée directe de matériels conditionnés en conteneurs stériles.'),
('LD1.076', 'La mise en oeuvre du procédé de stérilisation de contact des surfaces à l’intérieur de l’isolateur garantissant la décontamination nécessite une analyse de risque préalable et est soumise à un processus de validation adapté. Ce procédé de stérilisation par contact doit garantir l’intégrité du fonctionnement de l’équipement.'),
('LD1.077', 'L’utilisation d’un agent stérilisant par contact de l’air et des surfaces par vaporisation dans l’isolateur et ses annexes est obligatoire et est validée.'),
('LD1.078', 'La validation du procédé de stérilisation de contact est à effectuer avec l’utilisation d’une charge représentative de l’activité et à l’aide d’indicateurs biologiques tels que décrits au chapitre 5.1.2 de la Pharmacopée Européenne.'),
('LD1.079', 'Les isolateurs utilisés pour la réalisation des médicaments stériles à risque pour le personnel et l’environnement et effectuée selon un procédé en système clos peuvent être placés en pression positive par rapport à l’environnement externe.'),
('LD1.080', 'Dans le cas où la préparation est réalisée selon un procédé en système ouvert et utilisant une ou plusieurs MPUP pulvérulentes, l’utilisation d’un isolateur placé en pression négative par rapport à l’environnement externe est préférée.'),
('LD1.081', 'La ZAC contenant un isolateur en dépression est toujours de classe C.'),
('LD1.082', 'Le schéma aéraulique est disponible pour le pharmacien désigné comme responsable des préparations et tient compte du risque pour l’opérateur et pour l’environnement.'),
('LD1.083', 'Le nettoyage, la désinfection des ZAC sont essentiels. Les zones sont nettoyées de façon approfondie, conformément à une procédure validée.'),
('LD1.084', 'Le choix de la solution désinfectante et de son système de diffusion ou de dispersion est validé.'),
('LD1.085', 'Une surveillance microbiologique régulière des ZAC est nécessaire en vue de détecter tout développement microbien.'),
('LD1.086', 'Les fréquences de nettoyage / désinfection décrites dans le tableau 2 sont données à titre de recommandations : Les fréquences de ce tableau sont données à titre indicatif et à adapter à l’activité de production (par exemple ajouter un nettoyage immédiat en cas de souillure d’une surface, d’un équipement ou d’un accessoire).'),
('LD1.087', 'Le suivi du nettoyage / désinfection est à documenter afin que celui-ci puisse être utilisé dans la prise de décisions de la libération des lots de préparations stériles.'),
('LD1.088', 'Les surfaces internes de l’équipement de classe A sont régulièrement nettoyées, désinfectées et prélevées pour garantir la propreté microbiologique de l’enceinte. L’utilisation d’une solution détergente permet le nettoyage. Elle doit être associée à une solution de désinfection. Les fréquences de nettoyage /désinfection décrites dans le tableau 3 sont données à titre de recommandations.'),
('LD1.089', 'Les opérations de nettoyage / désinfection de l’équipement de classe A sont effectuées par le personnel réalisant les opérations de préparation.'),
('LD1.090', 'Les opérations de stérilisation par contact décrit dans ce chapitre ne remplacent pas la nécessité de réaliser un nettoyage / désinfection.'),
('LD1.091', 'L’ensemble des équipements, locaux et zones composant la ZAC sont requalifiées au minimum 1 fois par an afin de prouver le maintien de la conformité aux classes de propreté définie. Des requalifications supplémentaires intermédiaires peuvent se justifier en fonction de l’utilisation de la ZAC (comme la mise en place d’un nouvel équipement).'),
('LD1.092', 'L’ensemble des équipements, locaux et zones composant la ZAC est qualifié selon les textes, normes et référentiels en vigueur.'),
('LD1.093', 'A l’issue de la qualification de l’ensemble des équipements, locaux et zones composant la ZAC, les fréquences des contrôles physiques et microbiologiques d’air et de surface sont définies en fonction de leur utilisation et des anomalies éventuellement rencontrées.'),
('LD1.094', 'Une maintenance préventive régulière est réalisée selon des procédures et un plan préétablis. Les interventions n’affectent pas le fonctionnement des ZAC.'),
('LD1.095', 'Entre deux opérations de qualification et après une maintenance, le contrôle de certains paramètres permet de s’assurer du bon fonctionnement des matériels et installations.'),
('LD1.096', 'Les tests à effectuer lors des qualifications/requalifications des ZAC et équipements sont décrits dans le tableau 4 et des fréquences minimales sont données à titre de recommandations.'),
('LD1.097', 'Dans la mesure du possible, les matériels, les appareils et les installations techniques sont conçus et installés afin que les interventions, l’entretien et les réparations soient effectués à l’extérieur de la ZAC.'),
('LD1.098', 'Lorsque l’entretien des matériels est effectué au sein de la ZAC, et s’il apparaît que les conditions de propreté n’ont pas pu être maintenues pendant les opérations d’entretien, cette zone est nettoyée, désinfectée jusqu’à obtention d’un niveau de propreté microbiologique adapté avant toute nouvelle utilisation.'),
('LD1.099', 'L’équipement métrologique, audiovisuel et informatique nécessaire à la vérification en cours de préparation (balance, caméra, moniteur, pédale…) est autorisé dans la ZAC sous certaines conditions. Les appareils audiovisuels et informatiques permettant l’utilisation « mains libres », sont constitués de matériaux limitant l’émission de particules et présentant une surface lisse, non poreuse, nettoyable et résistante aux produits de nettoyage voire de stérilisation de contact.'),
('LD1.100', 'Le cablage nécessaire au fonctionnement des appareils est conçu pour faciliter le nettoyage.'),
('LD1.101', 'Un système de communication fonctionnel est installé pour faciliter la communication verbale entre les différentes zones.'),
('LD1.102', 'Le pharmacien désigné comme responsable des préparations stériles a pour mission d’élaborer, d’organiser et de surveiller l’ensemble des activités liées à la préparation de produits stériles. Il possède un niveau de connaissance adéquat pour avoir cette responsabilité.'),
('LD1.103', 'Le personnel encadrant (pharmacien et cadre) l’activité de préparation stérile possède une connaissance approfondie du fonctionnement de la ZAC (cascade de pression, CTA, position des filtres HEPA,…) et du type de poste de travail (isolateur, poste à flux d’air unidirectionnel, …).'),
('LD1.104', 'Le personnel travaillant dans des ZAC est pleinement conscient des conséquences potentielles de toute déviation aux procédures validées, pour l’intégrité de la préparation et donc pour la sécurité et du personnel.'),
('LD1.105', 'Le nombre de personnes présentes dans les zones de préparation est minimum : l’accès aux différentes zones est limité. Le déplacement du personnel dans ces zones est maîtrisé.'),
('LD1.106', 'Toutes les personnes amenées à entrer dans ces zones reçoivent une formation initiale appropriée et sont régulièrement réévaluées. Cette formation comporte des éléments relatifs à la connaissance des Bonnes Pratiques de Préparation (BPP).'),
('LD1.107', 'Une personne ne pourra réaliser une préparation stérile à destination d’un patient que si elle a réussi avec succès l’évaluation de sa formation, qui comprend un test de remplissage aseptique, pour la réalisation des médicaments stériles.'),
('LD1.108', 'Les connaissances et les pratiques sont maintenues à jour. Une évaluation du personnel est organisée au moins une fois par an selon le niveau de risque des préparations réalisées.'),
('LD1.109', 'Les fréquences de formations et d’évaluations pour la réalisation de préparations aseptiques décrites dans le Tableau 5 sont données à titre de recommandations.'),
('LD1.110', 'Une propreté et une hygiène personnelle sont essentielles. Les membres du personnel participant à la préparation de médicaments stériles signalent à la personne responsable de ces activités, toute affection qui pourrait constituer un risque de contamination. Ce responsable prend toutes les mesures nécessaires afin d’éviter la contamination des locaux, des préparations et du personnel.'),
('LD1.111', 'Les montres bracelets, le maquillage (incluant le vernis à ongle), les bijous et autres objets personnels tels que les téléphones portables ne sont pas autorisés dans ces zones.'),
('LD1.112', 'Le type d’habillage est approprié au procédé de production et au niveau de propreté de la zone de travail. Des vêtements et équipements de protection sont portés afin de protéger le produit de toute contamination issue des opérateurs. Ainsi, les vêtements personnels ne sont pas amenés dans les sas personnels menant aux zones de classe C ou de classe B.'),
('LD1.113', 'Les vêtements, y compris les gants, les masques et autres protections et leur qualité sont adaptés aux préparations et aux classes des zones de travail. Les types de vêtements et d’équipements requis pour chaque classe sont décrits ci-dessous :
• Classe D : Les cheveux et, le cas échéant, la barbe sont couverts. Un vêtement protecteur et des chaussures ou des couvre-chaussures adaptés sont à porter. Des mesures appropriées sont prises en vue d’éviter toute contamination provenant de l’extérieur de la ZAC ;
• Classe C : Les cheveux et le cas échéant, la barbe et la moustache sont couverts. Un masque couvrant le visage pour éviter l’émission de gouttelettes est utilisé si nécessaire. Des gants sont à porter. Ils sont stériles si besoin. Un vêtement constitué d’une veste et d’un pantalon ou d’une combinaison, serré aux poignets et muni d’un col montant, ainsi que de chaussures ou couvre-chaussures adaptés sont à porter. Le tissu ne libère pratiquement pas de fibres ou de particules ;
• Classes A et B : Un vêtement protecteur propre et stérile, ainsi que masques, gants et autres protections stériles sont portés par chaque opérateur en zone de classe A et B. Une cagoule enferme totalement les cheveux et, le cas échéant, la barbe et la moustache ; cette cagoule est reprise dans le col de la veste ; un masque couvre le visage pour éviter l''émission de gouttelettes. Des gants stérilisés et non poudrés, ainsi que des bottes stérilisées ou désinfectées sont à porter. Le bas du pantalon est enserré dans les bottes, de même que les manchettes dans les gants. Ce vêtement protecteur ne libère pratiquement ni fibres ni particules et retient les particules émises par l’opérateur.'),
('LD1.114', 'Les étapes d’habillage et de lavage des mains suivent une procédure conçue pour réduire la contamination des vêtements propres et pour limiter l’entrée de contaminants dans les zones propres.'),
('LD1.115', 'La fréquence de changement des gants stériles est définie en fonction de l’activité et du type de MPUP manipulée.'),
('LD1.116', 'Le personnel extérieur amené à pénétrer dans ces locaux (ex : personnel de sociétés d’entretien, de construction ou de nettoyage) est informé des procédures applicables dans la ZAC et les respecte.'),
('LD1.118', 'Les tableaux ci-après fournissent des indications sur la classe minimum à justifier en fonction des opérations qui y sont réalisées. Ces tableaux tiennent compte des niveaux de risque définis dans les généralités.'),
('LD1.119', 'Tableau 6 : Avec stérilisation terminale dans leur récipient final et avec un risque potentiel de contamination microbiologique.'),
('LD1.120', 'Tableau 7 : Avec stérilisation terminale dans leur récipient final et sans risque potentiel decontamination microbiologique.'),
('LD1.121', 'Tableau 8 : Si préparation aseptique.'),
('LD1.122', 'Si la réalisation de la préparation fait intervenir un procédé de filtration stérilisante, le tableau 8 est adapté.'),
('LD1.123', 'Les préparations stériles sont réalisées dans des ZAC qui sont classées selon leur niveau attendu de maîtrise de la contamination. Chaque opération de préparation requiert un niveau approprié de propreté de l’environnement de façon à réduire le risque de contamination particulaire ou microbienne des MPUP et des préparations terminées.'),
('LD1.124', 'Les MPUP utilisées pour la préparation des médicaments stériles sont de préférence des spécialités pharmaceutiques stériles. A défaut, les MPUP utilisées répondent aux spécifications de la Pharmacopée concernant notamment la contamination microbiologique initiale et les endotoxines bactériennes.'),
('LD1.125', 'Dans le cas de préparations réalisées à partir de MPUP non stériles, le niveau de contamination initiale des MPUP est évalué et doit être minimal.'),
('LD1.126', 'Des précautions sont prises aux différents stades de la préparation pour maîtriser et limiter les risques de contamination microbiologique.'),
('LD1.127', 'Les articles de conditionnement sont adaptés à leur usage. Les articles de conditionnement primaire utilisés pour la réalisation des préparations sont stériles et apyrogènes.'),
('LD1.128', 'Des procédures et modes opératoires spécifiques décrivant les différents flux intervenant pour la réalisation des préparations stériles (MPUP, déchets, préparations terminées, personnel) sont utilisés et validés.'),
('LD1.130', 'L’entreposage est limité au strict minimum dans les ZAC de classes A et B. Dans les ZAC de classes C et D les stockages y sont limités.'),
('LD1.131', 'La température ambiante et l’humidité sont maîtrisées pour la protection du produit et pour le confort des opérateurs, notamment en raison du type de vêtements portés dans ces zones classées.'),
('LD1.132', 'Dans la mesure du possible, les récipients et les produits susceptibles de libérer des particules ne sont pas introduits dans les ZAC.'),
('LD1.133', 'Les accessoires, les récipients, le matériel et tout autre article nécessaire en zone de préparation d’atmosphère contrôlée classé A, lors de préparations aseptiques, sont préalablement stérilisés par une méthode de la Pharmacopée ou par une autre méthode équivalente et sont introduits dans la zone selon un système validé de transfert ne permettant pas l’introduction de contaminants.'),
('LD1.134', 'Dans le cas de l’utilisation de matériel, récipient, accessoire ou tout autre article non stérile pour la réalisation d’une préparation stérile, il convient de s’assurer que le procédé de stérilisation utilisé est adapté. La stérilisation de contact du matériel ou de produit non stérile ne peut se substituer à une méthode de stérilisation terminale.'),
('LD1.135', 'L’intervalle de temps entre le nettoyage, le séchage et la stérilisation des accessoires, des récipients et du matériel, ainsi qu’entre la stérilisation et l’utilisation, est le plus court possible. Une durée limitée est fixée en fonction des conditions de stockage.'),
('LD1.136', 'Après leur nettoyage, les accessoires, les récipients et le matériel sont manipulés de façon à ne pas être re-contaminés.'),
('LD1.137', 'L’intervalle de temps entre le début de la préparation de la solution, sa filtration et sa stérilisation est le plus bref possible.'),
('LD1.138', 'La validation des procédés de préparation aseptique comprend une simulation du procédé (ou test de remplissage aseptique) à l’aide de milieux de culture. L’essai de simulation se rapproche le plus possible des procédés de préparation aseptique et en comprend toutes les étapes. Il est réalisé par un personnel préalablement qualifié pour la préparation aseptique. Cette simulation est répétée après toute modification importante du procédé, par exemple modification de l’équipement utilisé.'),
('LD1.139', 'Il convient de veiller à ce que les opérations de validation n’entraînent aucun risque pour les préparations.'),
('LD1.140', 'Quelle que soit la taille du lot, la garantie de la stérilité est assurée par le respect d’un ensemble de conditions et de paramètres couvrant en particulier la validation et la maitrise des procédés de préparation et de stérilisation, la qualification des installations et des équipements, la qualité des MPUP et des articles de conditionnement, les contrôles microbiologiques et particulaires de l’environnement et la formation initiale et continue du personnel.'),
('LD1.141', 'L’essai de stérilité ou une méthode équivalente validée et appliquée à la préparation terminée est considéré comme le dernier d’une série de contrôles permettant de garantir la stérilité.'),
('LD1.142', 'Les échantillons prélevés pour l’essai de stérilité sont représentatifs du lot dans les conditions prévues par la Pharmacopée dans le cas de production en série. Pour les préparations magistrales dont la taille des lots ne permet pas de suivre les prescriptions de la Pharmacopée Européenne, le pharmacien en charge de la libération évalue le risque associé à la stérilité en prenant en compte, notamment, les différents paramètres critiques lui permettant d’avoir une garantie suffisante en vue de la libération de la préparation.'),
('LD1.143', 'Dans le cas où la réalisation des préparations fait intervenir un procédé identique, un plan spécifique d’échantillonnage microbiologique peut être réalisé. Ce plan spécifique est représentatif du moment de production étudié et prend en compte tout changement intervenu dans le procédé (par exemple lors d’un changement de personnel).'),
('LD1.144', 'Quelle que soit la taille du lot, pour les préparations faisant intervenir plus de 2 substances actives, il convient de mettre en place une organisation permettant de maitriser les risques d’erreur liés au nombre de substances actives (inversion / omission / addition) intervenant dans la préparation.'),
('LD1.145', 'Un dossier de lot pour chaque préparation est réalisé. Une libération pharmaceutique est organisée et procédurée comme définie par la stratégie libératoire (décrit au chapitre 6).'),
('LD1.146', 'Il convient de porter une attention particulière aux résultats de la surveillance des ZAC lors de la libération des préparations terminées.'),
('LD1.147', 'Des seuils d’alerte et d’action appropriés sont définis dans une procédure pour les résultats de la surveillance particulaire et microbiologique. En cas de dépassement de ces limites, des procédures imposent des mesures correctives.'),
('LD1.148', 'Ces seuils tiennent compte notamment de la nature du germe et de son potentiel de dissémination (par exemple, présence d’un champignon filamenteux).')
ON CONFLICT (ref) DO UPDATE SET texte = EXCLUDED.texte;
INSERT INTO ref_texts (ref, texte) VALUES
('LD1.149', 'Les opérations aseptiques sont systématiquement surveillées en activité par des contrôles microbiologiques adaptés afin de détecter un niveau inhabituel de contamination.'),
('LD1.150', 'Un plan d’échantillonnage est défini et comprend l’analyse d’échantillons volumétriques d’air et des contrôles de surface. Il tient compte d’une analyse de risques, des normes ISO en vigueur et définit notamment les lieux, la fréquence et le nombre de prélèvements.'),
('LD1.151', 'Les méthodes d’échantillonnage utilisées en activité n’interférent avec la protection des zones.'),
('LD1.152', 'Le procédé de stérilisation de contact ne modifie pas la qualité des milieux de culture utilisés.'),
('LD1.153', 'Une surveillance microbiologique supplémentaire peut être également nécessaire en dehors des phases de préparation, par exemple après les opérations de validation, de maintenance, de nettoyage ou de désinfection.'),
('LD1.154', 'Les limites concernant la surveillance microbiologique des ZAC décrites dans le tableau 9 sont données à titre de recommandations.'),
('LD1.155', 'Les fréquences minimum de surveillance microbiologique décrites dans le tableau 10 sont données à titre de recommandations.'),
('LD1.156', 'Le bon fonctionnement des sas ou d’autres dispositifs permettant les transferts de produits est vérifié lors des qualifications et après toute intervention sur ce système.'),
('LD1.157', 'La surveillance des différences de pression est assurée à chaque début de session de production et aussi souvent que nécessaire. Cette surveillance fait l’objet d’un enregistrement au minimum quotidien.'),
('LD1.158', 'Des essais de laminarité, de vitesse, de débit et d’intégrité des filtres sont planifiés au minimum 1 fois par an et davantage si nécessaire.'),
('LD1.159', 'Au repos, les zones sont soumises à une surveillance régulière afin de contrôler la qualité particulaire correspondant aux différentes classes.'),
('LD1.160', 'Une liste non exhaustive d’éléments à surveiller décrits dans le Tableau 11 est donnée à titre de
recommandations.'),
('LD2.001', 'Des bases de données bibliographiques comme l’Institut National de Recherche et de Sécurité (INRS), le Centre de Référence sur les Agents Tératogènes (CRAT) ou le Centre International de Recherche sur le Cancer (CIRC) peuvent être consultées. Pour les reconstitutions de MTI des données sont disponibles auprès de l’agence nationale de sécurité sanitaire de l’alimentation, de l’environnement et du travail dans la réglementation et dans l’autorisation de mise sur le marché du MTI.'),
('LD2.002', 'Dans ce cas, la détermination du danger intrinsèque se fait à l’aide des mentions de « danger » codifié par le règlement européen CLP39 (Classification, Labelling and Packaging of substances and mixtures). Il apparait sur l’étiquetage des MPUP ou dans les fiches de données de sécurité.'),
('LD2.003', 'Les fiches de données de sécurité ou des documents équivalents sont mis à la disposition du personnel.'),
('LD2.004', 'Les mentions de « danger » sont codifiées à l’aide d’un code alphanumérique composé d’une lettre et de trois chiffres :
- La lettre « H » (pour « mention de danger ») ;
- Un chiffre désignant le type de danger, par exemple « 3 » pour les dangers d’exposition ;
- Deux chiffres correspondant à la numérotation des dangers tels que « toxicité aigüe ».'),
('LD2.005', 'Dans ce cas, la mention de « danger » peut ne pas être disponible. Le Résumé des Caractéristiques Produits (RCP) est étudié pour recueillir les informations utiles (effet pharmacologique et effets indésirables, dose usuelle, toxicité aigüe, toxicité chronique, mutagénicité).'),
('LD2.006', 'Les valeurs limites d’exposition professionnelle sont utilisées lorsqu’elles sont connues.'),
('LD2.007', 'L’exposition est fonction des caractéristiques physico-chimiques, de la quantité manipulée, de la fréquence, de la durée de manipulation de la substance ainsi que des conditions de sa mise en oeuvre.'),
('LD2.008', 'L’exposition varie en fonction notamment de l’utilisation :
- d’EPC permettant un confinement ;
- d’EPI adaptés à la substance manipulée.'),
('LD2.009', 'L’évaluation du danger lié à l’exposition prend en compte tous les éléments définis aux points 6 à 8.'),
('LD2.010', 'Le niveau d’exposition au danger est définit et réévalué annuellement pour chaque groupe de personnel ayant la même exposition (personnel chargé de la préparation, personnel chargé de l’entretien, personnel chargé du contrôle de qualité). Le niveau d’exposition permet, le cas échéant, de définir des mesures de protection supplémentaires à mettre en oeuvre afin de pouvoir manipuler les substances étudiées ou de décider de l’arrêt de la préparation.'),
('LD2.011', 'En cas de recherche de substances dangereuses ou de leurs métabolites sur le personnel intervenant dans la réalisation des préparations, l’interprétation des résultats se fait par la médecine du travail et le cas échéant, avec des spécialistes en toxicologie.'),
('LD2.012', 'L’employeur est responsable de la sécurité du personnel travaillant dans les zones de préparation. Il associe à l’analyse de risque le pharmacien désigné comme responsable des préparations.'),
('LD2.013', 'Le personnel manipulant des substances pouvant présenter un risque pour la santé est qualifié et reçoit une formation complémentaire, accompagnée d’une évaluation. Elle aborde notamment une information sur :
- la nature des produits manipulés ;
- l’identification et la compréhension des risques notamment grâce à la connaissance de l’étiquetage ;
- les dispositifs de protection collective et individuelle à utiliser ;
- la conduite à tenir en cas d’incident et l’utilisation des kits de décontamination et de(s) trousse(s) d’urgence ;
- le dispositif existant de déclaration des accidents d’exposition.'),
('LD2.014', 'Une formation spécifique s’applique également au personnel affecté au nettoyage, à l’entretien, au réapprovisionnement de la zone, à l’évacuation des déchets et à la maintenance. Dans le cas où ces prestations sont sous-traitées, le prestataire est informé de ces spécificités afin qu’il forme le personnel affecté à ses missions.'),
('LD2.015', 'L’habillage et les équipements de protection sont adaptés à l''usage et au risque potentiel encouru, y compris au cours des opérations de nettoyage ou de maintenance réalisées à l’intérieur de la zone de préparation. Les mêmes dispositions sont prises lors du changement de matériel.'),
('LD2.016', 'Une surveillance médicale adaptée et régulière est mise en place. Un suivi des accidents du travail et des pathologies professionnelles est réalisé en lien avec la médecine du travail.'),
('LD2.017', 'La protection des femmes enceintes ou allaitantes est assurée dans les conditions prévues par le droit du travail.'),
('LD2.018', 'Un kit de décontamination et une trousse d’urgence établis après avis du médecin du travail sont disponibles sur place.'),
('LD2.019', 'Des locaux différents avec un niveau de confinement adapté correspondant à l’activité la plus à risque sont dédiés notamment pour l’activité de :
* Préparations non stériles contenant des substances pouvant présenter un risque pour la santé et l’environnement. Dans le cas où l’organisation des locaux de préparation ne permet pas d’avoir un local dédié à la réalisation des préparations non stériles contenant des substances pouvant présenter un risque pour la santé et l’environnement, l’utilisation de zones dédiées peut être envisagée en fonction du risque. Dans ce cas, les zones garantissent un niveau de confinement adapté au risque d’exposition.
* Préparations stériles contenant des substances pouvant présenter un risque pour la santé et l’environnement avec deux types de locaux :
- un local pour les préparations contenant des substances chimiques pouvant présenter un risque pour la santé et l’environnement,
- un local pour les préparations contenant des substances biologiques (par exemple la reconstitution des Médicaments de Thérapie Innovante (MTI) ou la mise sous forme appropriée des Médicaments de Thérapie Innovante Préparés Ponctuellement (MTIPP) et chimique (non CMR). Les équipements utilisés sont différents pour les préparations biologiques et les préparations chimiques. A défaut un même équipement
peut être utilisé en fonction de l’analyse de risque. Il n’est pas possible de réaliser des préparations non stériles dans les mêmes locaux que les préparations stériles.'),
('LD2.020', 'Pour la reconstitution des MTI de thérapie génique et la mise sous forme appropriée des MTI-PP de thérapie génique :
- dans le cadre d’un essai clinique, le promoteur informe le pharmacien désigné comme responsable des préparations à la PUI, de la déclaration d’utilisation confinée qu’il a réalisée et du récépissé délivré par l’ANSM qui mentionne les préconisations à mettre en place ;
- en dehors des essais cliniques, les préconisations de reconstitution ou de mise sous forme appropriée figurent dans le RCP de l’AMM, dans l’autorisation délivrée par l’ANSM au titre de l’article L. 5121-1 17° du Code de la santé publique ou dans les autorisations de mise sur le marché d’OGM délivrées par l’ANSM, le cas échéant.'),
('LD2.021', 'Les manipulations des médicaments qui comportent des risques potentiels de dispersion d’OGM identifiés à partir de l’analyse de risque spécifique sont effectuées sous des postes à flux d’air unidirectionnel de type II ou des isolateurs. Ainsi, la décongélation hors d’une poste à flux d’air unidirectionnel de type II ou des isolateurs est possible pour les médicaments OGM de classe de confinement C1 si les contenants ne nécessitent pas d’être ouverts. Règlement n°1394/2007du parlement européen et du conseil du 13 novembre 2007 concernant les médicaments de thérapie innovante 43 Article L. 5121-1 du  CSP - alinéa 17'),
('LD2.022', 'Pour éviter les contaminations croisées, le principe de production « par campagne » dans les mêmes des locaux ou zones partagés peut être accepté en fonction de la classe de risque à condition d’appliquer des procédures validées de nettoyage, décontamination et de désinfection des locaux ou zones, des équipements et des matériels utilisés.'),
('LD2.023', 'Les locaux ou zones dans lesquels des substances CMR sont stockées et utilisées sont toujours identifiés par une signalisation informative appropriée (pictogrammes avec précautions, risques, …). Le symbole international du danger biologique est placé sur la porte d’accès aux locaux dans lesquels sont manipulés des agents biologiques des groupes 2, 3 ou 4.'),
('LD2.024', 'L’organisation de l’espace doit tenir compte des substances manipulées ; il est important que les locaux permettent un contact audio/visuel entre les opérateurs pour faciliter la mise en oeuvre de mesures correctives rapides en cas d’incident.'),
('LD2.025', 'Le local de stockage des MPUP et articles de conditionnement permet de réduire le nombre de ces derniers dans le local de préparation et ainsi de faciliter le nettoyage et de limiter les risques de bris ou de confusion.'),
('LD2.026', 'Dans le cas où les substances sont dangereuses pour l’environnement, un système approprié d’évacuation de l’eau et des fluides liquides contaminés est mis en place selon la réglementation en vigueur.'),
('LD2.027', 'Le système de ventilation des locaux permet un renouvellement d’air suffisant pour limiter l’accumulation de produits toxiques et assurer un confinement adéquat.'),
('LD2.028', 'La conception des locaux permet d’éviter les contaminations croisées et la contamination de l’environnement. Une attention est portée sur l’extraction de l’air afin de limiter la contamination de l’environnement.'),
('LD2.029', 'Une zone de nettoyage du matériel et des équipements est spécialement affectée aux produits à risque.'),
('LD2.030', 'Selon les produits et la nature des opérations effectuées, les matériels et les dispositions mis en oeuvre sont adaptés aux risques encourus (risque de contaminations croisées, risque de biocontamination, risque de contact cytotoxique…). Le risque dépend également de la méthode de travail retenue.'),
('LD2.031', 'Les matériels de préparation réutilisables utilisés pour la réalisation de préparations contenant des produits à risque sont dédiés à cette activité. Ils sont identifiés et faciles à nettoyer pour limiter la contamination chimique et biologique.'),
('LD2.032', 'Des EPC adaptés aux substances manipulées sont installés dans les locaux ou zones.'),
('LD2.033', 'Pour les préparations pulvérulentes non stériles (comme la réalisation de gélules), l’utilisation d’enceintes ventilées aspirantes ou d’isolateurs (ou boîtes à gants) est adaptée. L’environnement immédiat à cet équipement peut être non classé.'),
('LD2.034', 'Les EPC contenant des filtres sont conçus pour que les filtres soient remplacés et que la maintenance soit assurée en limitant la contamination.'),
('LD2.035', 'Les filtres sont adaptés à la protection attendue (comme l’utilisation de filtres à charbon pour l’épuration des vapeurs, ou de filtres HEPA pour assurer une filtration mécanique des particules solides et des agents biologiques). Lors de l’utilisation des filtres une attention particulière est portée sur leur suivi et leur maintenance.'),
('LD2.036', 'Une comparaison de différents EPC pouvant être utilisés pour réduire le niveau d’exposition lors de la réalisation de préparations non stériles est décrite dans le tableau. 
Concernant les préparations non stériles :
Le choix des EPC fait l’objet d’une analyse de risque en fonction notamment des substances manipulées et du niveau d’exposition défini aux points 6 à 11. Pour éliminer les risques de contact, la séparation entre l’opérateur et les produits toxiques est à privilégier. Le poste de travail est choisi en fonction du risque et du niveau d’exposition. L’utilisation d’une enceinte ventilée aspirante ou d’un isolateur est adapté à la manipulation des substances liquides, volatiles ou sous forme de poudre pouvant présenter un risque.
Concernant les préparations stériles :
Le choix des EPC est également en accord avec les exigences de la LD 1 du présent guide. Pour éviter les contaminations croisées, il convient d’avoir plusieurs équipements en fonction du risque identifié. Les risques biologique et chimique font l’objet d’une analyse de risque spécifique afin d’adapter les modalités de confinement et d’éviter tout risque de dissémination pour l’environnement. L’EPC utilisé pour manipuler ces substances est adapté aux risques identifiés. Pour les substances chimiques, l''air traité provenant des postes à flux d’air unidirectionnel ou des isolateurs est rejeté à l''extérieur du bâtiment après passage dans un filtre HEPA.'),
('LD2.037', 'Pour réduire le niveau d''exposition aux substances à risque, des EPI adaptés sont utilisés. Leur temps d''utilisation doit être adapté et permettre de travailler dans des conditions na''eefctanat pas ni la santé de l''opérateur ni la qualité de la préparation'),
('LD2.038', 'L’utilisation des EPI est fonction de la protection souhaitée. L’utilisation de plusieurs EPI est souvent nécessaire.'),
('LD2.039', 'Si des substances CMR sont manipulées en dehors d’une enceinte ventilée de type isolateur ou boites à gants, l’utilisation d’une sur-blouse, de manchons pour avant-bras et de gants est obligatoire.'),
('LD2.040', 'La qualité des gants, seul contact direct entre le produit et l’opérateur, assure une protection maximale pour le risque de contact cutané. La fréquence de changement des gants est déterminée en fonction de l''analyse des risques. Lorsque le type de danger est « danger cutané », le choix du type de gants est obligatoirement adapté au produit manipulé, en fonction de leur épaisseur et de leur perméabilité.'),
('LD2.041', 'Lorsque le type de danger est « danger respiratoire », l’utilisation de masques adaptés est nécessaire (masque FFP2, FFP3, ou appareil respiratoire isolant).'),
('LD2.042', 'Lorsque le type de danger est « danger oculaire » (éclaboussure ou de contact oculaire), le port de lunettes de protection ou d’une protection faciale (type écran facial) est obligatoire.'),
('LD2.043', 'La méthode de préparation est maîtrisée et validée pour limiter les risques de contamination des locaux de préparation. Cette validation peut s’appuyer notamment sur des contrôles d’environnement adaptés.'),
('LD2.044', 'Les mouvements d’entrée et de sortie des MPUP, des articles de conditionnement, des produits, du matériel et du personnel se font sans remettre en cause l’efficacité du dispositif de protection.'),
('LD2.045', 'Une trousse d’urgence est disponible à proximité de la zone de préparation. Une douche oculaire ou un dispositif de rince-oeil est installé.'),
('LD2.046', 'L’intervalle de temps entre le début de la préparation et le conditionnement est le plus court possible.'),
('LD2.047', 'Le conditionnement externe assure la protection de la préparation dans son conditionnement primaire. Les caractéristiques du conditionnement externe sont déterminées en fonction des risques de détérioration du conditionnement primaire jusqu’à son utilisation et notamment en cas de bris ou de fuite.'),
('LD2.048', 'La fermeture de chaque conditionnement est contrôlée.'),
('LD2.049', 'La stratégie libératoire est la même que celle présentée dans le chapitre 6. Chaque lot de préparation fait l’objet d’une libération pharmaceutique sur la base des informations disponibles dans le dossier de lot.'),
('LD2.050', 'Les mêmes précautions que celles définies pour la réalisation de la préparation conduisent à l’établissement de procédures particulières concernant la protection du personnel, l’échantillonnage et les contrôles de MPUP, ainsi que les préparations terminées.'),
('LD2.051', 'Les préparations sont transportées dans des conditions ne présentant aucun risque pour les personnes et l’environnement et dans des conditions maintenant la qualité de la préparation (température, protection contre la lumière si nécessaire…). Le transport est effectué selon la réglementation en vigueur.'),
('LD2.052', 'L’élimination des déchets toxiques est conforme à la réglementation en vigueur.'),
('LD2.053', 'Tous les déchets contaminés par une substance CMR sont disposés dans des récipients spéciaux réservés à cet effet et étiquetés avant d’être éliminés par la filière adaptée.'),
('LD2.054', 'Des dispositions adaptées sont prises pour éliminer ou traiter les effluents en provenance des locaux de préparation selon la réglementation en vigueur. Pour la reconstitution des MTI et la mise sous forme appropriée des MTI-PP composés en tout ou partie d’OGM, les mesures de décontamination préconisées par le fabricant sont mises en place.'),
('LD2.055', 'Les tenues à usage unique sont recommandées compte tenu des difficultés de validation du nettoyage et de la décontamination chimique nécessaires à une utilisation multiple. Un dispositif fermé est prévu pour stocker les vêtements contaminés qui sont nettoyés s’ils ne sont pas à usage unique.'),
('LD2.056', 'La durée de stockage des déchets et leur volume sont limités dans le temps selon la réglementation en vigueur.'),
('LD2.057', 'En complément de la documentation décrite pour l’ensemble des préparations au chapitre 4, certaines procédures sont mises en oeuvre :
• Les mesures de protection et de sécurité ;
• La conduite à tenir en cas d’incident notamment en cas de bris ou de déversement accidentel en cours de préparation, de conditionnement, de transport et de délivrance ; les éléments devant être transmis au médecin du travail y sont décrits.
• La conduite à tenir en cas d’incident ou de défaillance d’un dispositif, d’un équipement etc. ;
• Le nettoyage des surfaces qui le cas échéant peut suivre les recommandations validées du fabricant ou du promoteur ;
• L''élimination des déchets ;
• La conduite à tenir en cas de réception d’emballages endommagés ;
• La destruction des produits ou substances ou préparations périmés et/ou non administrés.'),
('LD2.058', 'Les interventions du personnel extérieur au service, et notamment celles des services d’entretien et de maintenance, sont connues du pharmacien désigné comme responsable des préparations et enregistrées.'),
('LD3.01', 'Une évaluation de la faisabilité technique de la préparation (cf. points 1.13 et 1.16 des chapitres généraux des présentes bonnes pratiques) est un préalable à toute réalisation de ces préparations et repose en partie sur les informations mises à jour et transmises par le promoteur au pharmacien assurant la gérance de la PUI, conformément aux exigences réglementaires. Le pharmacien peut refuser une préparation selon les principes édictés au point 1.20 des chapitres généraux.'),
('LD3.02', 'Le promoteur veille à ce que les préparations soient réalisées conformément aux présentes bonnes pratiques et à l’ensemble des informations du dossier de préparation pharmaceutique (cf. glossaire) du médicament couvert par l’autorisation de RIPH.'),
('LD3.03', 'Le personnel appelé à collaborer à la réalisation des opérations mentionnées au paragraphe « Principes » ci-dessus est qualifié et reçoit une formation spécifique complémentaire si nécessaire.'),
('LD3.04', 'Le personnel est informé des dispositions particulières de toute RIPH tels que des éléments relatifs au protocole (mise en insu…).'),
('LD3.05', 'Les produits servant à la réalisation des préparations et les préparations rendues nécessaires par la RIPH sont stockés dans une zone identifiée et dédiée.'),
('LD3.06', 'Ce stockage doit permettre d’identifier clairement lesdits produits afin d’éviter tout risque de confusion. Il existe un emplacement spécifique pour chaque produit rangé par RIPH, par dosage et par conditionnement (si applicable).'),
('LD3.07', 'Dans le cas où le matériel est mis à disposition par le promoteur, la mise en service et la maintenance sont assurées par ce dernier.'),
('LD3.08', 'Le dossier de préparation pharmaceutique de la préparation comprend ou fait référence aux documents mentionnés aux points 4.30 à 4.35 des chapitres généraux des présentes bonnes pratiques ainsi qu’aux documents suivants :
• les procédures de mise en insu au moment du conditionnement le cas échéant ;
• les autorisations et les amendements de la recherche concernée ;
• les versions successives du protocole de la RIPH concernée ;
• les codes de randomisation, le cas échéant.'),
('LD3.09', 'Les spécifications des préparations terminées comportent, en fonction des cas, des éléments décrits au point 4.40 des chapitres généraux des présentes bonnes pratiques.'),
('LD3.10', 'Pour la PUI, les documents relatifs à chaque lot de préparations sont conservés 5 ans après la fin de la recherche y compris en cas d’arrêt anticipé de la dernière RIPH durant laquelle le lot a été utilisé, sans préjudice des obligations du promoteur concernant le dossier permanent de la RIPH.'),
('LD3.11', 'En cas de changement, à l’initiative ou avec l’accord du promoteur, pouvant impacter la préparation (par exemple : changement du fournisseur de MPUP ou du conditionnement primaire …), le pharmacien doit s’assurer que le promoteur lui a fourni les données disponibles (par exemple : stabilité, dissolution comparative, biodisponibilité…) prouvant que ces modifications n’altèrent pas de manière significative les caractéristiques initiales de qualité du médicament.'),
('LD3.12', 'La date de péremption indiquée sur le conditionnement d’origine peut ne plus être valable si le produit  a été reconditionné dans un conditionnement différent. Une date limite d’utilisation adéquate est alors définie et justifiée.'),
('LD3.13', 'Un soin particulier  est apporté à  la manipulation  des  préparations  durant et  après toute opération  de mise en insu. Lors de la mise en insu des préparations, des systèmes sont mis en place afin de garantir que cette procédure est assurée et maintenue, tout en permettant, si nécessaire, leur identification et l’identification de leurs numéros de lots initiaux avant l’opération de mise en insu.'),
('LD3.14', 'La libération des préparations mises en insu s’accompagne notamment d’une vérification de la similitude d’aspect et/ou de toute autre caractéristique requise des différentes préparations comparées.'),
('LD3.15', 'Il convient également de prévoir avec le promoteur un système d''identification rapide de la préparation en cas d''urgence nécessitant une levée de l''insu.'),
('LD3.16', 'Des procédures décrivent les modes d’obtention, de sécurisation, de diffusion, d’utilisation et de conservation de tout code de randomisation utilisé pour le conditionnement des préparations de médicaments expérimentaux ainsi que le système de levée de l’insu. Il convient de conserver les enregistrements correspondants.'),
('LD3.17', 'Les préparations sont conditionnées pour chaque personne qui se prête à la  RIPH.  Le nombre  d’unités à conditionner est spécifié avant le début des opérations de conditionnement. Il tient compte du nombre d’unités nécessaires à la réalisation des contrôles de la qualité et, si applicable, du nombre d’échantillons à conserver. Un bilan comparatif est établi pour s’assurer que les bonnes quantités d’unités ont été utilisées à chaque étape des opérations décrites précédemment.'),
('LD3.18', 'L’étiquetage des préparations rendues nécessaires par les RIPH répond aux textes en vigueur.'),
('LD3.19', 'Avant leur mise à disposition à l’investigateur du lieu de recherche, les préparations restent sous la responsabilité du promoteur tant que la procédure de  libération  du  lot  par  le  pharmacien  n’a  pas été effectuée (« feu vert technique »).'),
('LD3.20', 'Avant de délivrer les préparations réalisées, le pharmacien doit avoir été informé par le promoteur ou une personne dûment mandatée par lui que la RIPH est dûment autorisée. Cette information doit être formulée par écrit, y compris par tout moyen électronique (« feu vert réglementaire »).'),
('LD3.21', 'Ces étapes de libération sont consignées dans le dossier de lot de la préparation et la documentation correspondante est conservée dans les dossiers de la recherche par le promoteur.'),
('LD3.22', 'Toutefois, en cas d’opérations réalisées sous la surveillance du pharmacien de la PUI et portant uniquement sur le conditionnement ou l’étiquetage, il n’est pas nécessaire que le pharmacien responsable ou la personne qualifiée de l’établissement pharmaceutique qui a initialement libéré le lot, participe à la libération de chaque lot. Néanmoins après consultation du pharmacien responsable ou de la personne qualifiée de l’établissement pharmaceutique, le promoteur est tenu de veiller à ce que les opérations soient convenablement documentées et réalisées conformément aux bonnes pratiques en vigueur.'),
('LD3.23', 'Pour l’échantillothèque des préparations, des échantillons de chaque lot conditionné et de chaque période de la recherche sont conservés, y compris pour les produits mis en insu, pendant au moins deux ans après la fin notifiée de la RIPH par le promoteur dans laquelle le lot a été utilisé. Cela permet, le cas échéant, la confirmation de l’identité du produit dans le cadre  d’investigations  portant  sur  des résultats d’essais incohérents.'),
('LD3.24', 'Les opérations de réclamations, rappels, retours et destruction des préparations sont effectuées dans des conditions définies par le promoteur et spécifiées dans des procédures écrites.'),
('LD3.25', 'Des procédures visant à rappeler les préparations et à consigner ces opérations sont fixées par le promoteur en collaboration avec le pharmacien responsable des préparations. L’investigateur et la personne dûment mandatée par le promoteur ont connaissance de leurs obligations dans le cadre de cette procédure de rappel.'),
('LD3.26', 'Les médicaments expérimentaux non utilisés sont retournés et/ou détruits dans des conditions définies et spécifiées par le promoteur.'),
('LD3.27', 'La destruction des médicaments expérimentaux non utilisés est effectuée par lieu  de recherche  ou  par période de recherche après réconciliation entre les produits expédiés, les produits utilisés et ceux retournés et après que les écarts constatés entre les quantités  des produits  mentionnées  ci-dessus ont été étudiés et motivés de façon satisfaisante et qu’un bilan comparatif a été accepté par le promoteur. Les opérations de destruction sont enregistrées afin de pouvoir être comptabilisées. Il appartient au promoteur de conserver les dossiers afférents à ces opérations.'),
('LD3.28', 'Après la destruction des médicaments expérimentaux, un certificat daté ou une attestation confirmant  la réalisation de cette opération est remis au promoteur. Ces documents identifient clairement, ou permettent d’assurer la traçabilité des lots et/ou des numéros de traitement et/ou des numéros de personnes incluses dans la RIPH concernée, ainsi que les quantités effectivement détruites.')
ON CONFLICT (ref) DO UPDATE SET texte = EXCLUDED.texte;

-- Réponses : renommage vers les nouveaux codes (fusion : la réponse la plus récente l'emporte)
ALTER TABLE responses DROP CONSTRAINT IF EXISTS responses_question_id_fkey;
CREATE TEMP TABLE code_map (old TEXT PRIMARY KEY, new TEXT NOT NULL) ON COMMIT DROP;
INSERT INTO code_map (old, new) VALUES
('Q103', 'Q102'),
('Q103.01', 'Q102.01'),
('Q103.02', 'Q102.02'),
('Q103.03', 'Q102.03'),
('Q104', 'Q103'),
('Q105', 'Q104'),
('Q106', 'Q105'),
('Q107', 'Q106'),
('Q108', 'Q107'),
('Q108.01', 'Q107.01'),
('Q108.02', 'Q107.02'),
('Q109', 'Q108'),
('Q110', 'Q109'),
('Q111', 'Q110'),
('Q112', 'Q111'),
('Q112.01', 'Q111.01'),
('Q112.02', 'Q111.02'),
('Q112.03', 'Q111.03'),
('Q113', 'Q112'),
('Q114', 'Q113'),
('Q114.01', 'Q113.01'),
('Q114.02', 'Q113.02'),
('Q114.03', 'Q113.03'),
('Q115', 'Q114'),
('Q116', 'Q115'),
('Q117', 'Q116'),
('Q117.01', 'Q116.01'),
('Q117.02', 'Q116.02'),
('Q118', 'Q117'),
('Q119', 'Q118'),
('Q120', 'Q119'),
('Q121', 'Q120'),
('Q121.01', 'Q120.01'),
('Q121.02', 'Q120.02'),
('Q122', 'Q121'),
('Q122.01', 'Q121.01'),
('Q122.02', 'Q121.02'),
('Q122.03', 'Q121.03'),
('Q123', 'Q122'),
('Q124', 'Q123'),
('Q124.01', 'Q123.01'),
('Q124.02', 'Q123.02'),
('Q124.03', 'Q123.03'),
('Q124.04', 'Q123.04'),
('Q125', 'Q124'),
('Q126', 'Q125'),
('Q127', 'Q126'),
('Q128', 'Q127'),
('Q129', 'Q128'),
('Q130', 'Q129'),
('Q131', 'Q130'),
('Q131.01', 'Q130.01'),
('Q131.02', 'Q130.02'),
('Q132', 'Q131'),
('Q132.01', 'Q131.01'),
('Q132.02', 'Q131.02'),
('Q132.03', 'Q131.03'),
('Q132.04', 'Q131.04'),
('Q132.05', 'Q131.05'),
('Q132.06', 'Q131.06'),
('Q132.07', 'Q131.07'),
('Q132.08', 'Q131.08'),
('Q133', 'Q132'),
('Q134', 'Q133'),
('Q134.01', 'Q133.01'),
('Q134.02', 'Q133.02'),
('Q135', 'Q134'),
('Q136', 'Q135'),
('Q137', 'Q136'),
('Q138', 'Q137'),
('Q139', 'Q138'),
('Q140', 'Q139'),
('Q141', 'Q140'),
('Q142', 'Q141'),
('Q143', 'Q142'),
('Q144', 'Q143'),
('Q145', 'Q144'),
('Q146', 'Q145'),
('Q147', 'Q146'),
('Q148', 'Q147'),
('Q149', 'Q148'),
('Q150', 'Q149'),
('Q151', 'Q150'),
('Q152', 'Q151'),
('Q153', 'Q152'),
('Q154', 'Q153'),
('Q155', 'Q154'),
('Q156', 'Q155'),
('Q157', 'Q156'),
('Q157.01', 'Q156.01'),
('Q157.02', 'Q156.02'),
('Q157.03', 'Q156.03'),
('Q158', 'Q157'),
('Q159', 'Q158'),
('Q160', 'Q159'),
('Q161', 'Q160'),
('Q162', 'Q161'),
('Q163', 'Q162'),
('Q164', 'Q163'),
('Q165', 'Q164'),
('Q166', 'Q165'),
('Q167', 'Q166'),
('Q168', 'Q167'),
('Q168.01', 'Q167.01'),
('Q168.02', 'Q167.02'),
('Q168.03', 'Q167.03'),
('Q168.04', 'Q167.04'),
('Q168.05', 'Q167.05'),
('Q168.06', 'Q167.06'),
('Q169', 'Q168'),
('Q170', 'Q169'),
('Q171', 'Q170'),
('Q172', 'Q171'),
('Q173', 'Q172'),
('Q174', 'Q173'),
('Q175', 'Q174'),
('Q176', 'Q175'),
('Q176.01', 'Q175.01'),
('Q176.02', 'Q175.02'),
('Q176.03', 'Q175.03'),
('Q176.04', 'Q175.04'),
('Q176.05', 'Q175.05'),
('Q176.06', 'Q175.06'),
('Q177', 'Q176'),
('Q178', 'Q177'),
('Q179', 'Q178'),
('Q180', 'Q179'),
('Q181', 'Q180'),
('Q182', 'Q181'),
('Q183', 'Q182'),
('Q184', 'Q183'),
('Q185', 'Q184'),
('Q185.01', 'Q184.01'),
('Q185.02', 'Q184.02'),
('Q185.03', 'Q184.03'),
('Q185.04', 'Q184.04'),
('Q186', 'Q185'),
('Q187', 'Q186'),
('Q188', 'Q187'),
('Q189', 'Q188'),
('Q190', 'Q189'),
('Q191', 'Q190'),
('Q192', 'Q191'),
('Q192.01', 'Q191.01'),
('Q192.02', 'Q191.02'),
('Q192.03', 'Q191.03'),
('Q192.04', 'Q191.04'),
('Q192.05', 'Q191.05'),
('Q192.06', 'Q191.06'),
('Q192.07', 'Q191.07'),
('Q193', 'Q192'),
('Q193.01', 'Q192.01'),
('Q193.02', 'Q192.02'),
('Q193.03', 'Q192.03'),
('Q193.04', 'Q192.04'),
('Q193.05', 'Q192.05'),
('Q194', 'Q193'),
('Q195', 'Q194'),
('Q196', 'Q195'),
('Q197', 'Q196'),
('Q198', 'Q197'),
('Q198.01', 'Q197.01'),
('Q198.01.01', 'Q197.01.01'),
('Q198.01.02', 'Q197.01.02'),
('Q198.01.03', 'Q197.01.03'),
('Q198.01.04', 'Q197.01.04'),
('Q198.01.05', 'Q197.01.05'),
('Q198.01.06', 'Q197.01.06'),
('Q198.01.07', 'Q197.01.07'),
('Q198.01.08', 'Q197.01.08'),
('Q198.01.09', 'Q197.01.09'),
('Q198.01.10', 'Q197.01.10'),
('Q198.01.11', 'Q197.01.11'),
('Q198.01.12', 'Q197.01.12'),
('Q198.01.13', 'Q197.01.13'),
('Q198.01.14', 'Q197.01.14'),
('Q198.02', 'Q197.02'),
('Q198.02.01', 'Q197.02.01'),
('Q198.02.02', 'Q197.02.02'),
('Q198.02.03', 'Q197.02.03'),
('Q198.02.04', 'Q197.02.04'),
('Q198.02.05', 'Q197.02.05'),
('Q198.03', 'Q197.03'),
('Q198.03.01', 'Q197.03.01'),
('Q198.03.02', 'Q197.03.02'),
('Q198.03.03', 'Q197.03.03'),
('Q198.03.04', 'Q197.03.04'),
('Q198.03.05', 'Q197.03.05'),
('Q198.03.06', 'Q197.03.06'),
('Q198.03.07', 'Q197.03.07'),
('Q198.04', 'Q197.04'),
('Q198.04.01', 'Q197.04.01'),
('Q198.04.02', 'Q197.04.02'),
('Q198.04.03', 'Q197.04.03'),
('Q198.04.04', 'Q197.04.04'),
('Q198.04.05', 'Q197.04.05'),
('Q199', 'Q198'),
('Q200', 'Q199'),
('Q201', 'Q200'),
('Q201.01', 'Q200.01');
INSERT INTO code_map (old, new) VALUES
('Q201.02', 'Q200.02'),
('Q201.03', 'Q200.03'),
('Q201.04', 'Q200.04'),
('Q201.05', 'Q200.05'),
('Q201.06', 'Q200.06'),
('Q201.07', 'Q200.07'),
('Q201.08', 'Q200.08'),
('Q201.09', 'Q200.09'),
('Q201.10', 'Q200.10'),
('Q202', 'Q201'),
('Q203', 'Q202'),
('Q204', 'Q203'),
('Q205', 'Q204'),
('Q206', 'Q205'),
('Q207', 'Q206'),
('Q208', 'Q207'),
('Q209', 'Q208'),
('Q210', 'Q209'),
('Q211', 'Q210'),
('Q212', 'Q211'),
('Q213', 'Q212'),
('Q214', 'Q213'),
('Q215-A', 'Q214-A'),
('Q215', 'Q214'),
('Q216', 'Q215'),
('Q217', 'Q216'),
('Q218', 'Q217'),
('Q219', 'Q218'),
('Q220', 'Q219'),
('Q221', 'Q220'),
('Q222', 'Q221'),
('Q223', 'Q222'),
('Q224', 'Q223'),
('Q225', 'Q224'),
('Q225.01', 'Q224.01'),
('Q225.02', 'Q224.02'),
('Q225.03', 'Q224.03'),
('Q226', 'Q225'),
('Q227', 'Q226'),
('Q227.01', 'Q226.01'),
('Q227.02', 'Q226.02'),
('Q227.03', 'Q226.03'),
('Q228', 'Q227'),
('Q229', 'Q228'),
('Q230', 'Q229'),
('Q231', 'Q230'),
('Q232', 'Q231'),
('Q233', 'Q232'),
('Q233.01', 'Q232.01'),
('Q233.02', 'Q232.02'),
('Q233.03', 'Q232.03'),
('Q234', 'Q233'),
('Q235', 'Q234'),
('Q235.01', 'Q234.01'),
('Q235.02', 'Q234.02'),
('Q235.03', 'Q234.03'),
('Q236', 'Q235'),
('Q237', 'Q236'),
('Q238', 'Q237'),
('Q238.01', 'Q237.01'),
('Q238.02', 'Q237.02'),
('Q238.03', 'Q237.03'),
('Q239', 'Q238'),
('Q240', 'Q239'),
('Q241', 'Q240'),
('Q242', 'Q241'),
('Q243', 'Q242'),
('Q244', 'Q243'),
('Q245', 'Q244'),
('Q246', 'Q245'),
('Q246.01', 'Q245.01'),
('Q246.01.01', 'Q245.01.01'),
('Q246.01.02', 'Q245.01.02'),
('Q246.01.03', 'Q245.01.03'),
('Q246.01.04', 'Q245.01.04'),
('Q246.01.05', 'Q245.01.05'),
('Q246.01.06', 'Q245.01.06'),
('Q246.01.07', 'Q245.01.07'),
('Q246.01.08', 'Q245.01.08'),
('Q246.01.09', 'Q245.01.09'),
('Q246.01.10', 'Q245.01.10'),
('Q246.02', 'Q245.02'),
('Q246.02.01', 'Q245.02.01'),
('Q246.02.02', 'Q245.02.02'),
('Q246.02.03', 'Q245.02.03'),
('Q246.02.04', 'Q245.02.04'),
('Q246.02.05', 'Q245.02.05'),
('Q246.03', 'Q245.03'),
('Q246.03.01', 'Q245.03.01'),
('Q246.03.02', 'Q245.03.02'),
('Q246.03.03', 'Q245.03.03'),
('Q247', 'Q246'),
('Q248', 'Q247'),
('Q249', 'Q248'),
('Q250', 'Q249'),
('Q251', 'Q250'),
('Q252', 'Q251'),
('Q253', 'Q252'),
('Q254', 'Q253'),
('Q254.01', 'Q253.01'),
('Q254.02', 'Q253.02'),
('Q254.03', 'Q253.03'),
('Q254.04', 'Q253.04'),
('Q254.05', 'Q253.05'),
('Q254.06', 'Q253.06'),
('Q254.07', 'Q253.07'),
('Q254.08', 'Q253.08'),
('Q254.09', 'Q253.09'),
('Q254.10', 'Q253.10'),
('Q255', 'Q254'),
('Q256', 'Q255'),
('Q257', 'Q256'),
('Q258', 'Q257'),
('Q259', 'Q258'),
('Q260', 'Q259'),
('Q260.01', 'Q259.01'),
('Q260.02', 'Q259.02'),
('Q260.03', 'Q259.03'),
('Q260.04', 'Q259.04'),
('Q260.05', 'Q259.05'),
('Q261', 'Q260'),
('Q261.01', 'Q260.01'),
('Q261.02', 'Q260.02'),
('Q261.03', 'Q260.03'),
('Q261.04', 'Q260.04'),
('Q261.05', 'Q260.05'),
('Q261.06', 'Q260.06'),
('Q262', 'Q261'),
('Q263', 'Q262'),
('Q264', 'Q263'),
('Q265', 'Q264'),
('Q266', 'Q265'),
('Q267', 'Q266'),
('Q268', 'Q267'),
('Q268.01', 'Q267.01'),
('Q268.02', 'Q267.02'),
('Q268.03', 'Q267.03'),
('Q268.04', 'Q267.04'),
('Q268.05', 'Q267.05'),
('Q268.06', 'Q267.06'),
('Q268.07', 'Q267.07'),
('Q268.08', 'Q267.08'),
('Q269', 'Q268'),
('Q270', 'Q269'),
('Q270.01', 'Q269.01'),
('Q270.02', 'Q269.02'),
('Q270.03', 'Q269.03'),
('Q270.04', 'Q269.04'),
('Q271', 'Q270'),
('Q271.01', 'Q270.01'),
('Q271.02', 'Q270.02'),
('Q271.03', 'Q270.03'),
('Q272', 'Q271'),
('Q272.01', 'Q271.01'),
('Q272.02', 'Q271.02'),
('Q272.03', 'Q271.03'),
('Q272.04', 'Q271.04'),
('Q272.05', 'Q271.05'),
('Q272.06', 'Q271.06'),
('Q273', 'Q272'),
('Q274', 'Q273'),
('Q275', 'Q274'),
('Q276', 'Q275'),
('Q276.01', 'Q275.01'),
('Q276.02', 'Q275.02'),
('Q277', 'Q276'),
('Q278', 'Q277'),
('Q279', 'Q278'),
('Q280', 'Q279'),
('Q281', 'Q280'),
('Q282', 'Q281'),
('Q283', 'Q282'),
('Q284', 'Q283'),
('Q285', 'Q284'),
('Q286', 'Q285'),
('Q287', 'Q286'),
('Q288', 'Q287'),
('Q289', 'Q288'),
('Q290', 'Q289'),
('Q291', 'Q290'),
('Q292', 'Q291'),
('Q293', 'Q292'),
('Q294', 'Q293'),
('Q295', 'Q294'),
('Q296', 'Q295'),
('Q297', 'Q296'),
('Q297.01', 'Q296.01'),
('Q297.02', 'Q296.02'),
('Q297.03', 'Q296.03'),
('Q297.04', 'Q296.04'),
('Q298', 'Q297'),
('Q298.01', 'Q297.01'),
('Q298.02', 'Q297.02'),
('Q298.03', 'Q297.03'),
('Q299', 'Q298'),
('Q300', 'Q299'),
('Q301', 'Q300'),
('Q302', 'Q301'),
('Q302.01', 'Q301.01'),
('Q302.02', 'Q301.02');
INSERT INTO code_map (old, new) VALUES
('Q302.03', 'Q301.03'),
('Q303', 'Q302'),
('Q304', 'Q303'),
('Q305', 'Q304'),
('Q306', 'Q305'),
('Q307', 'Q306'),
('Q308', 'Q307'),
('Q309', 'Q308'),
('Q310', 'Q309'),
('Q311', 'Q310'),
('Q312', 'Q311'),
('Q312.01', 'Q311.01'),
('Q312.02', 'Q311.02'),
('Q312.03', 'Q311.03'),
('Q313', 'Q312'),
('Q314', 'Q313'),
('Q315', 'Q314'),
('Q316', 'Q315'),
('Q317', 'Q316'),
('Q318', 'Q317'),
('Q319', 'Q318'),
('Q320', 'Q319'),
('Q321', 'Q320'),
('Q322', 'Q321'),
('Q323', 'Q322'),
('Q324', 'Q323'),
('Q325', 'Q324'),
('Q326', 'Q325'),
('Q327', 'Q326'),
('Q328', 'Q327'),
('Q329', 'Q328'),
('Q329.01', 'Q328.01'),
('Q329.02', 'Q328.02'),
('Q329.03', 'Q328.03'),
('Q329.04', 'Q328.04'),
('Q330', 'Q329'),
('Q331', 'Q330'),
('Q332', 'Q331'),
('Q333', 'Q332'),
('Q334', 'Q333'),
('Q335', 'Q334'),
('Q336', 'Q335'),
('Q337', 'Q336'),
('Q338', 'Q337'),
('Q339', 'Q338'),
('Q340', 'Q339'),
('Q341', 'Q340'),
('Q342', 'Q341'),
('Q343', 'Q342'),
('Q344', 'Q343'),
('Q345', 'Q344'),
('Q346', 'Q345'),
('Q347', 'Q346'),
('Q348', 'Q347'),
('Q349', 'Q348'),
('Q350', 'Q349'),
('Q351', 'Q350'),
('Q352', 'Q351'),
('Q353', 'Q352'),
('Q354', 'Q353'),
('Q355', 'Q354'),
('Q356', 'Q355'),
('Q357', 'Q356'),
('Q358', 'Q357'),
('Q359', 'Q358'),
('Q359.01', 'Q358.01'),
('Q359.02', 'Q358.02'),
('Q359.03', 'Q358.03'),
('Q359.04', 'Q358.04'),
('Q359.05', 'Q358.05'),
('Q359.06', 'Q358.06'),
('Q360', 'Q359'),
('Q361', 'Q360'),
('Q362', 'Q361'),
('Q363', 'Q362'),
('Q364', 'Q363'),
('Q365', 'Q364'),
('Q366', 'Q365'),
('Q367', 'Q366'),
('Q368', 'Q367'),
('Q369', 'Q368'),
('Q370', 'Q369'),
('Q371', 'Q370'),
('Q372', 'Q371'),
('Q373', 'Q372'),
('Q374', 'Q373'),
('Q375', 'Q374'),
('Q376', 'Q375'),
('Q377', 'Q376'),
('Q378', 'Q377'),
('Q379', 'Q378'),
('Q380', 'Q379'),
('Q381', 'Q380'),
('Q382', 'Q381'),
('Q383', 'Q382'),
('Q384', 'Q383'),
('Q385', 'Q384'),
('Q386', 'Q385'),
('Q387', 'Q386'),
('Q388', 'Q387'),
('Q389', 'Q388'),
('Q390', 'Q389'),
('Q391', 'Q390'),
('Q392', 'Q391'),
('Q393', 'Q392'),
('Q394', 'Q393'),
('Q395', 'Q394'),
('Q396', 'Q395'),
('Q397', 'Q396'),
('Q398', 'Q397'),
('Q399', 'Q398'),
('Q400', 'Q399'),
('Q401', 'Q400'),
('Q402', 'Q401'),
('Q403', 'Q402'),
('Q404', 'Q403'),
('Q405', 'Q404'),
('Q406', 'Q405'),
('Q406.01', 'Q405.01'),
('Q406.02', 'Q405.02'),
('Q406.03', 'Q405.03'),
('Q406.04', 'Q405.04'),
('Q407', 'Q406'),
('Q408', 'Q407'),
('Q408.01', 'Q407.01'),
('Q408.02', 'Q407.02'),
('Q408.03', 'Q407.03'),
('Q409', 'Q408'),
('Q410', 'Q409'),
('Q411', 'Q410'),
('Q412', 'Q411'),
('Q413', 'Q412'),
('Q414', 'Q413'),
('Q415', 'Q414'),
('Q416', 'Q415'),
('Q417', 'Q416'),
('Q418', 'Q417'),
('Q419', 'Q418'),
('Q420', 'Q419'),
('Q421', 'Q420'),
('Q422', 'Q421'),
('Q423', 'Q422'),
('Q424', 'Q423'),
('Q425', 'Q424'),
('Q426', 'Q425'),
('Q427', 'Q426'),
('Q428', 'Q427'),
('Q429', 'Q428'),
('Q430', 'Q429'),
('Q431', 'Q430'),
('Q432', 'Q431'),
('Q433', 'Q432'),
('Q434', 'Q433'),
('Q435', 'Q434'),
('Q436', 'Q435'),
('Q437', 'Q436'),
('Q438', 'Q437'),
('Q439', 'Q438'),
('Q440', 'Q439'),
('Q441', 'Q440'),
('Q442', 'Q441'),
('Q443', 'Q442'),
('Q444', 'Q443'),
('Q445', 'Q444'),
('Q445.01', 'Q444.01'),
('Q445.02', 'Q444.02'),
('Q445.03', 'Q444.03'),
('Q445.04', 'Q444.04'),
('Q445.05', 'Q444.05'),
('Q446', 'Q445'),
('Q447', 'Q446'),
('Q448', 'Q447'),
('Q449', 'Q448'),
('Q450', 'Q449'),
('Q451', 'Q450'),
('Q452', 'Q451'),
('Q453', 'Q452'),
('Q454', 'Q453'),
('Q455', 'Q454'),
('Q456', 'Q455'),
('Q457', 'Q456'),
('Q458', 'Q457'),
('Q459', 'Q458'),
('Q460', 'Q459'),
('Q461', 'Q460'),
('Q461.01', 'Q460.01'),
('Q461.02', 'Q460.02'),
('Q461.03', 'Q460.03'),
('Q462', 'Q461'),
('Q463', 'Q462'),
('Q463.01', 'Q462.01'),
('Q463.02', 'Q462.02'),
('Q463.03', 'Q462.03'),
('Q463.04', 'Q462.04'),
('Q463.05', 'Q462.05'),
('Q463.06', 'Q462.06'),
('Q463.06.01', 'Q462.06.01'),
('Q463.06.02', 'Q462.06.02'),
('Q463.06.03', 'Q462.06.03'),
('Q463.06.04', 'Q462.06.04');
INSERT INTO code_map (old, new) VALUES
('Q463.06.05', 'Q462.06.05'),
('Q463.07', 'Q462.07'),
('Q463.08', 'Q462.08'),
('Q463.09', 'Q462.09'),
('Q464', 'Q463'),
('Q465', 'Q464'),
('Q466', 'Q465'),
('Q467', 'Q466'),
('Q468', 'Q467'),
('Q469', 'Q468'),
('Q470', 'Q469'),
('Q471', 'Q470'),
('Q472', 'Q471'),
('Q473', 'Q472'),
('Q474', 'Q473'),
('Q475', 'Q474'),
('Q476', 'Q475'),
('Q477', 'Q476'),
('Q478', 'Q477'),
('Q479', 'Q478'),
('Q480', 'Q479'),
('Q481', 'Q480'),
('Q482', 'Q481'),
('Q483', 'Q482'),
('Q484', 'Q483'),
('Q485', 'Q484'),
('Q486', 'Q485'),
('Q487', 'Q486'),
('Q488', 'Q487'),
('Q489', 'Q488'),
('Q490', 'Q489'),
('Q491', 'Q490'),
('Q492', 'Q491'),
('Q492.01', 'Q491.01'),
('Q492.02', 'Q491.02'),
('Q492.03', 'Q491.03'),
('Q492.04', 'Q491.04'),
('Q493', 'Q492'),
('Q493.01', 'Q492.01'),
('Q493.02', 'Q492.02'),
('Q493.03', 'Q492.03'),
('Q494', 'Q493'),
('Q494.01', 'Q493.01'),
('Q494.02', 'Q493.02'),
('Q494.03', 'Q493.03'),
('Q494.04', 'Q493.04'),
('Q494.05', 'Q493.05'),
('Q495', 'Q494'),
('Q496', 'Q495'),
('Q497', 'Q496'),
('Q498', 'Q497'),
('Q498.01', 'Q497.01'),
('Q498.02', 'Q497.02'),
('Q498.03', 'Q497.03'),
('Q498.04', 'Q497.04'),
('Q498.05', 'Q497.05'),
('Q498.06', 'Q497.06'),
('Q498.07', 'Q497.07'),
('Q499', 'Q498'),
('Q500', 'Q499'),
('Q501', 'Q500'),
('Q502', 'Q501'),
('Q503', 'Q502'),
('Q504', 'Q503'),
('Q505', 'Q504'),
('Q506', 'Q505'),
('Q507', 'Q506'),
('Q508', 'Q507'),
('Q509', 'Q508'),
('Q510', 'Q509'),
('Q511', 'Q510'),
('Q512', 'Q511'),
('Q513', 'Q512'),
('Q514', 'Q513'),
('Q514.01', 'Q513.01'),
('Q514.02', 'Q513.02'),
('Q514.03', 'Q513.03'),
('Q514.04', 'Q513.04'),
('Q514.05', 'Q513.05'),
('Q515', 'Q514'),
('Q516', 'Q515'),
('Q517', 'Q516'),
('Q518', 'Q517'),
('Q519', 'Q518'),
('Q520', 'Q519'),
('Q521', 'Q520'),
('Q522', 'Q521'),
('Q523', 'Q522'),
('Q524', 'Q523'),
('Q525', 'Q524'),
('Q526', 'Q525'),
('Q527', 'Q526'),
('Q528', 'Q527'),
('Q529', 'Q528'),
('Q530', 'Q529'),
('Q530.01', 'Q529.01'),
('Q530.02', 'Q529.02'),
('Q530.03', 'Q529.03'),
('Q530.04', 'Q529.04'),
('Q531', 'Q530'),
('Q532', 'Q531'),
('Q533', 'Q532'),
('Q534', 'Q533'),
('Q535', 'Q534'),
('Q536', 'Q535'),
('Q537', 'Q536'),
('Q538', 'Q537'),
('Q538.01', 'Q537.01'),
('Q538.02', 'Q537.02'),
('Q538.03', 'Q537.03'),
('Q538.04', 'Q537.04'),
('Q539', 'Q538'),
('Q540', 'Q539'),
('Q541', 'Q540'),
('Q542', 'Q541'),
('Q543', 'Q542'),
('Q544', 'Q543'),
('Q545', 'Q544'),
('Q546', 'Q545'),
('Q547', 'Q546'),
('Q547.01', 'Q546.01'),
('Q547.02', 'Q546.02'),
('Q547.03', 'Q546.03'),
('Q547.04', 'Q546.04'),
('Q548', 'Q547'),
('Q548.01', 'Q547.01'),
('Q548.02', 'Q547.02'),
('Q548.03', 'Q547.03'),
('Q548.04', 'Q547.04'),
('Q548.05', 'Q547.05'),
('Q548.06', 'Q547.06'),
('Q548.07', 'Q547.07'),
('Q549', 'Q548'),
('Q549-01', 'Q548.01'),
('Q549-02', 'Q548.02'),
('Q549-03', 'Q548.03'),
('Q549-04', 'Q548.04'),
('Q549-05', 'Q548.05'),
('Q549-06', 'Q548.06'),
('Q549-07', 'Q548.07'),
('Q550', 'Q549'),
('Q550.01', 'Q549.01'),
('Q550.02', 'Q549.02'),
('Q550.02.01', 'Q549.02.01'),
('Q550.02.02', 'Q549.02.02'),
('Q550.02.03', 'Q549.02.03'),
('Q550.02.04', 'Q549.02.04'),
('Q550.02.05', 'Q549.02.05'),
('Q550.03', 'Q549.03'),
('Q550.03.01', 'Q549.03.01'),
('Q550.03.02', 'Q549.03.02'),
('Q550.03.03', 'Q549.03.03'),
('Q550.04', 'Q549.04'),
('Q550.05', 'Q549.05'),
('Q551', 'Q550'),
('Q551.01', 'Q550.01'),
('Q551.02', 'Q550.02'),
('Q551.03', 'Q550.03'),
('Q551.04', 'Q550.04'),
('Q551.05', 'Q550.05'),
('Q551.06', 'Q550.06'),
('Q551.07', 'Q550.07'),
('Q551.08', 'Q550.08'),
('Q552', 'Q551'),
('Q553', 'Q552'),
('Q554', 'Q553'),
('Q555', 'Q554'),
('Q556', 'Q555'),
('Q557', 'Q556'),
('Q558', 'Q557'),
('Q558.01', 'Q557.01'),
('Q558.02', 'Q557.02'),
('Q558.03', 'Q557.03'),
('Q558.04', 'Q557.04'),
('Q558.05', 'Q557.05'),
('Q559', 'Q558'),
('Q560', 'Q559'),
('Q561', 'Q560'),
('Q561.01', 'Q560.01'),
('Q561.02', 'Q560.02'),
('Q561.02.01', 'Q560.02.01'),
('Q561.02.02', 'Q560.02.02'),
('Q561.02.03', 'Q560.02.03'),
('Q561.02.04', 'Q560.02.04'),
('Q561.03', 'Q560.03'),
('Q561.04', 'Q560.04'),
('Q561.05', 'Q560.05'),
('Q561.06', 'Q560.06'),
('Q561.06.01', 'Q560.06.01'),
('Q561.06.02', 'Q560.06.02'),
('Q561.07', 'Q560.07'),
('Q561.08', 'Q560.08'),
('Q561.09', 'Q560.09'),
('Q561.09.01', 'Q560.09.01'),
('Q561.09.02', 'Q560.09.02'),
('Q562', 'Q561'),
('Q563', 'Q562'),
('Q564', 'Q563'),
('Q565', 'Q564'),
('Q566', 'Q565');
INSERT INTO code_map (old, new) VALUES
('Q567', 'Q566'),
('Q568', 'Q567'),
('Q569', 'Q568'),
('Q570', 'Q569'),
('Q571', 'Q570'),
('Q572', 'Q571'),
('Q573', 'Q572'),
('Q574', 'Q573'),
('Q575', 'Q574'),
('Q576', 'Q575'),
('Q577', 'Q576'),
('Q578', 'Q577'),
('Q579', 'Q578'),
('Q580', 'Q579'),
('Q581', 'Q580'),
('Q581.01', 'Q580.01'),
('Q581.01.01', 'Q580.01.01'),
('Q581.01.02', 'Q580.01.02'),
('Q581.02', 'Q580.02'),
('Q581.02.01', 'Q580.02.01'),
('Q581.02.02', 'Q580.02.02'),
('Q581.03', 'Q580.03'),
('Q581.03.01', 'Q580.03.01'),
('Q581.03.02', 'Q580.03.02'),
('Q581.04', 'Q580.04'),
('Q581.04.01', 'Q580.04.01'),
('Q581.04.02', 'Q580.04.02'),
('Q582', 'Q581'),
('Q583', 'Q582'),
('Q584', 'Q583'),
('Q585', 'Q584'),
('Q585.01', 'Q584.01'),
('Q585.02', 'Q584.02'),
('Q586', 'Q585'),
('Q587', 'Q586'),
('Q588', 'Q587'),
('Q589', 'Q588'),
('Q590', 'Q589'),
('Q591', 'Q590'),
('Q592', 'Q591'),
('Q593', 'Q592'),
('Q593.01', 'Q592.01'),
('Q593.02', 'Q592.02'),
('Q593.03', 'Q592.03'),
('Q593.04', 'Q592.04'),
('Q594', 'Q593'),
('Q595', 'Q594'),
('Q596', 'Q595'),
('Q597', 'Q596'),
('Q597.01', 'Q596.01'),
('Q597.02', 'Q596.02'),
('Q597.03', 'Q596.03'),
('Q597.04', 'Q596.04'),
('Q598', 'Q597'),
('Q599', 'Q598'),
('Q599.01', 'Q598.01'),
('Q599.02', 'Q598.02'),
('Q599.03', 'Q598.03'),
('Q599.04', 'Q598.04'),
('Q599.05', 'Q598.05'),
('Q599.06', 'Q598.06'),
('Q599.07', 'Q598.07'),
('Q600', 'Q599'),
('Q601', 'Q600'),
('Q602', 'Q601'),
('Q603', 'Q602'),
('Q604', 'Q603'),
('Q605', 'Q604'),
('Q606', 'Q605'),
('Q607', 'Q606'),
('Q607.01', 'Q606.01'),
('Q607.02', 'Q606.02'),
('Q607.03', 'Q606.03'),
('Q608', 'Q607'),
('Q608.01', 'Q607.01'),
('Q608.02', 'Q607.02'),
('Q608.03', 'Q607.03'),
('Q608.04', 'Q607.04'),
('Q608.05', 'Q607.05'),
('Q608.06', 'Q607.06'),
('Q608.07', 'Q607.07'),
('Q608.08', 'Q607.08'),
('Q608.09', 'Q607.09'),
('Q609', 'Q608'),
('Q610', 'Q609'),
('Q610.01', 'Q609.01'),
('Q610.02', 'Q609.02'),
('Q611', 'Q610'),
('Q612', 'Q611'),
('Q613', 'Q612'),
('Q613.01', 'Q612.01'),
('Q613.02', 'Q612.02'),
('Q614', 'Q613'),
('Q615', 'Q614'),
('Q615.01', 'Q614.01'),
('Q615.02', 'Q614.02'),
('Q615.03', 'Q614.03'),
('Q615.04', 'Q614.04'),
('Q615.05', 'Q614.05'),
('Q615.06', 'Q614.06'),
('Q615.07', 'Q614.07'),
('Q616', 'Q615'),
('Q617', 'Q616'),
('Q617.01', 'Q616.01'),
('Q617.02', 'Q616.02'),
('Q617.03', 'Q616.03'),
('Q617.04', 'Q616.04'),
('Q617.05', 'Q616.05'),
('Q617.06', 'Q616.06'),
('Q618', 'Q617'),
('Q619', 'Q618'),
('Q620', 'Q619'),
('Q620.01', 'Q619.01'),
('Q620.02', 'Q619.02'),
('Q620.03', 'Q619.03'),
('Q620.04', 'Q619.04'),
('Q621', 'Q620'),
('Q621.01', 'Q620.01'),
('Q621.02', 'Q620.02'),
('Q621.03', 'Q620.03'),
('Q621.04', 'Q620.04'),
('Q622', 'Q621'),
('Q623', 'Q622'),
('Q623.01', 'Q622.01'),
('Q623.02', 'Q622.02'),
('Q623.03', 'Q622.03'),
('Q623.04', 'Q622.04'),
('Q624', 'Q623'),
('Q624.01', 'Q623.01'),
('Q624.02', 'Q623.02'),
('Q624.03', 'Q623.03'),
('Q624.04', 'Q623.04'),
('Q624.05', 'Q623.04.01'),
('Q624.06', 'Q623.04.02'),
('Q625', 'Q624'),
('Q626', 'Q625'),
('Q627', 'Q626'),
('Q628', 'Q627'),
('Q629', 'Q628'),
('Q630', 'Q629'),
('Q631', 'Q630'),
('Q632', 'Q631'),
('Q633', 'Q632'),
('Q634', 'Q633'),
('Q635', 'Q634'),
('Q636', 'Q635'),
('Q637', 'Q636'),
('Q638', 'Q637'),
('Q639', 'Q638'),
('Q639.01', 'Q638.01'),
('Q639.02', 'Q638.02'),
('Q639.03', 'Q638.03'),
('Q640', 'Q639'),
('Q641', 'Q640'),
('Q642', 'Q640'),
('Q642.01', 'Q640.01'),
('Q642.02', 'Q640.02'),
('Q642.03', 'Q640.03'),
('Q642.04', 'Q640.04'),
('Q642.05', 'Q640.05'),
('Q642.06', 'Q640.06'),
('Q643', 'Q641'),
('Q644', 'Q642'),
('Q645', 'Q643'),
('Q646', 'Q644'),
('Q647', 'Q645'),
('Q648', 'Q646'),
('Q649', 'Q647'),
('Q650', 'Q648'),
('Q651', 'Q649'),
('Q652', 'Q650'),
('Q653', 'Q651'),
('Q654', 'Q652'),
('Q655', 'Q653'),
('Q656', 'Q654'),
('Q657', 'Q655'),
('Q658', 'Q656'),
('Q659', 'Q657'),
('Q660', 'Q658'),
('Q661', 'Q659'),
('Q661.01', 'Q659.01'),
('Q661.02', 'Q659.02'),
('Q661.03', 'Q659.03'),
('Q661.04', 'Q659.04'),
('Q662', 'Q660'),
('Q662.01', 'Q660.01'),
('Q662.02', 'Q660.02'),
('Q663', 'Q661'),
('Q664', 'Q662'),
('Q665', 'Q663'),
('Q666', 'Q664'),
('Q666.01', 'Q664.01'),
('Q666.02', 'Q664.02'),
('Q666.03', 'Q664.03'),
('Q667', 'Q665'),
('Q668', 'Q666'),
('Q669', 'Q667'),
('Q670', 'Q668'),
('Q671', 'Q669'),
('Q672', 'Q670');
INSERT INTO code_map (old, new) VALUES
('Q673', 'Q671'),
('Q674', 'Q672'),
('Q675', 'Q673'),
('Q676', 'Q674'),
('Q677', 'Q675'),
('Q678', 'Q676'),
('Q679', 'Q677'),
('Q680', 'Q678'),
('Q681', 'Q679'),
('Q682', 'Q680'),
('Q683', 'Q681'),
('Q684', 'Q682'),
('Q685', 'Q683'),
('Q686', 'Q684'),
('Q687', 'Q685'),
('Q688', 'Q686'),
('Q689', 'Q687'),
('Q690', 'Q688'),
('Q691', 'Q689'),
('Q692', 'Q690'),
('Q693', 'Q691'),
('Q694', 'Q692'),
('Q695', 'Q693'),
('Q696', 'Q694'),
('Q697', 'Q695'),
('Q698', 'Q696'),
('Q699', 'Q697'),
('Q700', 'Q698'),
('Q701', 'Q699'),
('Q702', 'Q700'),
('Q703', 'Q701'),
('Q704', 'Q702'),
('Q705', 'Q703'),
('Q706', 'Q704'),
('Q707', 'Q705'),
('Q708', 'Q706'),
('Q709', 'Q707'),
('Q710', 'Q708'),
('Q711', 'Q709'),
('Q712', 'Q710'),
('Q713', 'Q711'),
('Q714', 'Q712'),
('Q715', 'Q713'),
('Q716', 'Q714'),
('Q717', 'Q715'),
('Q718', 'Q716'),
('Q719', 'Q717'),
('Q720', 'Q718'),
('Q721', 'Q719'),
('Q722', 'Q720'),
('Q723', 'Q721'),
('Q724', 'Q722'),
('Q725', 'Q723'),
('Q725.01', 'Q723.01'),
('Q725.02', 'Q723.02'),
('Q725.03', 'Q723.03'),
('Q725.04', 'Q723.04'),
('Q726', 'Q724'),
('Q727', 'Q725'),
('Q728', 'Q726'),
('Q729', 'Q727'),
('Q730', 'Q728'),
('Q731', 'Q729'),
('Q732', 'Q730'),
('Q733', 'Q731'),
('Q734', 'Q732'),
('Q734.01', 'Q732.01'),
('Q734.02', 'Q732.02'),
('Q734.03', 'Q732.03'),
('Q735', 'Q733'),
('Q736', 'Q734'),
('Q737', 'Q735'),
('Q738', 'Q736'),
('Q738.01', 'Q736.01'),
('Q738.02', 'Q736.02'),
('Q739', 'Q737'),
('Q740', 'Q738'),
('Q741', 'Q739'),
('Q742', 'Q740'),
('Q743', 'Q741'),
('Q744', 'Q742'),
('Q745', 'Q743'),
('Q745.01', 'Q743.01'),
('Q745.02', 'Q743.02'),
('Q745.03', 'Q743.03'),
('Q745.04', 'Q743.04'),
('Q745.05', 'Q743.05'),
('Q746', 'Q744'),
('Q746.01', 'Q744.01'),
('S 01', 'S 01'),
('Q001', 'Q001'),
('Q002', 'Q002'),
('Q003', 'Q003'),
('Q004', 'Q004'),
('Q005', 'Q005'),
('Q006', 'Q006'),
('Q007', 'Q007'),
('Q008', 'Q008'),
('Q009', 'Q009'),
('Q010', 'Q010'),
('Q011', 'Q011'),
('Q012', 'Q012'),
('Q013', 'Q013'),
('Q014', 'Q014'),
('Q015', 'Q015'),
('Q016', 'Q016'),
('Q017', 'Q017'),
('Q018', 'Q018'),
('Q019', 'Q019'),
('Q020', 'Q020'),
('Q021', 'Q021'),
('Q022', 'Q022'),
('Q023', 'Q023'),
('Q024', 'Q024'),
('Q025', 'Q025'),
('Q026', 'Q026'),
('Q027', 'Q027'),
('Q028', 'Q028'),
('Q029', 'Q029'),
('Q030', 'Q030'),
('Q031', 'Q031'),
('Q032', 'Q032'),
('Q033', 'Q033'),
('Q034', 'Q034'),
('Q035', 'Q035'),
('Q036', 'Q036'),
('Q037', 'Q037'),
('Q038', 'Q038'),
('Q039', 'Q039'),
('Q040', 'Q040'),
('Q041', 'Q041'),
('Q042', 'Q042'),
('Q042.01', 'Q042.01'),
('Q042.02', 'Q042.02'),
('Q042.03', 'Q042.03'),
('Q043', 'Q043'),
('Q044', 'Q044'),
('Q045', 'Q045'),
('Q046', 'Q046'),
('Q047', 'Q047'),
('Q048', 'Q048'),
('Q049', 'Q049'),
('Q050', 'Q050'),
('Q051', 'Q051'),
('Q051.01', 'Q051.01'),
('Q051.02', 'Q051.02'),
('Q051.03', 'Q051.03'),
('Q052', 'Q052'),
('Q053', 'Q053'),
('Q054', 'Q054'),
('Q055', 'Q055'),
('Q056', 'Q056'),
('Q057', 'Q057'),
('Q058', 'Q058'),
('Q059', 'Q059'),
('Q060', 'Q060'),
('Q061', 'Q061'),
('Q062', 'Q062'),
('Q063', 'Q063'),
('Q064', 'Q064'),
('Q065', 'Q065'),
('Q065.01', 'Q065.01'),
('Q065.02', 'Q065.02'),
('Q066', 'Q066'),
('Q066.01', 'Q066.01'),
('Q066.02', 'Q066.02'),
('Q066.03', 'Q066.03'),
('Q066.04', 'Q066.04'),
('Q067', 'Q067'),
('Q068', 'Q068'),
('Q069', 'Q069'),
('Q070', 'Q070'),
('Q071', 'Q071'),
('Q072', 'Q072'),
('Q073', 'Q073'),
('Q073.01', 'Q073.01'),
('Q073.02', 'Q073.02'),
('Q073.03', 'Q073.03'),
('Q073.04', 'Q073.04'),
('Q073.05', 'Q073.05'),
('Q073.06', 'Q073.06'),
('Q074', 'Q074'),
('Q075', 'Q075'),
('Q076', 'Q076'),
('Q077', 'Q077'),
('Q077.01', 'Q077.01'),
('Q077.02', 'Q077.02'),
('Q077.03', 'Q077.03'),
('Q078', 'Q078'),
('Q078.01', 'Q078.01'),
('Q078.02', 'Q078.02'),
('Q078.03', 'Q078.03'),
('Q078.04', 'Q078.04'),
('Q078.05', 'Q078.05'),
('Q078.06', 'Q078.06'),
('Q078.07', 'Q078.07'),
('Q078.08', 'Q078.08'),
('Q078.09', 'Q078.09'),
('Q078.10', 'Q078.10'),
('Q078.11', 'Q078.11');
INSERT INTO code_map (old, new) VALUES
('Q078.12', 'Q078.12'),
('Q079', 'Q079'),
('Q080', 'Q080'),
('Q080.01', 'Q080.01'),
('Q080.02', 'Q080.02'),
('Q080.03', 'Q080.03'),
('Q080.04', 'Q080.04'),
('Q080.05', 'Q080.05'),
('Q081', 'Q081'),
('Q082', 'Q082'),
('Q083', 'Q083'),
('Q084', 'Q084'),
('Q085', 'Q085'),
('Q086', 'Q086'),
('Q087', 'Q087'),
('Q088', 'Q088'),
('Q089', 'Q089'),
('Q089.01', 'Q089.01'),
('Q089.02', 'Q089.02'),
('Q089.03', 'Q089.03'),
('Q090', 'Q090'),
('Q091', 'Q091'),
('Q092', 'Q092'),
('Q092.01', 'Q092.01'),
('Q092.02', 'Q092.02'),
('Q092.03', 'Q092.03'),
('Q092.04', 'Q092.04'),
('Q092.05', 'Q092.05'),
('Q092.06', 'Q092.06'),
('Q092.07', 'Q092.07'),
('Q092.08', 'Q092.08'),
('Q092.09', 'Q092.09'),
('Q093', 'Q093'),
('Q093.01', 'Q093.01'),
('Q093.02', 'Q093.02'),
('Q093.02.01', 'Q093.02.01'),
('Q093.02.02', 'Q093.02.02'),
('Q093.02.03', 'Q093.02.03'),
('Q093.03', 'Q093.03'),
('Q093.04', 'Q093.04'),
('Q093.05', 'Q093.05'),
('Q093.06', 'Q093.06'),
('Q093.07', 'Q093.07'),
('Q093.08', 'Q093.08'),
('Q093.09', 'Q093.09'),
('Q093.09.01', 'Q093.09.01'),
('Q093.09.02', 'Q093.09.02'),
('Q093.10', 'Q093.10'),
('Q093.11', 'Q093.11'),
('Q094', 'Q094'),
('Q095', 'Q095'),
('Q096', 'Q096'),
('Q096.01', 'Q096.01'),
('Q096.02', 'Q096.02'),
('Q096.03', 'Q096.03'),
('Q096.04', 'Q096.04'),
('Q096.05', 'Q096.05'),
('Q096.06', 'Q096.06'),
('Q097', 'Q097'),
('Q098', 'Q098'),
('Q099', 'Q099'),
('Q100', 'Q100'),
('Q101', 'Q101'),
('Q102', 'Q102'),
('Q102.01', 'Q102.01'),
('Q102.02', 'Q102.02'),
('Q102.03', 'Q102.03'),
('Q107.01', 'Q107.01'),
('Q107.02', 'Q107.02'),
('Q111.01', 'Q111.01'),
('Q111.02', 'Q111.02'),
('Q111.03', 'Q111.03'),
('Q113.01', 'Q113.01'),
('Q113.02', 'Q113.02'),
('Q113.03', 'Q113.03'),
('Q116.01', 'Q116.01'),
('Q116.02', 'Q116.02'),
('Q120.01', 'Q120.01'),
('Q120.02', 'Q120.02'),
('Q121.03', 'Q121.03'),
('Q123.01', 'Q123.01'),
('Q123.02', 'Q123.02'),
('Q123.03', 'Q123.03'),
('Q123.04', 'Q123.04'),
('Q130.01', 'Q130.01'),
('Q130.02', 'Q130.02'),
('Q131.03', 'Q131.03'),
('Q131.04', 'Q131.04'),
('Q131.05', 'Q131.05'),
('Q131.06', 'Q131.06'),
('Q131.07', 'Q131.07'),
('Q131.08', 'Q131.08'),
('Q133.01', 'Q133.01'),
('Q133.02', 'Q133.02'),
('Q156.01', 'Q156.01'),
('Q156.02', 'Q156.02'),
('Q156.03', 'Q156.03'),
('Q167.01', 'Q167.01'),
('Q167.02', 'Q167.02'),
('Q167.03', 'Q167.03'),
('Q167.04', 'Q167.04'),
('Q167.05', 'Q167.05'),
('Q167.06', 'Q167.06'),
('Q175.01', 'Q175.01'),
('Q175.02', 'Q175.02'),
('Q175.03', 'Q175.03'),
('Q175.04', 'Q175.04'),
('Q175.05', 'Q175.05'),
('Q175.06', 'Q175.06'),
('Q184.01', 'Q184.01'),
('Q184.02', 'Q184.02'),
('Q184.03', 'Q184.03'),
('Q184.04', 'Q184.04'),
('Q191.01', 'Q191.01'),
('Q191.02', 'Q191.02'),
('Q191.03', 'Q191.03'),
('Q191.04', 'Q191.04'),
('Q191.05', 'Q191.05'),
('Q191.06', 'Q191.06'),
('Q191.07', 'Q191.07'),
('Q197.01', 'Q197.01'),
('Q197.01.01', 'Q197.01.01'),
('Q197.01.02', 'Q197.01.02'),
('Q197.01.03', 'Q197.01.03'),
('Q197.01.04', 'Q197.01.04'),
('Q197.01.05', 'Q197.01.05'),
('Q197.01.06', 'Q197.01.06'),
('Q197.01.07', 'Q197.01.07'),
('Q197.01.08', 'Q197.01.08'),
('Q197.01.09', 'Q197.01.09'),
('Q197.01.10', 'Q197.01.10'),
('Q197.01.11', 'Q197.01.11'),
('Q197.01.12', 'Q197.01.12'),
('Q197.01.13', 'Q197.01.13'),
('Q197.01.14', 'Q197.01.14'),
('Q197.02', 'Q197.02'),
('Q197.02.01', 'Q197.02.01'),
('Q197.02.02', 'Q197.02.02'),
('Q197.02.03', 'Q197.02.03'),
('Q197.02.04', 'Q197.02.04'),
('Q197.02.05', 'Q197.02.05'),
('Q197.03', 'Q197.03'),
('Q197.03.01', 'Q197.03.01'),
('Q197.03.02', 'Q197.03.02'),
('Q197.03.03', 'Q197.03.03'),
('Q197.03.04', 'Q197.03.04'),
('Q197.03.05', 'Q197.03.05'),
('Q197.03.06', 'Q197.03.06'),
('Q197.03.07', 'Q197.03.07'),
('Q197.04', 'Q197.04'),
('Q197.04.01', 'Q197.04.01'),
('Q197.04.02', 'Q197.04.02'),
('Q197.04.03', 'Q197.04.03'),
('Q197.04.04', 'Q197.04.04'),
('Q197.04.05', 'Q197.04.05'),
('Q200.01', 'Q200.01'),
('Q200.02', 'Q200.02'),
('Q200.03', 'Q200.03'),
('Q200.04', 'Q200.04'),
('Q200.05', 'Q200.05'),
('Q200.06', 'Q200.06'),
('Q200.07', 'Q200.07'),
('Q200.08', 'Q200.08'),
('Q200.09', 'Q200.09'),
('Q200.10', 'Q200.10'),
('Q214-A', 'Q214-A'),
('Q224.01', 'Q224.01'),
('Q224.02', 'Q224.02'),
('Q224.03', 'Q224.03'),
('Q226.01', 'Q226.01'),
('Q226.02', 'Q226.02'),
('Q226.03', 'Q226.03'),
('Q232.01', 'Q232.01'),
('Q232.02', 'Q232.02'),
('Q232.03', 'Q232.03'),
('Q234.01', 'Q234.01'),
('Q234.02', 'Q234.02'),
('Q234.03', 'Q234.03'),
('Q237.01', 'Q237.01'),
('Q237.02', 'Q237.02'),
('Q237.03', 'Q237.03'),
('Q245.01', 'Q245.01'),
('Q245.01.01', 'Q245.01.01'),
('Q245.01.02', 'Q245.01.02'),
('Q245.01.03', 'Q245.01.03'),
('Q245.01.04', 'Q245.01.04'),
('Q245.01.05', 'Q245.01.05'),
('Q245.01.06', 'Q245.01.06'),
('Q245.01.07', 'Q245.01.07'),
('Q245.01.08', 'Q245.01.08'),
('Q245.01.09', 'Q245.01.09'),
('Q245.01.10', 'Q245.01.10'),
('Q245.02', 'Q245.02'),
('Q245.02.01', 'Q245.02.01'),
('Q245.02.02', 'Q245.02.02'),
('Q245.02.03', 'Q245.02.03'),
('Q245.02.04', 'Q245.02.04'),
('Q245.02.05', 'Q245.02.05'),
('Q245.03', 'Q245.03'),
('Q245.03.01', 'Q245.03.01');
INSERT INTO code_map (old, new) VALUES
('Q245.03.02', 'Q245.03.02'),
('Q245.03.03', 'Q245.03.03'),
('Q253.01', 'Q253.01'),
('Q253.02', 'Q253.02'),
('Q253.03', 'Q253.03'),
('Q253.04', 'Q253.04'),
('Q253.05', 'Q253.05'),
('Q253.06', 'Q253.06'),
('Q253.07', 'Q253.07'),
('Q253.08', 'Q253.08'),
('Q253.09', 'Q253.09'),
('Q253.10', 'Q253.10'),
('Q259.01', 'Q259.01'),
('Q259.02', 'Q259.02'),
('Q259.03', 'Q259.03'),
('Q259.04', 'Q259.04'),
('Q259.05', 'Q259.05'),
('Q260.06', 'Q260.06'),
('Q267.01', 'Q267.01'),
('Q267.02', 'Q267.02'),
('Q267.03', 'Q267.03'),
('Q267.04', 'Q267.04'),
('Q267.05', 'Q267.05'),
('Q267.06', 'Q267.06'),
('Q267.07', 'Q267.07'),
('Q267.08', 'Q267.08'),
('Q269.01', 'Q269.01'),
('Q269.02', 'Q269.02'),
('Q269.03', 'Q269.03'),
('Q269.04', 'Q269.04'),
('Q271.04', 'Q271.04'),
('Q271.05', 'Q271.05'),
('Q271.06', 'Q271.06'),
('Q275.01', 'Q275.01'),
('Q275.02', 'Q275.02'),
('Q296.01', 'Q296.01'),
('Q296.02', 'Q296.02'),
('Q296.03', 'Q296.03'),
('Q296.04', 'Q296.04'),
('Q301.01', 'Q301.01'),
('Q301.02', 'Q301.02'),
('Q301.03', 'Q301.03'),
('Q311.01', 'Q311.01'),
('Q311.02', 'Q311.02'),
('Q311.03', 'Q311.03'),
('Q328.01', 'Q328.01'),
('Q328.02', 'Q328.02'),
('Q328.03', 'Q328.03'),
('Q328.04', 'Q328.04'),
('Q358.01', 'Q358.01'),
('Q358.02', 'Q358.02'),
('Q358.03', 'Q358.03'),
('Q358.04', 'Q358.04'),
('Q358.05', 'Q358.05'),
('Q358.06', 'Q358.06'),
('Q405.01', 'Q405.01'),
('Q405.02', 'Q405.02'),
('Q405.03', 'Q405.03'),
('Q405.04', 'Q405.04'),
('Q407.01', 'Q407.01'),
('Q407.02', 'Q407.02'),
('Q407.03', 'Q407.03'),
('Q444.01', 'Q444.01'),
('Q444.02', 'Q444.02'),
('Q444.03', 'Q444.03'),
('Q444.04', 'Q444.04'),
('Q444.05', 'Q444.05'),
('Q460.01', 'Q460.01'),
('Q460.02', 'Q460.02'),
('Q460.03', 'Q460.03'),
('Q462.01', 'Q462.01'),
('Q462.02', 'Q462.02'),
('Q462.03', 'Q462.03'),
('Q462.04', 'Q462.04'),
('Q462.05', 'Q462.05'),
('Q462.06', 'Q462.06'),
('Q462.06.01', 'Q462.06.01'),
('Q462.06.02', 'Q462.06.02'),
('Q462.06.03', 'Q462.06.03'),
('Q462.06.04', 'Q462.06.04'),
('Q462.06.05', 'Q462.06.05'),
('Q462.07', 'Q462.07'),
('Q462.08', 'Q462.08'),
('Q462.09', 'Q462.09'),
('Q491.01', 'Q491.01'),
('Q491.02', 'Q491.02'),
('Q491.03', 'Q491.03'),
('Q491.04', 'Q491.04'),
('Q493.04', 'Q493.04'),
('Q493.05', 'Q493.05'),
('Q497.01', 'Q497.01'),
('Q497.02', 'Q497.02'),
('Q497.03', 'Q497.03'),
('Q497.04', 'Q497.04'),
('Q497.05', 'Q497.05'),
('Q497.06', 'Q497.06'),
('Q497.07', 'Q497.07'),
('Q513.01', 'Q513.01'),
('Q513.02', 'Q513.02'),
('Q513.03', 'Q513.03'),
('Q513.04', 'Q513.04'),
('Q513.05', 'Q513.05'),
('Q529.01', 'Q529.01'),
('Q529.02', 'Q529.02'),
('Q529.03', 'Q529.03'),
('Q529.04', 'Q529.04'),
('Q537.01', 'Q537.01'),
('Q537.02', 'Q537.02'),
('Q537.03', 'Q537.03'),
('Q537.04', 'Q537.04'),
('Q546.01', 'Q546.01'),
('Q546.02', 'Q546.02'),
('Q546.03', 'Q546.03'),
('Q546.04', 'Q546.04'),
('Q547.05', 'Q547.05'),
('Q547.06', 'Q547.06'),
('Q547.07', 'Q547.07'),
('Q549.01', 'Q549.01'),
('Q549.02', 'Q549.02'),
('Q549.02.01', 'Q549.02.01'),
('Q549.02.02', 'Q549.02.02'),
('Q549.02.03', 'Q549.02.03'),
('Q549.02.04', 'Q549.02.04'),
('Q549.02.05', 'Q549.02.05'),
('Q549.03', 'Q549.03'),
('Q549.03.01', 'Q549.03.01'),
('Q549.03.02', 'Q549.03.02'),
('Q549.03.03', 'Q549.03.03'),
('Q549.04', 'Q549.04'),
('Q549.05', 'Q549.05'),
('Q550.06', 'Q550.06'),
('Q550.07', 'Q550.07'),
('Q550.08', 'Q550.08'),
('Q557.01', 'Q557.01'),
('Q557.02', 'Q557.02'),
('Q557.03', 'Q557.03'),
('Q557.04', 'Q557.04'),
('Q557.05', 'Q557.05'),
('Q560.01', 'Q560.01'),
('Q560.02', 'Q560.02'),
('Q560.02.01', 'Q560.02.01'),
('Q560.02.02', 'Q560.02.02'),
('Q560.02.03', 'Q560.02.03'),
('Q560.02.04', 'Q560.02.04'),
('Q560.03', 'Q560.03'),
('Q560.04', 'Q560.04'),
('Q560.05', 'Q560.05'),
('Q560.06', 'Q560.06'),
('Q560.06.01', 'Q560.06.01'),
('Q560.06.02', 'Q560.06.02'),
('Q560.07', 'Q560.07'),
('Q560.08', 'Q560.08'),
('Q560.09', 'Q560.09'),
('Q560.09.01', 'Q560.09.01'),
('Q560.09.02', 'Q560.09.02'),
('Q580.01', 'Q580.01'),
('Q580.01.01', 'Q580.01.01'),
('Q580.01.02', 'Q580.01.02'),
('Q580.02', 'Q580.02'),
('Q580.02.01', 'Q580.02.01'),
('Q580.02.02', 'Q580.02.02'),
('Q580.03', 'Q580.03'),
('Q580.03.01', 'Q580.03.01'),
('Q580.03.02', 'Q580.03.02'),
('Q580.04', 'Q580.04'),
('Q580.04.01', 'Q580.04.01'),
('Q580.04.02', 'Q580.04.02'),
('Q584.01', 'Q584.01'),
('Q584.02', 'Q584.02'),
('Q592.01', 'Q592.01'),
('Q592.02', 'Q592.02'),
('Q592.03', 'Q592.03'),
('Q592.04', 'Q592.04'),
('Q596.01', 'Q596.01'),
('Q596.02', 'Q596.02'),
('Q596.03', 'Q596.03'),
('Q596.04', 'Q596.04'),
('Q598.01', 'Q598.01'),
('Q598.02', 'Q598.02'),
('Q598.03', 'Q598.03'),
('Q598.04', 'Q598.04'),
('Q598.05', 'Q598.05'),
('Q598.06', 'Q598.06'),
('Q598.07', 'Q598.07'),
('Q606.01', 'Q606.01'),
('Q606.02', 'Q606.02'),
('Q606.03', 'Q606.03'),
('Q607.04', 'Q607.04'),
('Q607.05', 'Q607.05'),
('Q607.06', 'Q607.06'),
('Q607.07', 'Q607.07'),
('Q607.08', 'Q607.08'),
('Q607.09', 'Q607.09'),
('Q609.01', 'Q609.01'),
('Q609.02', 'Q609.02'),
('Q612.01', 'Q612.01'),
('Q612.02', 'Q612.02'),
('Q614.01', 'Q614.01'),
('Q614.02', 'Q614.02'),
('Q614.03', 'Q614.03');
INSERT INTO code_map (old, new) VALUES
('Q614.04', 'Q614.04'),
('Q614.05', 'Q614.05'),
('Q614.06', 'Q614.06'),
('Q614.07', 'Q614.07'),
('Q616.01', 'Q616.01'),
('Q616.02', 'Q616.02'),
('Q616.03', 'Q616.03'),
('Q616.04', 'Q616.04'),
('Q616.05', 'Q616.05'),
('Q616.06', 'Q616.06'),
('Q619.01', 'Q619.01'),
('Q619.02', 'Q619.02'),
('Q619.03', 'Q619.03'),
('Q619.04', 'Q619.04'),
('Q622.01', 'Q622.01'),
('Q622.02', 'Q622.02'),
('Q622.03', 'Q622.03'),
('Q622.04', 'Q622.04'),
('Q623.04.01', 'Q623.04.01'),
('Q623.04.02', 'Q623.04.02'),
('Q638.01', 'Q638.01'),
('Q638.02', 'Q638.02'),
('Q638.03', 'Q638.03'),
('Q640.01', 'Q640.01'),
('Q640.02', 'Q640.02'),
('Q640.03', 'Q640.03'),
('Q640.04', 'Q640.04'),
('Q640.05', 'Q640.05'),
('Q640.06', 'Q640.06'),
('Q659.01', 'Q659.01'),
('Q659.02', 'Q659.02'),
('Q659.03', 'Q659.03'),
('Q659.04', 'Q659.04'),
('Q660.01', 'Q660.01'),
('Q660.02', 'Q660.02'),
('Q664.01', 'Q664.01'),
('Q664.02', 'Q664.02'),
('Q664.03', 'Q664.03'),
('Q723.01', 'Q723.01'),
('Q723.02', 'Q723.02'),
('Q723.03', 'Q723.03'),
('Q723.04', 'Q723.04'),
('Q732.01', 'Q732.01'),
('Q732.02', 'Q732.02'),
('Q732.03', 'Q732.03'),
('Q736.01', 'Q736.01'),
('Q736.02', 'Q736.02'),
('Q743.01', 'Q743.01'),
('Q743.02', 'Q743.02'),
('Q743.03', 'Q743.03'),
('Q743.04', 'Q743.04'),
('Q743.05', 'Q743.05'),
('Q744.01', 'Q744.01');
DELETE FROM responses r USING code_map m
WHERE r.question_id = m.old AND EXISTS (
  SELECT 1 FROM responses r2 JOIN code_map m2 ON m2.old = r2.question_id
  WHERE m2.new = m.new AND r2.evaluation_id = r.evaluation_id AND r2.question_id <> r.question_id
    AND (r2.updated_at, r2.question_id) > (r.updated_at, r.question_id));
UPDATE responses r SET question_id = '~' || m.new FROM code_map m WHERE r.question_id = m.old;
DELETE FROM responses WHERE question_id NOT LIKE '~%';  -- questions supprimées du référentiel
UPDATE responses SET question_id = substr(question_id, 2);

-- Sections et questions
DELETE FROM questions;
DELETE FROM sections;
INSERT INTO sections (id, parent_id, title, level, sort_order) VALUES
(1, NULL, 'MANAGEMENT DU SYSTÈME QUALITÉ PHARMACEUTIQUE', 1, 1),
(2, 1, 'PRINCIPES', 2, 2),
(3, 1, 'SYSTÈME QUALITÉ PHARMACEUTIQUE', 2, 3),
(4, 1, 'BONNES PRATIQUES DE PRÉPARATION', 2, 4),
(5, 1, 'REVUE QUALITÉ DES PRÉPARATIONS PHARMACEUTIQUES', 2, 5),
(6, 1, 'APPRÉCIATION DU RISQUE DE LA PRÉPARATION PHARMACEUTIQUE', 2, 6),
(7, NULL, 'DOCUMENTATION', 1, 7),
(8, 7, 'PRINCIPES', 2, 8),
(9, 7, 'GÉNÉRALITÉS ET BONNES PRATIQUES DOCUMENTAIRES', 2, 9),
(10, 7, 'PROCÉDURES GÉNÉRALES', 2, 10),
(11, 10, 'RÉCEPTION, ÉCHANTILLONNAGE DES MPUP, DES ARTICLES DE CONDITIONNEMENT ET DES PRÉPARATIONS PHARMACEUTIQUES TERMINÉES, PRÉPARATIONS, CONTRÔLES DES MPUP, DES ARTICLES DE CONDITIONNEMENT ET DES PRÉPARATIONS PHARMACEUTIQUES TERMINÉES, ENVIRONNEMENT, MATÉRIEL, ÉQUIPEMENTS ET ZONES CRITIQUES', 3, 11),
(12, 10, 'DOCUMENTATION SPÉCIFIQUE AUX OPÉRATIONS DE CONTRÔLE', 3, 12),
(13, 10, 'PERSONNEL', 3, 13),
(14, 10, 'LIBÉRATION DES MPUP, DES ARTICLES DE CONDITIONNEMENT ET DES PREPARATIONS PHARMACEUTIQUES TERMINEES', 3, 14),
(15, 10, 'GESTION DES ANOMALIES, DES RETOURS, DES RÉCLAMATIONS ET DES RAPPELS DE PRÉPARATION PHARMACEUTIQUE', 3, 15),
(16, 10, 'SIGNALEMENT (ÉVENEMENT INDÉSIRABLE GRAVE, PHARMACOVIGILANCE, INFECTIONS NOSOCOMIALES)', 3, 16),
(17, 7, 'CONSTITUTION DU DOSSIER DE PRÉPARATION PHARMACEUTIQUE', 2, 17),
(18, 17, 'VALIDITÉ TECHNICO-RÉGLEMENTAIRE DE LA PRÉPARATION PHARMACEUTIQUE (ANNEXE II PARTIE 1)', 3, 18),
(19, 17, 'SPÉCIFICATIONS ET INSTRUCTIONS DE LA PRÉPARATION PHARMACEUTIQUE ET DE SON CONDITIONNEMENT (ANNEXE II PARTIE 2)', 3, 19),
(20, 17, 'CONTRÔLES EN COURS ET EN FIN DE PRÉPARATION (ANNEXE II PARTIE 3)', 3, 20),
(21, 7, 'CONSTITUTION DU DOSSIER DE LOT', 2, 21),
(22, 7, 'AUTRES DOCUMENTS', 2, 22),
(23, 7, 'ARCHIVAGE', 2, 23),
(24, NULL, 'PERSONNEL', 1, 24),
(25, 24, 'GÉNÉRALITÉS', 2, 25),
(26, 24, 'RESPONSABILITÉS', 2, 26),
(27, 24, 'FORMATION', 2, 27),
(28, 24, 'HYGIÈNE ET SÉCURITÉ DU PERSONNEL', 2, 28),
(29, NULL, 'LOCAUX ET MATÉRIEL', 1, 29),
(30, 29, 'PRINCIPES', 2, 30),
(31, 29, 'GÉNÉRALITÉS', 2, 31),
(32, 29, 'ZONES D''ATMOSPHÈRE CONTRÔLÉE (ZAC)', 2, 32),
(33, 32, 'Classification particulaire des ZAC', 3, 33),
(34, 32, 'Caractéristiques essentielles des ZAC', 3, 34),
(35, 34, 'Cas de la manipulation des médicaments à risque pour le personnel et l''environnement (caractéristiques ZAC)', 4, 35),
(36, 32, 'Equipements d''atmosphère contrôlée utilisés pour obtenir un environnement de classe A', 3, 36),
(37, 36, 'Poste à flux d''air unidirectionnel', 4, 37),
(38, 37, 'Cas de la manipulation des médicaments à risque pour le personnel et l''environnement (poste à flux)', 5, 38),
(39, 36, 'Isolateur', 4, 39),
(40, 39, 'Cas de la manipulation des médicaments à risque pour le personnel et l''environnement (isolateur)', 5, 40),
(41, 29, 'MATÉRIEL', 2, 41),
(42, 41, 'QUALIFICATION ET MAINTENANCE', 3, 42),
(43, 42, 'MATÉRIEL', 4, 43),
(44, 42, 'CAMÉRA ET MATÉRIEL INFORMATIQUE', 4, 44),
(45, 42, 'SYSTÈME DE COMMUNICATION', 4, 45),
(46, 29, 'NETTOYAGE-DÉSINFECTION DES ZAC', 2, 46),
(47, 46, 'Nettoyage-désinfection des zones de classe B, C, ou D', 3, 47),
(48, 46, 'Nettoyage / Désinfection des équipements d''atmosphère contrôlée utilisés pour obtenir un environnement de classe A', 3, 48),
(49, 29, 'SURVEILLANCE DE L''ENVIRONNEMENT', 2, 49),
(50, 49, 'Surveillance microbiologique', 3, 50),
(51, 50, 'Surveillance de routine', 4, 51),
(52, NULL, 'OPÉRATIONS CONDUISANT À LA RÉALISATION D''UNE PRÉPARATION PHARMACEUTIQUE', 1, 52),
(53, NULL, 'CONTRÔLE DE LA QUALITÉ', 1, 53),
(54, 53, 'ÉQUIPEMENT ET MATÉRIEL', 2, 54),
(55, 53, 'ÉTALONS DE RÉFÉRENCE, RÉACTIFS ET SOLUTIONS TITRÉES', 2, 55),
(56, 53, 'CONTRÔLE DES MATIÈRES PREMIÈRES À USAGE PHARMACEUTIQUE ET DES ARTICLES DE CONDITIONNEMENT', 2, 56),
(57, 56, 'GÉNÉRALITÉS', 3, 57),
(58, 56, '1re catégorie et contrôles associés', 3, 58),
(59, 56, '2e catégorie et contrôles associés', 3, 59),
(60, 56, '3e catégorie et contrôles associés', 3, 60),
(61, NULL, 'ACTIVITÉS EXTERNALISÉES', 1, 61),
(62, 61, 'PRINCIPES', 2, 62),
(63, 61, 'GÉNÉRALITÉS / CONTRAT', 2, 63),
(64, 61, 'LE DONNEUR D''ORDRE', 2, 64),
(65, 61, 'LE SOUS-TRAITANT : LE PRESTATAIRE', 2, 65),
(66, 61, 'CAS DE LA SOUS-TRAITANCE DES OPÉRATIONS DE PRÉPARATION', 2, 66),
(67, 61, 'CAS DE LA SOUS-TRAITANCE DES CONTRÔLES', 2, 67),
(68, 61, 'CAS DE LA SOUS-TRAITANCE DES TRANSPORTS', 2, 68),
(69, 61, 'AUTRES SOUS-TRAITANCES', 2, 69),
(70, NULL, 'RÉCLAMATIONS ET RAPPELS', 1, 70),
(71, 70, 'RÉCLAMATIONS', 2, 71),
(72, NULL, 'AUTO-INSPECTION', 1, 72),
(73, NULL, 'Préparations stériles - LD1', 1, 73),
(74, 73, 'GÉNÉRALITÉS', 2, 74),
(75, 73, 'PROCÉDÉS DE PRÉPARATION', 2, 75),
(76, 75, 'Stérilisation terminale', 3, 76),
(77, 75, 'Filtration stérilisante', 3, 77),
(78, 75, 'Préparation aseptique', 3, 78),
(79, 78, 'Préparation aseptique selon un procédé de transfert en système clos', 4, 79),
(80, 78, 'Préparation aseptique selon un procédé en système ouvert', 4, 80),
(81, 73, 'PRÉPARATION ET CONDITIONNEMENT', 2, 81),
(82, 81, 'CRITÈRES DE CHOIX DE LA ZONE D''ATMOSPHÈRE CONTRÔLÉE ET DE L''ÉQUIPEMENT', 3, 82),
(83, 81, 'OPÉRATION DE PRÉPARATION ET DE CONDITIONNEMENT', 3, 83),
(84, 73, 'CONTRÔLE DE LA QUALITÉ', 2, 84),
(85, 84, 'CONTRÔLE DE LA PRÉPARATION PHARMACEUTIQUE TERMINÉE ET STRATÉGIE LIBÉRATOIRE', 3, 85),
(86, 84, 'CONTRÔLES ENVIRONNEMENTAUX', 3, 86),
(87, NULL, 'Substances à risque (CMR) - LD2', 1, 87),
(88, 87, 'LOCAUX', 2, 88),
(89, 87, 'MATÉRIELS ET ÉQUIPEMENTS', 2, 89),
(90, 87, 'PRÉPARATION', 2, 90),
(91, 87, 'CONDITIONNEMENT', 2, 91),
(92, 87, 'CONTRÔLE ET LIBÉRATION', 2, 92),
(93, NULL, 'Essais cliniques - LD3', 1, 93),
(94, 93, 'PRINCIPES', 2, 94),
(95, 93, 'GÉNÉRALITÉS', 2, 95),
(96, 93, 'PERSONNEL', 2, 96),
(97, 93, 'LOCAUX', 2, 97),
(98, 93, 'MATÉRIEL', 2, 98),
(99, 93, 'DOCUMENTATION', 2, 99),
(100, 99, 'DOSSIER DE PRÉPARATION PHARMACEUTIQUE', 3, 100);
INSERT INTO sections (id, parent_id, title, level, sort_order) VALUES
(101, 99, 'ARCHIVAGE', 3, 101),
(102, 93, 'PRÉPARATION ET CONDITIONNEMENT', 2, 102),
(103, 102, 'OPÉRATIONS DE MISE EN INSU POUR LES PRÉPARATIONS DE MÉDICAMENTS EXPÉRIMENTAUX ET CODE DE RANDOMISATION', 3, 103),
(104, 102, 'CONDITIONNEMENT', 3, 104),
(105, 93, 'ÉTIQUETAGE', 2, 105),
(106, 93, 'LIBÉRATION PHARMACEUTIQUE', 2, 106),
(107, 93, 'ÉCHANTILLOTHÈQUE', 2, 107),
(108, 93, 'RÉCLAMATIONS, RAPPELS, RETOURS ET DESTRUCTION', 2, 108);
SELECT setval(pg_get_serial_sequence('sections', 'id'), (SELECT MAX(id) FROM sections));
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('S 01', 'S 01', 2, NULL, 'Les préparations pharmaceutiques réalisées garantissent une qualité constante, appropriée à leur usage, conformément aux exigences des BPP', '1.01', NULL, '1.01', NULL, NULL, FALSE, 1),
('Q001', 'Q001', 2, NULL, 'Il existe un Système d''Assurance Qualité', '1.02', NULL, '1.02', NULL, NULL, FALSE, 2),
('Q002', 'Q002', 2, NULL, 'Ce système est documenté (MAQ, Procédures, Modes Opératoires, Enregistrements ...)', '1.02', NULL, '1.02', NULL, NULL, FALSE, 3),
('Q003', 'Q003', 2, NULL, 'Ce système est controlé (auto-inspection, audits,..)', '1.02', NULL, '1.02, 1.05', NULL, NULL, FALSE, 4),
('Q004', 'Q004', 2, NULL, 'Des indicateurs qualités sont identifiés et suivis', '1.02', NULL, '1.02, 1.05', NULL, NULL, FALSE, 5),
('Q005', 'Q005', 3, NULL, 'Le Système d''Assurance Qualité est basé sur les "Bonnes Pratiques de Préparation" publiées par l''ANSM en 2023 (documents qualités intégrant les BPP)', '1.03', NULL, '1.03, 1.04, 1.06, 1.07, 1.02', NULL, NULL, FALSE, 6),
('Q006', 'Q006', 3, NULL, 'Il existe un Système de Gestion Documentaire', '1.05', NULL, '1.05', NULL, NULL, FALSE, 7),
('Q007', 'Q007', 3, NULL, 'Le système d''assurance qualité est connu du personnel impliqué dans la production', '1.05', NULL, '1.05', NULL, NULL, FALSE, 8),
('Q008', 'Q008', 3, NULL, 'Les préparations pharmaceutiques sont formulées et réalisées selon l’état des connaissances scientifiques, médicales et pharmaceutiques et l''analyse y conduisant est tracée (exemple de dossier de préparation suivant annexe)', '1.05', NULL, '1.05', NULL, NULL, FALSE, 9),
('Q009', 'Q009', 5, NULL, 'Des revues qualité sont organisées selon une périodicité définie après analyse des réclamations et des non-conformité', '1.10', NULL, '1.10', NULL, NULL, FALSE, 10),
('Q010', 'Q010', 5, NULL, 'Les revues qualités sont documentées', '1.10', NULL, '1.10', NULL, NULL, FALSE, 11),
('Q011', 'Q011', 5, NULL, 'Les revues qualités alimentent l''analyse globale de risque', '1.10', NULL, '1.10', NULL, NULL, FALSE, 12),
('Q012', 'Q012', 6, NULL, 'L''appréciation du risque de la préparation pharmaceutique est réalisée (bénéfice/risque), permettant de décider si des mesures de réduction du risque doivent être mises en œuvre, ou si le risque existant peut être accepté', '1.11', NULL, '1.11', NULL, NULL, FALSE, 13),
('Q013', 'Q013', 6, NULL, 'Une analyse pharmaceutique et réglementaire est réalisée pour chaque type de préparation (annexe I)', '1.12', NULL, '1.12', NULL, NULL, FALSE, 14),
('Q014', 'Q014', 6, NULL, 'L''analyse pharmaceutique et réglementaire pour chaque type de préparation (annexe I) est réalisée et en cas de refus un critère explicite est tracé pour justifier la non réalisation', '1.20', NULL, '1.20', NULL, NULL, FALSE, 15),
('Q015', 'Q015', 6, NULL, 'En cas d’impossibilité de réalisation de préparation, un contrat de sous-traitance est établi en amont, selon les modalités décrites par par le présent texte.', '1.19', NULL, '1.19', NULL, NULL, FALSE, 16),
('Q016', 'Q016', 6, NULL, 'En cas d’impossibilité de réalisation d''une préparation, la notification et/ou proposition d''alternative au prescripteur est tracée', '1.21', NULL, '1.21', NULL, NULL, FALSE, 17),
('Q017', 'Q017', 6, NULL, 'Une analyse de risque simplifiée est réalisée pour les préparations demandées en urgence', '1.22', NULL, '1.22', NULL, NULL, FALSE, 18),
('Q018', 'Q018', 6, NULL, 'L''analyse technico-réglementaire des préparations est réalisée (annexe II partie 1) avant toute décision de réalisation', '1.13', NULL, '1.13, 1.15, 5.41', NULL, NULL, FALSE, 19),
('Q019', 'Q019', 6, NULL, 'L''analyse technico-réglementaire des préparations prend en compte la réglementation en vigueur (interdictions, restrictions, Formulaire National…)', '1.17', NULL, '1.17', NULL, NULL, FALSE, 20),
('Q020', 'Q020', 6, NULL, 'Des analyses de risques concernant l''intégralité du processus de préparation sont réalisées (annexe III)', '1.11', NULL, '1.11, 4.05, 5.13, 5.23', NULL, NULL, FALSE, 21),
('Q021', 'Q021', 6, NULL, 'Une analyse de risque est réalisée pour classer la préparation en risque faible, moyen ou élevé, selon les critères de l''annexe III (substance active, voie d''administration, forme pharmaceutique, opérations réalisées, nombre de patients), permettant de la classer en risque faible, moyen ou élevé', '1.16', NULL, '1.16, 5.23', NULL, NULL, FALSE, 22),
('Q022', 'Q022', 6, NULL, 'Dans le cadre de l''analyse de risque pour classer la préparation, le niveau de risque « produit » (contamination microbiologique pour le patient) et le niveau de risque « personnel/environnement » (toxicité, CMR, produits biologiques/OGM) sont identifiés et distingués pour chaque produit.', 'LD1.026', NULL, 'LD1.026', NULL, NULL, FALSE, 23),
('Q023', 'Q023', 6, NULL, 'Une analyse de risque toxicologique de la préparation est réalisée, appuyée sur une recherche bibliographique sur les substances actives et excipients', '4.32', NULL, '4.32', NULL, NULL, FALSE, 24),
('Q024', 'Q024', 6, NULL, 'Une analyse de risque relative à la réattribution des préparations est réalisée', '5.61', NULL, '5.61, 5.63', NULL, NULL, FALSE, 25),
('Q025', 'Q025', 6, NULL, 'Le niveau de contrôle qualité appliqué est justifié par référence à l''analyse de risque réalisée pour chaque préparation de la préparation (cf. art. 1.16)', '6.59', NULL, '6.59', NULL, NULL, FALSE, 26),
('Q026', 'Q026', 6, NULL, 'Une analyse du risque d''interactions contenant-contenu est conduite (excipients à risque, données littérature/fournisseur/internes), avec recherche documentée de l''absence d''interaction.', '6.85', NULL, '6.85', NULL, NULL, FALSE, 27),
('Q027', 'Q027', 6, NULL, 'Une analyse de risque est réalisée pour la conception et de l’aménagement des locaux (matière première utilisée /procédé utilisé)', '3.19', NULL, '3.19, 5.18, 5.19, 5.20, 5.21, 5.22', NULL, NULL, FALSE, 28),
('Q028', 'Q028', 6, NULL, 'Une analyse de risque documentée justifie le d''une choix zone (plutôt que local dédié) pour les catégories 1-3 non stériles/non CMR', '3.15', NULL, '3.15', NULL, NULL, FALSE, 29),
('Q029', 'Q029', 6, NULL, 'La stratégie de libération repose sur une évaluation du risque formalisée et documentée.', '6.70', NULL, '6.70', NULL, NULL, FALSE, 30),
('Q030', 'Q030', 6, NULL, 'Une analyse de risque préalable et documentée est réalisée pour le choix des installations et des équipements de préparation stérile', 'LD1.034', NULL, 'LD1.034, 5.18, 5.19, 5.20, 5.21, 5.22', NULL, NULL, FALSE, 31),
('Q031', 'Q031', 6, NULL, 'L''analyse de risque pour le choix des équipement et l''environnement se base sur les niveaux de risque produit et de la nature des manipulations', 'LD1.027', NULL, 'LD1.027, LD1.028, LD1.029, LD1.030, LD1.031', NULL, NULL, FALSE, 32),
('Q032', 'Q032', 6, NULL, 'Une analyse de risque préalable est  réalisée pour le procédé de stérilisation de contact à l''intérieur de l''isolateur', 'LD1.076', NULL, 'LD1.076', NULL, NULL, FALSE, 33),
('Q033', 'Q033', 6, NULL, 'Une analyse de risques est réalisée pour l''élaboration du plan d''échantillonnage', 'LD1.150', NULL, 'LD1.150', NULL, NULL, FALSE, 34),
('Q034', 'Q034', 6, NULL, 'Une analyse de risque est réalisée si les limites de surveillance microbiologique des ZAC ne tiennent pas compte des recommandations décrites dans le tableau 9 (LD1)', 'LD1.154', NULL, 'LD1.154', NULL, NULL, FALSE, 35),
('Q035', 'Q035', 6, NULL, 'Une analyse des risques professionnels est réalisé par l''employeur', 'LD2.012', NULL, 'LD2.012', NULL, NULL, FALSE, 36),
('Q036', 'Q036', 6, NULL, 'L''analyse des risques professionnels permet l''élaboration du Document Unique des Risques Professionnes (DUERP), accessible par l''ensemble du personnel', 'LD2.012', NULL, 'LD2.012', NULL, NULL, FALSE, 37),
('Q037', 'Q037', 6, NULL, 'Le PRP est associé à la réalisation et l''actualisation du DUERP', 'LD2.012', NULL, 'LD2.012', NULL, NULL, FALSE, 38),
('Q038', 'Q038', 6, NULL, 'Une analyse de risque est réalisée, le cas écheant si un même équipement est partagé entre préparations biologiques et chimiques non CMR', 'LD2.019', NULL, 'LD2.019', NULL, NULL, FALSE, 39),
('Q039', 'Q039', 6, NULL, 'Une analyse de risque spécifique est réalisée pour les manipulations présentant un risque de dispersion d''OGM', 'LD2.021', NULL, 'LD2.021', NULL, NULL, FALSE, 40),
('Q040', 'Q040', 6, NULL, 'Une analyse de risque est réalisée pour le choix des EPC / EPI en fonction du type de substances manipulées', 'LD2.015', NULL, 'LD2.015, LD2.036, LD2.041, LD2.042', NULL, NULL, FALSE, 41),
('Q041', 'Q041', 6, NULL, 'Une analyse des risques est réalisée pour déterminer la fréquence de changement des gants', 'LD2.040', NULL, 'LD2.040', NULL, NULL, FALSE, 42),
('Q042', 'Q042', 8, NULL, 'Le système documentaire mis en place (papier ou électronique) est', '4.01', NULL, '4.01, 4.06', NULL, NULL, TRUE, 43),
('Q042.01', 'Q042.01', 8, NULL, 'protégé pour éviter toute modification non autorisée', '4.01', NULL, '4.01, 4.06', NULL, NULL, FALSE, 44),
('Q042.02', 'Q042.02', 8, NULL, 'sauvegardé sur un 2ème support de sauvegarde pour éviter la perte de données', '4.01', NULL, '4.01', NULL, NULL, FALSE, 45),
('Q042.03', 'Q042.03', 8, NULL, 'et les données restent disponible pendant toute la durée de conservation exigée par les documents', '4.01', NULL, '4.01', NULL, NULL, FALSE, 46),
('Q043', 'Q043', 8, NULL, 'L''ensemble de la documentation nécessaire et relative à l''activité du personnel (dossier papier ou logiciel de gestion documentaire) est rapidement accessible', '4.01', NULL, '4.01', NULL, NULL, FALSE, 47),
('Q044', 'Q044', 8, NULL, 'Il existe un logiciel de gestion documentaire', '4.03', NULL, '4.03', NULL, NULL, FALSE, 48),
('Q045', 'Q045', 8, NULL, 'La sauvegarde et restauration du logiciel de gestion documentaire est testée et vérifiée', '4.01', NULL, '4.01', NULL, NULL, FALSE, 49),
('Q046', 'Q046', 8, NULL, 'Les documents existent sous forme électronique et/ou papier', '4.06', NULL, '4.06', NULL, NULL, FALSE, 50),
('Q047', 'Q047', 8, NULL, 'Il existe un logiciel pour la réalisation des préparations', '4.03', NULL, '4.03', NULL, NULL, FALSE, 51),
('Q048', 'Q048', 9, NULL, 'Il existe une procédure de gestion documentaire', '4.04', NULL, '4.04', NULL, NULL, FALSE, 52),
('Q049', 'Q049', 9, NULL, 'La procédure de gestion documentaire couvre explicitement le cycle de vie complet (création, validation, diffusion, révision, archivage, destruction) de chaque type de document', '4.04', NULL, '4.04', NULL, NULL, FALSE, 53),
('Q050', 'Q050', 9, NULL, 'La procédure de gestion documentaire prévoit la mise à jour et la diffusion des documents en prenant en compte les risques liés à la reproduction des documents qualité', '4.07', NULL, '4.07', NULL, NULL, FALSE, 54),
('Q051', 'Q051', 9, NULL, 'La procédure des gestion documentaitre précise le circuit de validation des documents qui sont', '4.08', NULL, '4.08', NULL, NULL, TRUE, 55),
('Q051.01', 'Q051.01', 9, NULL, 'rédigés par une personne identifiée et autorisée', '4.08', NULL, '4.08', NULL, NULL, FALSE, 56),
('Q051.02', 'Q051.02', 9, NULL, 'vérifiés par une personne identifiée et autorisée', '4.08', NULL, '4.08', NULL, NULL, FALSE, 57),
('Q051.03', 'Q051.03', 9, NULL, 'approuvés par une personne identifiée et autorisée', '4.08', NULL, '4.08', NULL, NULL, FALSE, 58),
('Q052', 'Q052', 9, NULL, 'La procédure de gestion documentaire prévoit une révision régulière des documents', '4.10', NULL, '4.10', NULL, NULL, FALSE, 59),
('Q053', 'Q053', 9, NULL, 'Les procédures validées sont diffusées spécifiquement aux personnels concernées (logiciel de gestion documentaire, diffusion papier, réunion de service avec compte rendu…)', '2.04', NULL, '2.04', NULL, NULL, FALSE, 60),
('Q054', 'Q054', 9, NULL, 'Le personnel a accès à la documentation relative à son activité', '4.04', NULL, '4.04, 2.01, 2.04, 6.29', NULL, NULL, FALSE, 61),
('Q055', 'Q055', 9, NULL, 'Le mode de diffusion des documents garantit une preuve de prise de connaissance individuelle par chaque membre du personnel concerné', '4.04', NULL, '4.04, 2.01', NULL, NULL, FALSE, 62),
('Q056', 'Q056', 9, NULL, 'Les procédures applicables dans la ZAC sont communiquées est connue des personnes étrangères à la PUI autorisées par le PRP / gérant PUI  à entrer dans les zones de préparation, de contrôle et de stockage', 'LD1.116', NULL, 'LD1.116, 3.05', NULL, NULL, FALSE, 63),
('Q057', 'Q057', 9, NULL, 'Il existe système de déclaration/documentation relative aux écarts qualité des produits', '4.05', NULL, '4.05', NULL, NULL, FALSE, 64),
('Q058', 'Q058', 9, NULL, 'Le système de déclaration /documentation relative aux écarts de qualité des produits est utilisé en pratique (ex : nombre de déclarations sur les 12 derniers mois)', '4.05', NULL, '4.05', NULL, NULL, FALSE, 65),
('Q059', 'Q059', 9, NULL, 'Des contrôles des enregistrements (durée d''utilisation et archivage) sont réalisés', '4.06', NULL, '4.06', NULL, NULL, FALSE, 66),
('Q060', 'Q060', 9, NULL, 'La date de rédaction du document qualité est enregistrée', '4.08', NULL, '4.08', NULL, NULL, FALSE, 67),
('Q061', 'Q061', 9, NULL, 'La date de mise en application du document qualité est enregistrée', '4.08', NULL, '4.08', NULL, NULL, FALSE, 68),
('Q062', 'Q062', 9, NULL, 'Les documents sont présentées de façon ordonnées (codification prévue dans la procedure de gestion documentaire)', '4.09', NULL, '4.09', NULL, NULL, FALSE, 69),
('Q063', 'Q063', 9, NULL, 'Le style directif est obligatoirement utilisé pour les procédures, les instructions de travail et les modes opératoires', '4.09', NULL, '4.09', NULL, NULL, FALSE, 70),
('Q064', 'Q064', 9, NULL, 'La périodicité de révision des documents qualité est  définie par type de document, avec une alerte automatique ou un suivi des échéances de révision dépassées', '4.10', NULL, '4.10', NULL, NULL, FALSE, 71),
('Q065', 'Q065', 9, NULL, 'En cas de documentation papier, les documents sont :', '4.02', NULL, '4.02', NULL, NULL, TRUE, 72),
('Q065.01', 'Q065.01', 9, NULL, 'Dactylographiés', '4.02', NULL, '4.02', NULL, NULL, FALSE, 73),
('Q065.02', 'Q065.02', 9, NULL, 'Avec de rares entrées manuscrites validées', '4.02', NULL, '4.02', NULL, NULL, FALSE, 74),
('Q066', 'Q066', 9, NULL, 'Les enregistrements manuscrits sont limités.', '4.11', NULL, '4.11', NULL, NULL, FALSE, 75),
('Q066.01', 'Q066.01', 9, NULL, 'Ils sont lisibles', '4.11', NULL, '4.11', NULL, NULL, FALSE, 76),
('Q066.02', 'Q066.02', 9, NULL, 'Ils sont indélébiles', '4.11', NULL, '4.11', NULL, NULL, FALSE, 77),
('Q066.03', 'Q066.03', 9, NULL, 'Leur auteur est identifié', '4.11', NULL, '4.11', NULL, NULL, FALSE, 78),
('Q066.04', 'Q066.04', 9, NULL, 'Leur date/horaire de rédaction est tracé', '4.11', NULL, '4.11', NULL, NULL, FALSE, 79),
('Q067', 'Q067', 9, NULL, 'Il existe des procédures générales', '4.12', NULL, '4.12, 1.07', NULL, NULL, FALSE, 80),
('Q068', 'Q068', 9, NULL, 'Il existe des dossiers de préparation (modes opératoires, fiches de fabrication)', '4.12', NULL, '4.12, 1.07, 5.01, 5.06', NULL, NULL, FALSE, 81),
('Q069', 'Q069', 9, NULL, 'Un dossier de prépration est réalisé pour chaque type de préparation ; il reprend la validité technico réglementaire, et comprend : la préparation et son procédé, les spécifications, contrôles et éléments d''assurance qualité (annexe II parties 1,2,3)', '1.14', NULL, '1.14, 1.18, 4.30, 5.01', NULL, NULL, FALSE, 82),
('Q070', 'Q070', 9, NULL, 'Un dossier de préparation est réalisé pour plusieurs préparations de même composition qualitative quand les procédés de préparation et les méthodes de contrôle sont identiques', '4.31', NULL, '4.31', NULL, NULL, FALSE, 83),
('Q071', 'Q071', 9, NULL, 'Il existe des dossiers de lot (enregistrements)', '4.12', NULL, '4.12, 1.07, LD1.145', NULL, NULL, FALSE, 84),
('Q072', 'Q072', 10, NULL, 'Il existe une (des) procédure(s) relative(s) aux opérations de préparation', '1.05', NULL, '1.05, 4.13, 5.01', NULL, NULL, FALSE, 85),
('Q073', 'Q073', 10, NULL, 'La(les) procédure(s) relative(s) aux opérations de préparation précise(nt) qu''il est nécessaire de', '5.34', NULL, '5.34', NULL, NULL, TRUE, 86),
('Q073.01', 'Q073.01', 10, NULL, 'ne réaliser qu’une seule préparation à la fois, sur une même zone de travail, afin d’éviter les risques d’erreurs et de contaminations croisées', '5.34', NULL, '5.34', NULL, NULL, FALSE, 87),
('Q073.02', 'Q073.02', 10, NULL, 'confier préférentiellement à la même personne qualifiée au sens du CSP la totalité des opérations d’un lot de préparation', '5.34', NULL, '5.34', NULL, NULL, FALSE, 88),
('Q073.03', 'Q073.03', 10, NULL, 'ne pas interrompre cette personne avant la réalisation complète de la préparation', '5.34', NULL, '5.34', NULL, NULL, FALSE, 89),
('Q073.04', 'Q073.04', 10, NULL, 'respecter l’ensemble des procédures et instructions établies par écrit', '5.34', NULL, '5.34', NULL, NULL, FALSE, 90),
('Q073.05', 'Q073.05', 10, NULL, 'consigner par écrit dans le dossier de lot de la préparation toutes les données utiles à la garantie de sa qualité', '5.34', NULL, '5.34', NULL, NULL, FALSE, 91),
('Q073.06', 'Q073.06', 10, NULL, 'd''effectuer les enregistrements au moment où chaque action est réalisée.', '5.34', NULL, '5.34', NULL, NULL, FALSE, 92),
('Q074', 'Q074', 10, NULL, 'La(les) procédure(s) relative(s) aux opérations de préparation permette(nt) de maîtriser et limiter les risques de contamination microbiologique à chaque stade de la préparation', 'LD1.126', NULL, 'LD1.126', NULL, NULL, FALSE, 93),
('Q075', 'Q075', 10, NULL, 'Il existe une procédure de réalisation pour chaque forme pharmaceutique (parentérale, entérale, topique, etc…)', '4.17', NULL, '4.17', NULL, NULL, FALSE, 94),
('Q076', 'Q076', 10, NULL, 'Il existe une (des) procédure(s) relative(s) aux procédés de contrôle', '1.05', NULL, '1.05, 1.07, 4.13', NULL, NULL, FALSE, 95),
('Q077', 'Q077', 10, NULL, 'La (les) procédure(s) relative(s) aux procédés de contrôle précise(nt)', '6.29', NULL, '6.29', NULL, NULL, TRUE, 96),
('Q077.01', 'Q077.01', 10, NULL, 'les procédures d''échantillonnage', '6.29', NULL, '6.29', NULL, NULL, FALSE, 97),
('Q077.02', 'Q077.02', 10, NULL, 'la méthode, le matériel et les spécifications', '6.29', NULL, '6.29', NULL, NULL, FALSE, 98),
('Q077.03', 'Q077.03', 10, NULL, 'les modalités d''enregistrement de ces derniers', '6.29', NULL, '6.29', NULL, NULL, FALSE, 99),
('Q078', 'Q078', 10, NULL, 'La (les) procédure(s) relative(s) aux procédés de contrôle concerne(nt)', '6.03', NULL, '6.03, 6.04', NULL, NULL, FALSE, 100);
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('Q078.01', 'Q078.01', 10, NULL, 'le contrôle à réception (MPUP, articles de conditionnement, préparations sous-traitées, etc.…)', '6.03', NULL, '6.03', NULL, NULL, FALSE, 101),
('Q078.02', 'Q078.02', 10, NULL, 'le contrôle réalisé en cours de préparation', '6.03', NULL, '6.03', NULL, NULL, FALSE, 102),
('Q078.03', 'Q078.03', 10, NULL, 'le contrôle des préparations pharmaceutiques terminées', '6.03', NULL, '6.03', NULL, NULL, FALSE, 103),
('Q078.04', 'Q078.04', 10, NULL, 'le contrôle libératoires des préparations', '6.03', NULL, '6.03', NULL, NULL, FALSE, 104),
('Q078.05', 'Q078.05', 10, NULL, 'le contrôle de la stabilité des préparation et l''absence d''interactions contenant/contenu (le cas échéant)', '6.03', NULL, '6.03', NULL, NULL, FALSE, 105),
('Q078.06', 'Q078.06', 10, NULL, 'les contrôles de recevabilité documentaire (MPUP, réactifs, étalons de référence…)', '6.04', NULL, '6.04', NULL, NULL, FALSE, 106),
('Q078.07', 'Q078.07', 10, NULL, 'les contrôles physico-chimiques', '6.04', NULL, '6.04', NULL, NULL, FALSE, 107),
('Q078.08', 'Q078.08', 10, NULL, 'les contrôles pharmacotechniques', '6.04', NULL, '6.04', NULL, NULL, FALSE, 108),
('Q078.09', 'Q078.09', 10, NULL, 'les contrôles microbiologiques', '6.04', NULL, '6.04', NULL, NULL, FALSE, 109),
('Q078.10', 'Q078.10', 10, NULL, 'les contrôles de radioactivité le cas échéant', '6.04', NULL, '6.04', NULL, NULL, FALSE, 110),
('Q078.11', 'Q078.11', 10, NULL, 'les contrôles de l’environnement (air, surfaces, eau)', '6.04', NULL, '6.04', NULL, NULL, FALSE, 111),
('Q078.12', 'Q078.12', 10, NULL, 'tous autres contrôles jugés nécessaires', '6.04', NULL, '6.04', NULL, NULL, FALSE, 112),
('Q079', 'Q079', 10, NULL, 'Il existe une procédure relative à la gestion des réactifs et des solutions titrées', '6.26', NULL, '6.26', NULL, NULL, FALSE, 113),
('Q080', 'Q080', 10, NULL, 'La procédure relative à la gestion des réactifs et des solutions titrées précise', '6.26', NULL, '6.26', NULL, NULL, TRUE, 114),
('Q080.01', 'Q080.01', 10, NULL, 'leur mode de préparation', '6.26', NULL, '6.26', NULL, NULL, FALSE, 115),
('Q080.02', 'Q080.02', 10, NULL, 'leurs étiquetages', '6.26', NULL, '6.26', NULL, NULL, FALSE, 116),
('Q080.03', 'Q080.03', 10, NULL, 'leurs conditions de conservation', '6.26', NULL, '6.26', NULL, NULL, FALSE, 117),
('Q080.04', 'Q080.04', 10, NULL, 'leur date limite de validité', '6.26', NULL, '6.26', NULL, NULL, FALSE, 118),
('Q080.05', 'Q080.05', 10, NULL, 'la périodicité du recontrôle et le protocole de qualification, le cas échéant', '6.26', NULL, '6.26', NULL, NULL, FALSE, 119),
('Q081', 'Q081', 10, NULL, 'Il existe une procédure décrivant la réalisation d''étude de stabilité microbiologique des préparations, permettant de démontrer le maintien de la qualité microbiologique dans le temps, conformément aux monographies de la Pharmacopée Européenne', '6.84', NULL, '6.84', NULL, NULL, FALSE, 120),
('Q082', 'Q082', 10, NULL, 'Il existe une procédure de faisabilité des préparations', '4.13', NULL, '4.13', NULL, NULL, FALSE, 121),
('Q083', 'Q083', 10, NULL, 'La procédure de faisabilité des préparations précise qu''une préparation n’est entreprise que si la pharmacie possède les moyens appropriés spécifiques (équipements, matériels, personnels, locaux…) pour la réaliser et la contrôler.', '5.02', NULL, '5.02', NULL, NULL, FALSE, 122),
('Q084', 'Q084', 10, NULL, 'La procédure de faisabilité des préparations est complétée par une check-list formalisée qui explicitement la disponibilité des équipements, du personnel formé et des locaux adaptés', '5.02', NULL, '5.02', NULL, NULL, FALSE, 123),
('Q085', 'Q085', 10, NULL, 'Il existe une (des) procédure(s) relative(s) à la libération des préparations adaptées à la nature des préparations réalisées.', '1.05', NULL, '1.05, 4.24, LD1.145', NULL, NULL, FALSE, 124),
('Q086', 'Q086', 10, NULL, 'La (les) procédure(s) de libération pharmaceutique des préparations terminées prévoit une mise en quarantaine physique et informatique le cas échéant, immédiatement après leur préparations', '5.08', NULL, '5.08', NULL, NULL, FALSE, 125),
('Q087', 'Q087', 10, NULL, 'Il existe une procédure d''étiquetage des préparations terminées conforme à la réglementation en vigueur', '4.13', NULL, '4.13, 4.34', NULL, NULL, FALSE, 126),
('Q088', 'Q088', 10, NULL, 'Il existe une procédure pour la réalisation des préparations en urgence', '1.22', NULL, '1.22', NULL, NULL, FALSE, 127),
('Q089', 'Q089', 10, NULL, 'La procédure pour la réalisation des préparations en urgence précise', '1.22', NULL, '1.22', NULL, NULL, TRUE, 128),
('Q089.01', 'Q089.01', 10, NULL, 'qu’une fiche d’instruction de préparation doit être réalisée', '1.22', NULL, '1.22', NULL, NULL, FALSE, 129),
('Q089.02', 'Q089.02', 10, NULL, 'que les éléments du dossier de préparation sont complétés a posteriori', '1.22', NULL, '1.22', NULL, NULL, FALSE, 130),
('Q089.03', 'Q089.03', 10, NULL, 'que dans tous les cas, un dossier de lot accompagne la préparation.', '1.22', NULL, '1.22', NULL, NULL, FALSE, 131),
('Q090', 'Q090', 10, NULL, 'Il existe une procédure de réattribution des préparations', '5.64', NULL, '5.64', NULL, NULL, FALSE, 132),
('Q091', 'Q091', 10, NULL, 'Il existe une procédure de réception des MPUP et des articles de conditionnement', '4.13', NULL, '4.13, 4.14', NULL, NULL, FALSE, 133),
('Q092', 'Q092', 10, NULL, 'La procédure de réception des MPUP et articles de conditionnement précise', '4.14', NULL, '4.14, 4.15, 4.18, 4.24, 4.43, 5.08, 6.03, 6.32, 6.31, LD2.057', NULL, NULL, TRUE, 134),
('Q092.01', 'Q092.01', 10, NULL, 'les contrôles à effectuer à réception des MPUP et des articles de conditionnement', '4.15', NULL, '4.15, 4.18, 6.03', NULL, NULL, FALSE, 135),
('Q092.02', 'Q092.02', 10, NULL, 'qu''il existe un registre de réception et de contrôle des MPUP et des articles de conditionnements', '4.14', NULL, '4.14, 4.43, 6.32', NULL, NULL, FALSE, 136),
('Q092.03', 'Q092.03', 10, NULL, 'qu''il existe un enregistrement de chaque réception des MPUP et des articles de conditionnements', '4.14', NULL, '4.14, 4.43, 6.32', NULL, NULL, FALSE, 137),
('Q092.04', 'Q092.04', 10, NULL, 'qu''il existe un enregistrement de chaque contrôle des MPUP et des articles de conditionnements', '4.14', NULL, '4.14, 4.43', NULL, NULL, FALSE, 138),
('Q092.05', 'Q092.05', 10, NULL, 'la conduite à tenir en cas de réception d''emballages endommagés', 'LD2.057', NULL, 'LD2.057', NULL, NULL, FALSE, 139),
('Q092.06', 'Q092.06', 10, NULL, 'les modalités d''étiquetage interne des MPUP à réception', '6.31', NULL, '6.31', NULL, NULL, FALSE, 140),
('Q092.07', 'Q092.07', 10, NULL, 'les modalités de mise en quarantaine physique et informatique des MPUP, des articles de conditionnement et des autres produits', '4.15', NULL, '4.15', NULL, NULL, FALSE, 141),
('Q092.08', 'Q092.08', 10, NULL, 'les modalités de libération, physique et informatique, des MPUP et des articles de conditionnement', '4.24', NULL, '4.24', NULL, NULL, FALSE, 142),
('Q092.09', 'Q092.09', 10, NULL, 'les critères d''acceptation ou de refus objectivables lors de leur libération', '5.08', NULL, '5.08', NULL, NULL, FALSE, 143),
('Q093', 'Q093', 10, NULL, 'La procédure de contrôle à réception des MPUP/articles de conditionnement précise', '4.18', NULL, '4.18, 4.43, 5.28, 6.30, 6.31', NULL, NULL, TRUE, 144),
('Q093.01', 'Q093.01', 10, NULL, 'la vérification administrative de conformité de réception par rapport à la commande', '6.30', NULL, '6.30', NULL, NULL, FALSE, 145),
('Q093.02', 'Q093.02', 10, NULL, 'qu''un certificat d''analyse doit être détenu pour chaque lot de MPUP réceptionné (excepté pour les spécialités pharmaceutiques et solvants commercialisés) et qu''il est demandé expressément au fournisseur en cas d''absence lors de la réception initiale du lot', '4.43', NULL, '4.43, 6.31', NULL, NULL, FALSE, 146),
('Q093.02.01', 'Q093.02.01', 10, NULL, 'le certificat est signé par le fournisseur', '6.31', NULL, '6.31', NULL, NULL, FALSE, 147),
('Q093.02.02', 'Q093.02.02', 10, NULL, 'le certificat mentionne les nom et adresse du fabricant d''origine', '6.31', NULL, '6.31', NULL, NULL, FALSE, 148),
('Q093.02.03', 'Q093.02.03', 10, NULL, 'le certificat mentionne le référentiel des contrôles effectués', '6.31', NULL, '6.31', NULL, NULL, FALSE, 149),
('Q093.03', 'Q093.03', 10, NULL, 'le référentiel utilisé', '6.30', NULL, '6.30', NULL, NULL, FALSE, 150),
('Q093.04', 'Q093.04', 10, NULL, 'la (les) technique(s) et la (les) méthode(s) de contrôle utilisées', '6.30', NULL, '6.30, 5.28', NULL, NULL, FALSE, 151),
('Q093.05', 'Q093.05', 10, NULL, 'l’équipement analytique, le matériel, les réactifs et les substances de référence utilisés', '6.30', NULL, '6.30, 4.18', NULL, NULL, FALSE, 152),
('Q093.06', 'Q093.06', 10, NULL, 'le mode opératoire', '6.30', NULL, '6.30', NULL, NULL, FALSE, 153),
('Q093.07', 'Q093.07', 10, NULL, 'la procédure d’échantillonnage utilisée', '6.30', NULL, '6.30', NULL, NULL, FALSE, 154),
('Q093.08', 'Q093.08', 10, NULL, 'le nombre d’essais réalisés', '6.30', NULL, '6.30', NULL, NULL, FALSE, 155),
('Q093.09', 'Q093.09', 10, NULL, 'les spécifications attendues', '6.30', NULL, '6.30, 4.18', NULL, NULL, FALSE, 156),
('Q093.09.01', 'Q093.09.01', 10, NULL, 'examen visuel, contrôles analytiques donnant lieu à des résultats chiffrés', '6.30', NULL, '6.30', NULL, NULL, FALSE, 157),
('Q093.09.02', 'Q093.09.02', 10, NULL, 'contrôles analytiques donnant lieu à des résultats chiffrés', '6.30', NULL, '6.30', NULL, NULL, FALSE, 158),
('Q093.10', 'Q093.10', 10, NULL, 'le format du rendu de résultats (certificat d’analyse, fiche de contrôle,…)', '6.30', NULL, '6.30', NULL, NULL, FALSE, 159),
('Q093.11', 'Q093.11', 10, NULL, 'le format de l’archivage des résultats (enregistrements)', '6.30', NULL, '6.30', NULL, NULL, FALSE, 160),
('Q094', 'Q094', 10, NULL, 'Il existe une procédure d''échantillonnage des MPUP, des articles de conditionnement et des préparations terminées', '4.13', NULL, '4.13, 4.16', NULL, NULL, FALSE, 161),
('Q095', 'Q095', 10, NULL, 'La procédure d''échantillonage des préparations précise la quantité minimale conservée pour réaliser au moins l’analyse complète décrite dans la procédure de contrôle. En cas d''exception, celle-ci est justifiée', '6.64', NULL, '6.64', NULL, NULL, FALSE, 162),
('Q096', 'Q096', 10, NULL, 'La procédure d''échantillonnage (des MPUP, articles de conditionnement et des préparations terminées)', '4.16', NULL, '4.16, 6.02', NULL, NULL, TRUE, 163),
('Q096.01', 'Q096.01', 10, NULL, 'indique la ou les personne(s) autorisée(s) à prélever des échantillons', '4.16', NULL, '4.16', NULL, NULL, FALSE, 164),
('Q096.02', 'Q096.02', 10, NULL, 'détaille la méthode et le matériel à utiliser', '4.16', NULL, '4.16', NULL, NULL, FALSE, 165),
('Q096.03', 'Q096.03', 10, NULL, 'précise les quantités à prélever', '4.16', NULL, '4.16', NULL, NULL, FALSE, 166),
('Q096.04', 'Q096.04', 10, NULL, 'précise les précautions de manipulation pour la sécurité des personnes et de l’environnement', '4.16', NULL, '4.16', NULL, NULL, FALSE, 167),
('Q096.05', 'Q096.05', 10, NULL, 'précise les précautions de manipulation pour eviter la contamination du produit ou la détérioration de sa qualité', '4.16', NULL, '4.16', NULL, NULL, FALSE, 168),
('Q096.06', 'Q096.06', 10, NULL, 'précise les contrôles qualité sur l''échantillonnage, leurs spécifications et leur analyse', '6.02', NULL, '6.02', NULL, NULL, FALSE, 169),
('Q097', 'Q097', 10, NULL, 'Il existe une procédure de gestion de l''échantillothèque', '6.67', NULL, '6.67', NULL, NULL, FALSE, 170),
('Q098', 'Q098', 10, NULL, 'Il existe un registre manuel ou informatisé de la gestion de l''échantillothèque', '6.67', NULL, '6.67', NULL, NULL, FALSE, 171),
('Q099', 'Q099', 10, NULL, 'Le registre de gestion de l''échantillothèque trace les entrées/sorties avec notification de leur utilisation en cas de sortie', '6.67', NULL, '6.67', NULL, NULL, FALSE, 172),
('Q100', 'Q100', 10, NULL, 'Il existe une procédure de gestion de stock', '4.13', NULL, '4.13', NULL, NULL, FALSE, 173),
('Q101', 'Q101', 10, NULL, 'La procédure de gestion de stock définit les conditions de stockage et de rotation des stocks des MPUP et des articles de conditionnement', '5.10', NULL, '5.10', NULL, NULL, FALSE, 174),
('Q102', 'Q102', 10, NULL, 'La procédure de gestion de stock précise qu''(que)', 'LD1.130', NULL, 'LD1.130, LD1.132', NULL, NULL, TRUE, 175),
('Q102.01', 'Q102.01', 10, NULL, 'en cas de ZAC de classe A et B, l''entreposage est limité au stric minimum', 'LD1.130', NULL, 'LD1.130', NULL, NULL, FALSE, 176),
('Q102.02', 'Q102.02', 10, NULL, 'en cas de ZAC de classe C et D, l''entreposage est limité', 'LD1.130', NULL, 'LD1.130', NULL, NULL, FALSE, 177),
('Q102.03', 'Q102.03', 10, NULL, 'les récipients et produits susceptibles de libérer des particules (cartons,,) ne sont pas introduits en ZAC, dans la mesure du possible.', 'LD1.132', NULL, 'LD1.132', NULL, NULL, FALSE, 178),
('Q103', 'Q103', 10, NULL, 'Des procédures et modes opératoires validés décrivent les différents flux (MPUP, déchets, préparations terminées, personnel) intervenant dans la réalisation des préparations stériles.', 'LD1.128', NULL, 'LD1.128', NULL, NULL, FALSE, 179),
('Q104', 'Q104', 10, NULL, 'Il existe une (des) procédure(s) relative(s) à la conservation des préparations', '1.05', NULL, '1.05', NULL, NULL, FALSE, 180),
('Q105', 'Q105', 10, NULL, 'Il existe une procédure d''analyse des prescriptions', '4.13', NULL, '4.13', NULL, NULL, FALSE, 181),
('Q106', 'Q106', 10, NULL, 'Il existe une (des) procédure(s) relative(s) à l''accès aux locaux', '4.19', NULL, '4.19', NULL, NULL, FALSE, 182),
('Q107', 'Q107', 10, NULL, 'La procédure d''accès aux locaux précise leurs conditions d''accès en fonction', '4.19', NULL, '4.19', NULL, NULL, TRUE, 183),
('Q107.01', 'Q107.01', 10, NULL, 'de la classe de propreté ISO', '4.19', NULL, '4.19', NULL, NULL, FALSE, 184),
('Q107.02', 'Q107.02', 10, NULL, 'de la nature des préparations réalisées', '4.19', NULL, '4.19', NULL, NULL, FALSE, 185),
('Q108', 'Q108', 10, NULL, 'La procédure d''accès au locaux prend en compte la limitation des effectifs dans les zones et la maitrise des déplacements du personnel (flux)', 'LD1.105', NULL, 'LD1.105', NULL, NULL, FALSE, 186),
('Q109', 'Q109', 10, NULL, 'Il existe une (des) procédure(s) relative(s) aux opérations de qualification des locaux et des équipements', '4.21', NULL, '4.21, LD1.035', NULL, NULL, FALSE, 187),
('Q110', 'Q110', 10, NULL, 'La (les) procédure(s) relative(s) aux opérations de qualification des locaux et des équipements prévoit une qualification d''installation (QI), une qualification opérationnelle (QO), une qualification de performance (QP) précédées d''une qualification de conception (QC)', '3.45', NULL, '3.45, 3.46', NULL, NULL, FALSE, 188),
('Q111', 'Q111', 10, NULL, 'La (les) prodédures relative(s) aux opérations de qualification des locaux et des équipements détaille(nt)', 'LD1.096', NULL, 'LD1.096', NULL, NULL, TRUE, 189),
('Q111.01', 'Q111.01', 10, NULL, 'les étapes de QC QI QO QP', 'LD1.096', NULL, 'LD1.096', NULL, NULL, FALSE, 190),
('Q111.02', 'Q111.02', 10, NULL, 'les tests à réaliser lors des qualifications/requalifications des ZAC et équipements', 'LD1.096', NULL, 'LD1.096', NULL, NULL, FALSE, 191),
('Q111.03', 'Q111.03', 10, NULL, 'leurs fréquences qui sont adaptés à l''activité réelle du site', 'LD1.096', NULL, 'LD1.096', NULL, NULL, FALSE, 192),
('Q112', 'Q112', 10, NULL, 'Il existe des procédures relatives à l''utilisation des matériels et des équipements', '4.20', NULL, '4.20', NULL, NULL, FALSE, 193),
('Q113', 'Q113', 10, NULL, 'Les procédures relatives à l''utilisation des matériels et des équipements prennent en compte', '4.20', NULL, '4.20', NULL, NULL, TRUE, 194),
('Q113.01', 'Q113.01', 10, NULL, 'leur entretien', '4.20', NULL, '4.20', NULL, NULL, FALSE, 195),
('Q113.02', 'Q113.02', 10, NULL, 'leur étalonnage', '4.20', NULL, '4.20', NULL, NULL, FALSE, 196),
('Q113.03', 'Q113.03', 10, NULL, 'leur maintenance', '4.20', NULL, '4.20', NULL, NULL, FALSE, 197),
('Q114', 'Q114', 10, NULL, 'Les résultats des opérations de qualification sont utilisés pour valider les procédés de préparation et de contrôle.', '4.21', NULL, '4.21', NULL, NULL, FALSE, 198),
('Q115', 'Q115', 10, NULL, 'Il existe une (des) procédure(s) relative(s) à la maintenance des locaux et des équipements', '4.19', NULL, '4.19, LD1.035', NULL, NULL, FALSE, 199),
('Q116', 'Q116', 10, NULL, 'La (les) procédure(s) de maintenance des locaux et des équipements prend en compte', '4.19', NULL, '4.19', NULL, NULL, TRUE, 200);
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('Q116.01', 'Q116.01', 10, NULL, 'la classe de propreté ISO', '4.19', NULL, '4.19', NULL, NULL, FALSE, 201),
('Q116.02', 'Q116.02', 10, NULL, 'la nature des préparations réalisées', '4.19', NULL, '4.19', NULL, NULL, FALSE, 202),
('Q117', 'Q117', 10, NULL, 'La (les) procédure(s) de maintenance des locaux et des équipements prévoit a minima 1 fois/an une qualification (essais de laminarité, vitesse, débit et intégrité des filtres)', 'LD1.158', NULL, 'LD1.158', NULL, NULL, FALSE, 203),
('Q118', 'Q118', 10, NULL, 'Il existe de une procédure de gestion des matériels défecteux au sein de l''ES : évacuation de la zone ou interdiction d''utilisation', '3.43', NULL, '3.43', NULL, NULL, FALSE, 204),
('Q119', 'Q119', 10, NULL, 'Il existe une procédure de surveillance de l’environnement', '4.13', NULL, '4.13, 4.19, LD1.085', NULL, NULL, FALSE, 205),
('Q120', 'Q120', 10, NULL, 'La procédure de surveillance de l’environnement prend en compte', '4.19', NULL, '4.19', NULL, NULL, TRUE, 206),
('Q120.01', 'Q120.01', 10, NULL, 'la classe de propreté ISO', '4.19', NULL, '4.19', NULL, NULL, FALSE, 207),
('Q120.02', 'Q120.02', 10, NULL, 'la nature des préparations réalisées', '4.19', NULL, '4.19', NULL, NULL, FALSE, 208),
('Q121', 'Q121', 10, NULL, 'La procédure de surveillance de l’environnement précise le plan d''échantillonnage qui tient compte', 'LD1.150', NULL, 'LD1.150', NULL, NULL, TRUE, 209),
('Q121.01', 'Q121.01', 10, NULL, 'd’une analyse de risques', 'LD1.150', NULL, 'LD1.150', NULL, NULL, FALSE, 210),
('Q121.02', 'Q121.02', 10, NULL, 'des normes ISO en vigueur et définit notamment les lieux, la fréquence et le nombre de prélèvements.', 'LD1.150', NULL, 'LD1.150', NULL, NULL, FALSE, 211),
('Q121.03', 'Q121.03', 10, NULL, 'la fréquence et le nombre de prélèvements.', 'LD1.150', NULL, 'LD1.150', NULL, NULL, FALSE, 212),
('Q122', 'Q122', 10, NULL, 'Les fréquences minimum de surveillance microbiologique des ZAC tiennent compte des recommandations décrites dans le tableau 10 (LD1) et sont respectées sauf analyse de risque', 'LD1.155', NULL, 'LD1.155', NULL, NULL, FALSE, 213),
('Q123', 'Q123', 10, NULL, 'La procédure de surveillance de l’environnement précise', 'LD1.147', NULL, 'LD1.147', NULL, NULL, TRUE, 214),
('Q123.01', 'Q123.01', 10, NULL, 'les seuils d''alerte pour la surveillance particulaire', 'LD1.147', NULL, 'LD1.147', NULL, NULL, FALSE, 215),
('Q123.02', 'Q123.02', 10, NULL, 'les seuils d''alerte pour la surveillance microbiologique', 'LD1.147', NULL, 'LD1.147', NULL, NULL, FALSE, 216),
('Q123.03', 'Q123.03', 10, NULL, 'les seuils d''action pour la surveillance particulaire', 'LD1.147', NULL, 'LD1.147', NULL, NULL, FALSE, 217),
('Q123.04', 'Q123.04', 10, NULL, 'les seuils d''action pour la surveillance microbiologique', 'LD1.147', NULL, 'LD1.147', NULL, NULL, FALSE, 218),
('Q124', 'Q124', 10, NULL, 'Les limites de surveillance microbiologique des ZAC tiennent compte des recommandations décrites dans le tableau 9 (LD1) et sont respectées sauf analyse de risque', 'LD1.154', NULL, 'LD1.154', NULL, NULL, FALSE, 219),
('Q125', 'Q125', 10, NULL, 'Les seuils d''alerte & d''action tiennent compte de la nature du germe et du risque de dissémination associé (ex. champignon filamenteux).', 'LD1.148', NULL, 'LD1.148', NULL, NULL, FALSE, 220),
('Q126', 'Q126', 10, NULL, 'La procédure de surveillance de l’environnement précise les surveillances microbiologiques supplémentaires à réaliser en dehors des phases de préparation lorsque pertinent (ex : après validation, maintenance, nettoyage, désinfection).', 'LD1.153', NULL, 'LD1.153', NULL, NULL, FALSE, 221),
('Q127', 'Q127', 10, NULL, 'Il existe une procédure de surveillance (paramètres fonctionnels) des locaux et des équipements', 'LD1.095', NULL, 'LD1.095', NULL, NULL, FALSE, 222),
('Q128', 'Q128', 10, NULL, 'La procédure de surveillance (paramètres fonctionnels) des locaux et des équipements tient compte de la liste des éléments à surveiller (LD1 tableau 11) (référentiel indicatif, adapté si besoin au contexte local)', 'LD1.095', NULL, 'LD1.095, LD1.160', NULL, NULL, FALSE, 223),
('Q129', 'Q129', 10, NULL, 'Il existe une (des) procédure(s) relative(s) à l''entretien des locaux et des équipements', '4.13', NULL, '4.13, 3.39, LD1.083', NULL, NULL, FALSE, 224),
('Q130', 'Q130', 10, NULL, 'La procédure relative à l''entretien des locaux et des équipements prend en compte', '4.19', NULL, '4.19', NULL, NULL, TRUE, 225),
('Q130.01', 'Q130.01', 10, NULL, 'la classe de propreté ISO', '4.19', NULL, '4.19', NULL, NULL, FALSE, 226),
('Q130.02', 'Q130.02', 10, NULL, 'la nature des préparations réalisées', '4.19', NULL, '4.19', NULL, NULL, FALSE, 227),
('Q131', 'Q131', 10, NULL, 'La procédure relative à l''entretien des locaux et des équipements', '3.21', NULL, '3.21, 3.23, LD2.022, 3.06, LD1.098, LD1.088, LD1.086, LD1.089', NULL, NULL, TRUE, 228),
('Q131.01', 'Q131.01', 10, NULL, 'précise le planning d''entretien des locaux et le circuit, en prenant compte les risques de contamination. Ce planning est partagé avec le PRP qui en valide aussi le circuit', '3.21', NULL, '3.21', NULL, NULL, FALSE, 229),
('Q131.02', 'Q131.02', 10, NULL, 'précise les opérations de nettoyage, décontamination et désinfection des locaux ou zones, des équipements et des matériels utilisés en cas de production par campagne', '3.23', NULL, '3.23, LD2.022', NULL, NULL, FALSE, 230),
('Q131.03', 'Q131.03', 10, NULL, 'permet de minimiser les risques d’erreur et de contact avec des impuretés, tels que les contaminations croisées ainsi que les accumulations de poussières et de saletés.', '3.06', NULL, '3.06', NULL, NULL, FALSE, 231),
('Q131.04', 'Q131.04', 10, NULL, 'précise les conduites à tenir lorsque, les conditions de propreté n’ont pas pu être maintenues lors d''opérations d’entretien de matériels effectué au sein de la ZAC', 'LD1.098', NULL, 'LD1.098', NULL, NULL, FALSE, 232),
('Q131.05', 'Q131.05', 10, NULL, 'précise que l''utilisation de la solution détergente qui permet le nettoyage doit être associée à une solution de désinfection (surfaces internes des équipements de classe A)', 'LD1.088', NULL, 'LD1.088', NULL, NULL, FALSE, 233),
('Q131.06', 'Q131.06', 10, NULL, 'définit la fréquence de nettoyage/désinfection données à titre indicatif et à adapter à l’activité de production (LD1 tableau 2)', 'LD1.086', NULL, 'LD1.086', NULL, NULL, FALSE, 234),
('Q131.07', 'Q131.07', 10, NULL, 'définit la fréquence des opérations de nettoyage / désinfection (surfaces internes des équipements de classe A) (LD1 tableau 3)', 'LD1.088', NULL, 'LD1.088', NULL, NULL, FALSE, 235),
('Q131.08', 'Q131.08', 10, NULL, 'précise que les opérations de nettoyage/désinfection de(s) équipements de classe A sont réalisées par le personnel effectuant lui-même les opérations de préparation.', 'LD1.089', NULL, 'LD1.089', NULL, NULL, FALSE, 236),
('Q132', 'Q132', 10, NULL, 'Il existe une procédure relative à la gestion des déchets', '4.19', NULL, '4.19, LD2.057', NULL, NULL, FALSE, 237),
('Q133', 'Q133', 10, NULL, 'La procédure relative à la gestion des déchets prend en compte', '4.19', NULL, '4.19', NULL, NULL, TRUE, 238),
('Q133.01', 'Q133.01', 10, NULL, 'la classe de propreté ISO', '4.19', NULL, '4.19', NULL, NULL, FALSE, 239),
('Q133.02', 'Q133.02', 10, NULL, 'la nature des préparations réalisées', '4.19', NULL, '4.19', NULL, NULL, FALSE, 240),
('Q134', 'Q134', 10, NULL, 'La procédure relative à la gestion des déchets précise les filières d’élimination selon leur dangerosité', '3.24', NULL, '3.24', NULL, NULL, FALSE, 241),
('Q135', 'Q135', 10, NULL, 'La procédure relative à la gestion des déchets, prévoit leur durée maximale de stockage et le volume maximal selon la réglementation en vigueur', 'LD2.056', NULL, 'LD2.056', NULL, NULL, FALSE, 242),
('Q136', 'Q136', 10, NULL, 'Il existe une procédure de formation initiale (avec habillitation) et continue du personnel', '4.23', NULL, '4.23', NULL, NULL, FALSE, 243),
('Q137', 'Q137', 10, NULL, 'La procédure de formation initiale (avec habillitation) et continue du personnel précise les modalités de réhabilitation après une absence prolongée', '4.23', NULL, '4.23', NULL, NULL, FALSE, 244),
('Q138', 'Q138', 10, NULL, 'Il existe une procédure relative à l''habillage du personnel', '2.18', NULL, '2.18, 4.13, 4.23', NULL, NULL, FALSE, 245),
('Q139', 'Q139', 10, NULL, 'Il existe un affichage synthétique de l''habillage conforme à l''entrée des locaux (ZAC)', '4.23', NULL, '4.23', NULL, NULL, FALSE, 246),
('Q140', 'Q140', 10, NULL, 'Il existe une procédure relative à l''hygiène du personnel', '2.18', NULL, '2.18, 4.23', NULL, NULL, FALSE, 247),
('Q141', 'Q141', 10, NULL, 'Il existe d''instructions précises sur la technique de lavage des mains dans la procédure relative à l''hygiène du personnel', 'LD1.114', NULL, 'LD1.114', NULL, NULL, FALSE, 248),
('Q142', 'Q142', 10, NULL, 'Les procédures d''habillage et de lavage des mains sont conçues pour limiter la contamination des vêtements propres et l''introduction de contaminants en zone propre.', 'LD1.114', NULL, 'LD1.114', NULL, NULL, FALSE, 249),
('Q143', 'Q143', 10, NULL, 'Il existe une procédure relative à la protection du personnel (mesures de protection et de sécurité)', '4.23', NULL, '4.23, LD2.057', NULL, NULL, FALSE, 250),
('Q144', 'Q144', 10, NULL, 'Dans le cadre des procédures relatives à l''habillage du personnel, à l''hygiène et à la protection du personnel, la fréquence de changement des gants stériles est définie en fonction de l’activité et du type de MPUP manipulée', 'LD1.115', NULL, 'LD1.115', NULL, NULL, FALSE, 251),
('Q145', 'Q145', 10, NULL, 'Les procédures relatives à l''habillage du personnel, à la protection et à l''hygiène précisent les instructions, pour les personnes étrangères à la PUI, autorisées par le PRP ou le  pharmacien gérant, dans les zones de préparation, de contrôle et de stockage en fonction des travaux à effectuer.', '2.19', NULL, '2.19', NULL, NULL, FALSE, 252),
('Q146', 'Q146', 10, NULL, 'Dans le cadre des procédures relatives à l''habillage du personnel, à l''hygiène et à la protection du personnel, la fréquence de changement des gants stériles est définie en fonction de l’activité et du type de MPUP manipulée', 'LD1.115', NULL, 'LD1.115', NULL, NULL, FALSE, 253),
('Q147', 'Q147', 10, NULL, 'Les procédures relatives à l''habillage du personnel, à la protection et à l''hygiène précisent les instructions, pour les personnes étrangères à la PUI, autorisées par le PRP ou le  pharmacien gérant, dans les zones de préparation, de contrôle et de stockage en fonction des travaux à effectuer.', '2.19', NULL, '2.19', NULL, NULL, FALSE, 254),
('Q148', 'Q148', 10, NULL, 'Dans le cadre des procédures relatives à l''habillage du personnel, à l''hygiène et à la protection du personnel, la fréquence de changement des gants stériles est définie en fonction de l’activité et du type de MPUP manipulée', 'LD1.115', NULL, 'LD1.115', NULL, NULL, FALSE, 255),
('Q149', 'Q149', 10, NULL, 'Les procédures relatives à l''habillage du personnel, à la protection et à l''hygiène précisent les instructions, pour les personnes étrangères à la PUI, autorisées par le PRP ou le  pharmacien gérant, dans les zones de préparation, de contrôle et de stockage en fonction des travaux à effectuer.', '2.19', NULL, '2.19', NULL, NULL, FALSE, 256),
('Q150', 'Q150', 10, NULL, 'Il existe une procédure sur la conduite à tenir en cas d''incident en cours de préparation (bris ou déversement accidentel)', 'LD2.057', NULL, 'LD2.057', NULL, NULL, FALSE, 257),
('Q151', 'Q151', 10, NULL, 'La procédure sur la conduite à tenir en cas d''incident en cours de préparation (bris ou déversement accidentel)  précise les les éléments devant être transmis au médecin du travail', 'LD2.057', NULL, 'LD2.057', NULL, NULL, FALSE, 258),
('Q152', 'Q152', 10, NULL, 'Il existe une procédure sur la conduite à tenir en cas conduite à tenir en cas d’incident ou de défaillance d’un dispositif, d’un équipement etc.', 'LD2.057', NULL, 'LD2.057', NULL, NULL, FALSE, 259),
('Q153', 'Q153', 10, NULL, 'Il existe une procédure de gestion des anomalies et des réclamations', '4.25', NULL, '4.25, 8.01', NULL, NULL, FALSE, 260),
('Q154', 'Q154', 10, NULL, 'Il existe une procédure pour le recueil et la déclaration des effets indésirables graves dus aux préparations pharmaceutiques.', '4.27', NULL, '4.27', NULL, NULL, FALSE, 261),
('Q155', 'Q155', 10, NULL, 'La procédure pour le recueil et la déclaration des effets indésirables graves dus aux préparations pharmaceutiques prévoit leur signalement aux autorités compétentes', '4.27', NULL, '4.27', NULL, NULL, FALSE, 262),
('Q156', 'Q156', 10, NULL, 'La procédure pour le recueil et la déclaration des effets indésirables graves dus aux préparations pharmaceutiques prévoit pour le signalement', '4.28', NULL, '4.28', NULL, NULL, TRUE, 263),
('Q156.01', 'Q156.01', 10, NULL, 'des élements permettant d''étayer les évènements survenus', '4.28', NULL, '4.28', NULL, NULL, FALSE, 264),
('Q156.02', 'Q156.02', 10, NULL, 'des circonstances d''apparition', '4.28', NULL, '4.28', NULL, NULL, FALSE, 265),
('Q156.03', 'Q156.03', 10, NULL, 'du numéro de lot de la préparation concernée', '4.28', NULL, '4.28', NULL, NULL, FALSE, 266),
('Q157', 'Q157', 10, NULL, 'Les déclarations de pharmacovigilance s''effectuent selon la réglementation en vigueur', '4.29', NULL, '4.29', NULL, NULL, FALSE, 267),
('Q158', 'Q158', 10, NULL, 'La préparation litigieuse est conservée', '4.29', NULL, '4.29', NULL, NULL, FALSE, 268),
('Q159', 'Q159', 10, NULL, 'Il existe une procédure pour le rappel rapide et exhaustif des préparations', '8.02', NULL, '8.02, 8.04, 8.08, 4.26', NULL, NULL, FALSE, 269),
('Q160', 'Q160', 10, NULL, 'La procédure de rappel des préparations prévoit que, lorsqu’un défaut susceptible de porter atteinte à la santé est constaté, il exisite une chaine hiérarchique identifiée de déclaration (Pharmacien gérant, direction générale)', '8.09', NULL, '8.09', NULL, NULL, FALSE, 270),
('Q161', 'Q161', 10, NULL, 'La procédure de rappel des préparations prévoit que, dans le cas d''une sous-traitance, le donneur d''ordre est informé du rappel des préparations et les données de traçabilité lui sont fournies', '8.10', NULL, '8.10', NULL, NULL, FALSE, 271),
('Q162', 'Q162', 10, NULL, 'La procédure de rappel des préparations prévoit que les préparations rappellées sont mises en quarantaine', '8.11', NULL, '8.11', NULL, NULL, FALSE, 272),
('Q163', 'Q163', 10, NULL, 'Il existe une procédure de déclaration/documentation relative aux écarts de qualité des produits', '4.05', NULL, '4.05', NULL, NULL, FALSE, 273),
('Q164', 'Q164', 10, NULL, 'Il existe une procédure d''analyse de risque', '4.05', NULL, '4.05', NULL, NULL, FALSE, 274),
('Q165', 'Q165', 10, NULL, 'Il existe une procédure de maitrise du changement', '5.24', NULL, '5.24', NULL, NULL, FALSE, 275),
('Q166', 'Q166', 10, NULL, 'Il existe une procédure d''auto-inspection accompagnée d''une grille d''évaluation', '9.01', NULL, '9.01', NULL, NULL, FALSE, 276),
('Q167', 'Q167', 11, NULL, 'Chaque matériel, équipement et zones critiques (ex : postes à flux d’air unidirectionnel, isolateurs, balances, dispositifs de traitement d''eau et d’air) est accompagné d''un "cahier de suivi" (gmao ou papier)  qui mentionne', '4.22', NULL, '4.22', NULL, NULL, TRUE, 277),
('Q167.01', 'Q167.01', 11, NULL, 'les validations', '4.22', NULL, '4.22', NULL, NULL, FALSE, 278),
('Q167.02', 'Q167.02', 11, NULL, 'les étalonnages', '4.22', NULL, '4.22', NULL, NULL, FALSE, 279),
('Q167.03', 'Q167.03', 11, NULL, 'les opérations d''entretien', '4.22', NULL, '4.22', NULL, NULL, FALSE, 280),
('Q167.04', 'Q167.04', 11, NULL, 'les opérations de nettoyage', '4.22', NULL, '4.22', NULL, NULL, FALSE, 281),
('Q167.05', 'Q167.05', 11, NULL, 'les opérations de qualification', '4.22', NULL, '4.22', NULL, NULL, FALSE, 282),
('Q167.06', 'Q167.06', 11, NULL, 'les opérations de maintenance', '4.22', NULL, '4.22', NULL, NULL, FALSE, 283),
('Q168', 'Q168', 11, NULL, 'Pour chaque opération, est portée mention de la date, du nom des personnes ayant effectué ces opérations et du nom de la societé en cas d’intervention extérieure.', '4.22', NULL, '4.22, 3.40', NULL, NULL, FALSE, 284),
('Q169', 'Q169', 11, NULL, 'Pour chaque opération est portée mention des actions correctives réalisées', '4.22', NULL, '4.22', NULL, NULL, FALSE, 285),
('Q170', 'Q170', 11, NULL, 'Le cahier de suivi de chaque matériel, équipement et zone critique est à jour.', '4.22', NULL, '4.22', NULL, NULL, FALSE, 286),
('Q171', 'Q171', 11, NULL, 'Le(s) certificat(s) de qualification des matériels, équipements et zone critique est (sont) conservé(s)s pendant toute la durée de vie de l''équipement', '3.44', NULL, '3.44', NULL, NULL, FALSE, 287),
('Q172', 'Q172', 11, NULL, 'Le(s) certificat(s) de qualification des matériels, équipements et zones critiques est (sont)  archivé(s) dans un emplacement unique, et retrouvable(s) en moins de 5 minutes lors d''un contrôle', '3.44', NULL, '3.44', NULL, NULL, FALSE, 288),
('Q173', 'Q173', 11, NULL, 'Les opérations d''entrée/sortie de matériel dans le flux d''air unidirectionnel font l''objet de procédures validées et appliquées, ces opérations étant identifiées comme sources critiques de contamination.', 'LD1.063', NULL, 'LD1.063', NULL, NULL, FALSE, 289),
('Q174', 'Q174', 11, NULL, 'Les opérations d''entrée/sortie de matériel dans un isolateur font l''objet de procédures validées et appliquées, ces opérations étant identifiées comme sources critiques de contamination.', 'LD1.074', NULL, 'LD1.074', NULL, NULL, FALSE, 290),
('Q175', 'Q175', 11, NULL, 'Chaque équipement utilisé pour le contrôle possède un "cahier de suivi" (gmao ou papier) qui contient', '6.21', NULL, '6.21', NULL, NULL, TRUE, 291),
('Q175.01', 'Q175.01', 11, NULL, 'une procédure technique générale décrivant le fonctionnement des appareils', '6.21', NULL, '6.21', NULL, NULL, FALSE, 292),
('Q175.02', 'Q175.02', 11, NULL, 'des procédures de qualification et/ou de maintenance préventive et/ou curative si celles-ci sont effectuées en interne', '6.21', NULL, '6.21', NULL, NULL, FALSE, 293),
('Q175.03', 'Q175.03', 11, NULL, 'Le contrat de qualification et/ou maintenance préventive et/ou curative si celles-ci sont effectuées par un prestataire externe', '6.21', NULL, '6.21', NULL, NULL, FALSE, 294),
('Q175.04', 'Q175.04', 11, NULL, 'les résultats (certificats) des différentes opérations de qualification ou de maintenance', '6.21', NULL, '6.21', NULL, NULL, FALSE, 295),
('Q175.05', 'Q175.05', 11, NULL, 'une carte de contrôle (lorsque l''appareil s''y prête) sur laquelle sont reportés les paramètres des contrôles critiques afin d''identifier rapidement les dérives instrumentales', '6.21', NULL, '6.21', NULL, NULL, FALSE, 296),
('Q175.06', 'Q175.06', 11, NULL, 'la trace de toutes les opérations réalisées sur l''appareil', '6.21', NULL, '6.21', NULL, NULL, FALSE, 297),
('Q176', 'Q176', 13, NULL, 'Il existe un organigramme hiérarchique', '2.08', NULL, '2.08, 5.04', NULL, NULL, FALSE, 298),
('Q177', 'Q177', 13, NULL, 'Il existe un organigramme fonctionnel', '2.08', NULL, '2.08', NULL, NULL, FALSE, 299),
('Q178', 'Q178', 13, NULL, 'Les organigrammes hiérarchique et fonctionnel sont à jour (moins d''un an), affichés/accessibles, et cohérents avec les fiches de poste', '2.08', NULL, '2.08', NULL, NULL, FALSE, 300);
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('Q179', 'Q179', 13, NULL, 'Il existe des fiches de postes/métier et/ou de fonctions, à jour, établies pour l''ensemble des personnels', '1.07', NULL, '1.07, 2.01, 2.09', NULL, NULL, FALSE, 301),
('Q180', 'Q180', 13, NULL, 'Chaque membre du personnel dispose d''une preuve individuelle de prise de connaissance des fiches de postes/métier et de fonctions qui le concernent', '2.09', NULL, '2.09, 2.01', NULL, NULL, FALSE, 302),
('Q181', 'Q181', 13, NULL, 'Le secret professionnel fait l''objet d''une prise en compte spécifique (charte de confidentialité, règlementement intérieur,..)', '2.02', NULL, '2.02', NULL, NULL, FALSE, 303),
('Q182', 'Q182', 13, NULL, 'L''engagement de confidentialité (charte, règlement intérieur) est signé individuellement par chaque membre du personnel, avec une trace conservée au dossier', '2.02', NULL, '2.02', NULL, NULL, FALSE, 304),
('Q183', 'Q183', 18, NULL, 'Les éléments permettant la mise en évidence de la faisabilité technique et réglementaire de la préparation sont enregistrés', '4.33', NULL, '4.33', NULL, NULL, FALSE, 305),
('Q184', 'Q184', 19, NULL, 'Chaque dossier de préparation contient', '4.34', NULL, '4.34', NULL, NULL, TRUE, 306),
('Q184.01', 'Q184.01', 19, NULL, 'les spécifications pour les MPUP et le cas échéant, pour les articles de conditionnement', '4.34', NULL, '4.34', NULL, NULL, FALSE, 307),
('Q184.02', 'Q184.02', 19, NULL, 'les spécifications pour les produits intermédiaires et les préparations terminées', '4.34', NULL, '4.34', NULL, NULL, FALSE, 308),
('Q184.03', 'Q184.03', 19, NULL, 'les instructions de préparation qui comportent toutes les indications nécessaires pour la réalisation de la préparation (locaux, matériel, procédé…). Le nombre maximal d’unités par lot qui peut être réalisé doit garantir que l’impact d’un lot porte sur un nombre limité de patients', '4.34', NULL, '4.34', NULL, NULL, FALSE, 309),
('Q184.04', 'Q184.04', 19, NULL, 'les instructions de conditionnement qui permettent que l’étape de conditionnement soit réalisée conformément aux spécifications attendues', '4.34', NULL, '4.34', NULL, NULL, FALSE, 310),
('Q185', 'Q185', 19, NULL, 'Chaque dossier de préparation précise que le nombre de patients potentiellement traités ne dépasse pas 250 pour une durée de traitement de 28 jours (voir définition du « lot » du glossaire).', '4.34', NULL, '4.34', NULL, NULL, FALSE, 311),
('Q186', 'Q186', 19, NULL, 'Le dossier de préparation prévoit l''analyse des interactions contenant/contenu le cas échéant', '5.33', NULL, '5.33', NULL, NULL, FALSE, 312),
('Q187', 'Q187', 19, NULL, 'De l’ensemble des instructions du dossier de préparation découlent une ou plusieurs fiche(s) de préparation et une ou plusieurs fiche(s) de conditionnement.', '4.34', NULL, '4.34', NULL, NULL, FALSE, 313),
('Q188', 'Q188', 20, NULL, 'La description des contrôles à réaliser en cours et en fin de préparation figurent dans le dossier de préparation', '4.35', NULL, '4.35, 5.49', NULL, NULL, FALSE, 314),
('Q189', 'Q189', 20, NULL, 'De l’ensemble de ces instructions découlent une ou plusieurs fiche(s) de contrôle.', '4.35', NULL, '4.35', NULL, NULL, FALSE, 315),
('Q190', 'Q190', 21, NULL, 'Il existe un dossier de lot pour chaque préparation, permettant une traçabilité complète de la préparation, de sa fabrication à la dispensation au patient', '4.36', NULL, '4.36, LD1.145, 1.07', NULL, NULL, FALSE, 316),
('Q191', 'Q191', 21, NULL, 'Le dossier de lot contient :', '4.37', NULL, '4.37, 5.03', NULL, NULL, TRUE, 317),
('Q191.01', 'Q191.01', 21, NULL, 'les informations relatives aux MPUP', '4.37', NULL, '4.37', NULL, NULL, FALSE, 318),
('Q191.02', 'Q191.02', 21, NULL, 'les informations relatives aux articles de conditionnement', '4.37', NULL, '4.37', NULL, NULL, FALSE, 319),
('Q191.03', 'Q191.03', 21, NULL, 'les informations relatives au procédé de préparation', '4.37', NULL, '4.37', NULL, NULL, FALSE, 320),
('Q191.04', 'Q191.04', 21, NULL, 'les informations relatives à l''étiquetage de la préparation', '4.37', NULL, '4.37', NULL, NULL, FALSE, 321),
('Q191.05', 'Q191.05', 21, NULL, 'les informations relatives aux contrôles de la préparation', '4.37', NULL, '4.37', NULL, NULL, FALSE, 322),
('Q191.06', 'Q191.06', 21, NULL, 'les informations relatives aux modalités de conservation de la préparation', '4.37', NULL, '4.37', NULL, NULL, FALSE, 323),
('Q191.07', 'Q191.07', 21, NULL, 'les incidents survenus au cours de l''intégralité du process de préparation', '4.37', NULL, '4.37, 5.03', NULL, NULL, FALSE, 324),
('Q192', 'Q192', 21, NULL, 'Le dossier de lot comporte 5 parties  :', '4.38', NULL, '4.38', NULL, NULL, TRUE, 325),
('Q192.01', 'Q192.01', 21, NULL, 'une partie préparation', '4.38', NULL, '4.38', NULL, NULL, FALSE, 326),
('Q192.02', 'Q192.02', 21, NULL, 'une partie conditionnement', '4.38', NULL, '4.38', NULL, NULL, FALSE, 327),
('Q192.03', 'Q192.03', 21, NULL, 'une partie contrôle', '4.38', NULL, '4.38', NULL, NULL, FALSE, 328),
('Q192.04', 'Q192.04', 21, NULL, 'une partie libération pharmaceutique', '4.38', NULL, '4.38', NULL, NULL, FALSE, 329),
('Q192.05', 'Q192.05', 21, NULL, 'une partie gestion des anomalies ou retours/réclamations', '4.38', NULL, '4.38', NULL, NULL, FALSE, 330),
('Q193', 'Q193', 21, NULL, 'Le dossier de lot contient ou fait référence aux enregistrements disponibles pour la traçabilité des opérations de préparation', '4.39', NULL, '4.39', NULL, NULL, FALSE, 331),
('Q194', 'Q194', 21, NULL, 'Le dossier de lot contient ou fait référence aux enregistrements disponibles pour la traçabilité des opérations de contrôle', '4.39', NULL, '4.39, 5.43, 5.49', NULL, NULL, FALSE, 332),
('Q195', 'Q195', 21, NULL, 'Le dossier de lot contient ou fait référence aux enregistrements sont disponibles pour la traçabilité des opérations de dispensation', '4.39', NULL, '4.39', NULL, NULL, FALSE, 333),
('Q196', 'Q196', 21, NULL, 'Le dossier de lot contient ou fait référence aux enregistrements sont disponibles pour la traçabilité des opérations d''expédition le cas échéant', '4.39', NULL, '4.39', NULL, NULL, FALSE, 334),
('Q197', 'Q197', 21, NULL, 'Sont inscrit dans le dossier de lot :', '4.40', NULL, '4.40, 4.42', NULL, NULL, TRUE, 335),
('Q197.01', 'Q197.01', 21, NULL, 'Eléments à renseigner au moment de la préparation', '4.40', NULL, '4.40', NULL, NULL, FALSE, 336),
('Q197.01.01', 'Q197.01.01', 21, NULL, '● Préparation pharmaceutique : dénomination, dosage en substance(s) active(s) et forme pharmaceutique de la préparation', '4.40', NULL, '4.40', NULL, NULL, FALSE, 337),
('Q197.01.02', 'Q197.01.02', 21, NULL, '● Numéro de lot / d''ordonnancier de la préparation', '4.40', NULL, '4.40', NULL, NULL, FALSE, 338),
('Q197.01.03', 'Q197.01.03', 21, NULL, '● Date de la réalisation de la préparation', '4.40', NULL, '4.40', NULL, NULL, FALSE, 339),
('Q197.01.04', 'Q197.01.04', 21, NULL, '● Nom du préparateur', '4.40', NULL, '4.40', NULL, NULL, FALSE, 340),
('Q197.01.05', 'Q197.01.05', 21, NULL, '● Nom du contrôleur', '4.40', NULL, '4.40', NULL, NULL, FALSE, 341),
('Q197.01.06', 'Q197.01.06', 21, NULL, '● Nom et adresse de la pharmacie sous-traitante (en cas de sous-traitance)', '4.40', NULL, '4.40', NULL, NULL, FALSE, 342),
('Q197.01.07', 'Q197.01.07', 21, NULL, '● Date de péremption', '4.40', NULL, '4.40', NULL, NULL, FALSE, 343),
('Q197.01.08', 'Q197.01.08', 21, NULL, '● MPUP mises en œuvre : dénomination de la MPUP, nom du fournisseur, numéro de lot ou nom et numéro de lot de la spécialité pharmaceutique utilisée, date de péremption', '4.40', NULL, '4.40', NULL, NULL, FALSE, 344),
('Q197.01.09', 'Q197.01.09', 21, NULL, '● Quantité(s) ou volumes(s) à prélever', '4.40', NULL, '4.40', NULL, NULL, FALSE, 345),
('Q197.01.10', 'Q197.01.10', 21, NULL, '● Quantité(s) ou volumes(s) à retirer (le cas échant)', '4.40', NULL, '4.40', NULL, NULL, FALSE, 346),
('Q197.01.11', 'Q197.01.11', 21, NULL, '● Enregistrements ou double-contrôles des volumes mesurés', '4.40', NULL, '4.40', NULL, NULL, FALSE, 347),
('Q197.01.12', 'Q197.01.12', 21, NULL, '● Ticket(s) de stérilisation (le cas échéant)', '4.40', NULL, '4.40', NULL, NULL, FALSE, 348),
('Q197.01.13', 'Q197.01.13', 21, NULL, '● Eventuels commentaires, écarts aux procédures ou défauts observés par rapport à la réalisation de la préparation', '4.40', NULL, '4.40', NULL, NULL, FALSE, 349),
('Q197.01.14', 'Q197.01.14', 21, NULL, '● Etiquette', '4.40', NULL, '4.40', NULL, NULL, FALSE, 350),
('Q197.02', 'Q197.02', 21, NULL, 'Eléments à renseigner au moment du conditionnement', '4.40', NULL, '4.40', NULL, NULL, TRUE, 351),
('Q197.02.01', 'Q197.02.01', 21, NULL, '● Type de conditionnement', '4.40', NULL, '4.40', NULL, NULL, FALSE, 352),
('Q197.02.02', 'Q197.02.02', 21, NULL, '● Nombre d''unités à conditionner et nombre d’unités conditionnées', '4.40', NULL, '4.40', NULL, NULL, FALSE, 353),
('Q197.02.03', 'Q197.02.03', 21, NULL, '● Etiquettage de la préparation', '4.40', NULL, '4.40', NULL, NULL, FALSE, 354),
('Q197.02.04', 'Q197.02.04', 21, NULL, '● Eventuels anomalies et incidents au cours du conditionnement', '4.40', NULL, '4.40', NULL, NULL, FALSE, 355),
('Q197.02.05', 'Q197.02.05', 21, NULL, '● identification des opérateurs', '4.40', NULL, '4.40', NULL, NULL, FALSE, 356),
('Q197.03', 'Q197.03', 21, NULL, 'Eléments à renseigner au moment des contrôles et de la libération pharmaceutique', '4.40', NULL, '4.40', NULL, NULL, TRUE, 357),
('Q197.03.01', 'Q197.03.01', 21, NULL, '● Identification des opérateurs', '4.40', NULL, '4.40', NULL, NULL, FALSE, 358),
('Q197.03.02', 'Q197.03.02', 21, NULL, '● Résultats datés et signés des double-contrôles réalisés en cours de préparation', '4.40', NULL, '4.40', NULL, NULL, FALSE, 359),
('Q197.03.03', 'Q197.03.03', 21, NULL, '● Résultats datés et signés des éventuels contrôles sur la préparation terminée (physico-chimiques, pharmacotechniques, microbiologques, autres) en cas de contrôles', '4.40', NULL, '4.40', NULL, NULL, FALSE, 360),
('Q197.03.04', 'Q197.03.04', 21, NULL, '● Mention de l''acceptation ou du refus de la préparation', '4.40', NULL, '4.40', NULL, NULL, FALSE, 361),
('Q197.03.05', 'Q197.03.05', 21, NULL, '● Mention de l''acceptation ou du refus de la préparation', '4.42', NULL, '4.42', NULL, NULL, FALSE, 362),
('Q197.03.06', 'Q197.03.06', 21, NULL, '● Date, identification et signature du pharmacien ayant libéré la préparation', '4.40', NULL, '4.40', NULL, NULL, FALSE, 363),
('Q197.03.07', 'Q197.03.07', 21, NULL, '● Date, identification et signature du pharmacien ayant libéré la préparation', '4.42', NULL, '4.42', NULL, NULL, FALSE, 364),
('Q197.04', 'Q197.04', 21, NULL, 'Autres documents', '4.40', NULL, '4.40', NULL, NULL, TRUE, 365),
('Q197.04.01', 'Q197.04.01', 21, NULL, 'Documents relatifs aux contrôles de l''environnement', '4.40', NULL, '4.40', NULL, NULL, FALSE, 366),
('Q197.04.02', 'Q197.04.02', 21, NULL, 'Documentation relative aux retours et réclamations et rappels de lots', '4.40', NULL, '4.40', NULL, NULL, FALSE, 367),
('Q197.04.03', 'Q197.04.03', 21, NULL, 'Certificat de destruction', '4.40', NULL, '4.40', NULL, NULL, FALSE, 368),
('Q197.04.04', 'Q197.04.04', 21, NULL, 'Anomalies', '4.40', NULL, '4.40', NULL, NULL, FALSE, 369),
('Q197.04.05', 'Q197.04.05', 21, NULL, 'Documents d''échantillonage', '4.40', NULL, '4.40', NULL, NULL, FALSE, 370),
('Q198', 'Q198', 21, NULL, 'La libération pharmaceutique tient compte de tous les éléments du dossier de lot', '4.41', NULL, '4.41', NULL, NULL, FALSE, 371),
('Q199', 'Q199', 21, NULL, 'Le dossier de lot mentionne l''acceptation ou du refus de la préparation', '4.42', NULL, '4.42', NULL, NULL, FALSE, 372),
('Q200', 'Q200', 22, NULL, 'Il existe un ordonnancier (livre-registre) des préparations (informatique ou papier) avec les mentions suivantes', '4.44', NULL, '4.44', NULL, NULL, TRUE, 373),
('Q200.01', 'Q200.01', 22, NULL, 'Numéros d''ordonnancier chronologiques et différents à chaque préparation', '4.44', NULL, '4.44', NULL, NULL, FALSE, 374),
('Q200.02', 'Q200.02', 22, NULL, 'Date de réalisation', '4.44', NULL, '4.44', NULL, NULL, FALSE, 375),
('Q200.03', 'Q200.03', 22, NULL, 'En cas de sous-traitance : nom, adresse et n° de lot de la préparation utilisé par la pharmacie sous-traitante', '4.44', NULL, '4.44', NULL, NULL, FALSE, 376),
('Q200.04', 'Q200.04', 22, NULL, 'Prescripteur', '4.44', NULL, '4.44', NULL, NULL, FALSE, 377),
('Q200.05', 'Q200.05', 22, NULL, 'Service de soins', '4.44', NULL, '4.44', NULL, NULL, FALSE, 378),
('Q200.06', 'Q200.06', 22, NULL, 'Nom et prénom du patient', '4.44', NULL, '4.44', NULL, NULL, FALSE, 379),
('Q200.07', 'Q200.07', 22, NULL, 'Dénomination de la préparation, dosage en MPUP, forme pharmaceutique et conditionnement', '4.44', NULL, '4.44', NULL, NULL, FALSE, 380),
('Q200.08', 'Q200.08', 22, NULL, 'Composition qualitative et quantitative, N° de lot et fournisseur de chaque constituant', '4.44', NULL, '4.44', NULL, NULL, FALSE, 381),
('Q200.09', 'Q200.09', 22, NULL, 'Nombre d''unités réalisées avec indication de la masse, volume des substances actives engagées par lot', '4.44', NULL, '4.44', NULL, NULL, FALSE, 382),
('Q200.10', 'Q200.10', 22, NULL, 'Identification de la personne ayant réalisé la préparation et s''il y a lieu le nom et l''adresse de la pharmacie sous-traitance', '4.44', NULL, '4.44', NULL, NULL, FALSE, 383),
('Q201', 'Q201', 22, NULL, 'Les mentions inscrites à l''ordonnancier permettent d''identifier le dossier de lot de la préparation dispensée', '4.45', NULL, '4.45', NULL, NULL, FALSE, 384),
('Q202', 'Q202', 22, NULL, 'Les mentions inscrites à l''ordonnancier permettent d''identifier le dossier de lot de la préparation dispensée par la pharmacie ayant assuré la préparation dans le cas de la sous-traitance', '4.46', NULL, '4.46', NULL, NULL, FALSE, 385),
('Q203', 'Q203', 22, NULL, 'Il existe une liste qualitative et quantitave qui comprend les matériels, les équipements et les installations de préparation ou de contrôle considérés comme critiques, établie par le PRP', '3.03', NULL, '3.03', NULL, NULL, FALSE, 386),
('Q204', 'Q204', 22, NULL, 'Il existe une liste qui comprend les matériels, les équipements et les installations de préparation ou de contrôle considérés comme critiques, établie par le PRP', '3.44', NULL, '3.44', NULL, NULL, FALSE, 387),
('Q205', 'Q205', 22, NULL, 'La liste qui comprend les matériels, les équipements et les installations de préparation ou de contrôle considérés comme critiques, établie par le PRP est datée et revue au moins annuellement pour tenir compte des nouveaux équipements', '3.44', NULL, '3.44', NULL, NULL, FALSE, 388),
('Q206', 'Q206', 22, NULL, 'Un listing quantitatif et qualitatif des aménagements et installations adaptés à l’hygiène, à la protection et à la sécurité du personnel est maintenu à jour au sein de l''ES (ex rinces-œil)', '3.11', NULL, '3.11', NULL, NULL, FALSE, 389),
('Q207', 'Q207', 22, NULL, 'Les plans détaillant les locaux (identification, affectation, surface) et l''implantation des équipements sont disponibles', '3.03', NULL, '3.03, 3.26, LD1.032, LD1.050', NULL, NULL, FALSE, 390),
('Q208', 'Q208', 22, NULL, 'Les plans décrivant l''organisation des flux des personnels, des matières, des préparations finies et des déchets sont disponibles', '3.03', NULL, '3.03, LD1.032', NULL, NULL, FALSE, 391),
('Q209', 'Q209', 22, NULL, 'Il existe une liste des personnes autorisées à accéder aux locaux  validée par le PRP/pharmacien gérant', '3.13', NULL, '3.13', NULL, NULL, FALSE, 392),
('Q210', 'Q210', 22, NULL, 'La liste des personnes autorisées à accéder aux zones de préparation est  formalisée, à jour, et vérifiable via un contrôle d''accès (badge, registre)', '3.13', NULL, '3.13', NULL, NULL, FALSE, 393),
('Q211', 'Q211', 22, NULL, 'Pour la réalisation des préparations de catégories 1, 2 et 3 chaque zone/local dédié listé est physiquement identifiable et distinct', '3.15', NULL, '3.15', NULL, NULL, FALSE, 394),
('Q212', 'Q212', 22, NULL, 'Le PRP dispose du schéma aéraulique de la zone de préparation et des zones contrôlées attenantes', 'LD1.054', NULL, 'LD1.054', NULL, NULL, FALSE, 395),
('Q213', 'Q213', 22, NULL, 'Il existe un document à jour recensant les valeurs limites d''exposition professionnelle des substances utilisées lorsqu''elles sont connues', 'LD2.006', NULL, 'LD2.006, LD2.007', NULL, NULL, FALSE, 396),
('Q214-A', 'Q214-A', 23, NULL, 'Il existe une procédure relative à l''archivage des documents qui fixe la durée d''archivage des documents suivants', '4.47', NULL, '4.47', NULL, NULL, FALSE, 397),
('Q214', 'Q214', 23, NULL, 'Analyse de la prescription d''une préparation : durée minimum fixée par l''établissement', '4.47', NULL, '4.47', NULL, NULL, FALSE, 398),
('Q215', 'Q215', 23, NULL, 'Dossier de préparation : au moins 5 ans après la date de péremption du dernier lot du produit', '4.47', NULL, '4.47', NULL, NULL, FALSE, 399),
('Q216', 'Q216', 23, NULL, 'Dossier de lot : au moins 1 an après la date de péremption de la préparation', '4.47', NULL, '4.47', NULL, NULL, FALSE, 400);
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('Q217', 'Q217', 23, NULL, 'Registres des préparations (ordonnancier) : au moins 10 ans', '4.47', NULL, '4.47', NULL, NULL, FALSE, 401),
('Q218', 'Q218', 23, NULL, 'Registres des réceptions : durée minimum fixée par l''établissement (si applicable)', '4.47', NULL, '4.47', NULL, NULL, FALSE, 402),
('Q219', 'Q219', 23, NULL, 'Documents qualité  (cahiers de suivi, enregistrements relatifs à la qualité, ...) : durée fixée par l''établissement', '4.47', NULL, '4.47', NULL, NULL, FALSE, 403),
('Q220', 'Q220', 25, NULL, 'Les personnels disposent des qualifications réglementaires à l''exercice de leurs fonctions et celles ci sont enregistrées (diplôme,…)', '1.07', NULL, '1.07, 5.04, 2.01, 2.02, 2.03', NULL, NULL, FALSE, 404),
('Q221', 'Q221', 25, NULL, 'Un pharmacien est désigné responsable des préparations (PRP)', '2.12', NULL, '2.12, 2.02, 5.04', NULL, NULL, FALSE, 405),
('Q222', 'Q222', 25, NULL, 'L''acte de désignation du PRP est formalisé par écrit (fiche de fonction signée), daté et archivé.', '2.12', NULL, '2.12, 5.04', NULL, NULL, FALSE, 406),
('Q223', 'Q223', 25, NULL, 'Le PRP présente les compétences nécessaires à sa prise de fonction et justifie d''une formation', 'LD1.102', NULL, 'LD1.102', NULL, NULL, FALSE, 407),
('Q224', 'Q224', 25, NULL, 'Le PRP dispose d''un dossier individuel prouvant formation initiale, expérience et formation continue spécifiques à la préparation stérile, mis à jour chaque année qui contient la', 'LD1.102', NULL, 'LD1.102', NULL, NULL, TRUE, 408),
('Q224.01', 'Q224.01', 25, NULL, 'documentation de formation initiale adaptée', 'LD1.102', NULL, 'LD1.102', NULL, NULL, FALSE, 409),
('Q224.02', 'Q224.02', 25, NULL, 'documentation d''expérience dans le domaine', 'LD1.102', NULL, 'LD1.102', NULL, NULL, FALSE, 410),
('Q224.03', 'Q224.03', 25, NULL, 'documentation de formation continue dans le domaine', 'LD1.102', NULL, 'LD1.102', NULL, NULL, FALSE, 411),
('Q225', 'Q225', 25, NULL, 'Le PRP présente les compétences nécessaires à sa prise de fonction et  justifie d''une formation spécifique au fonctionnement de la ZAC et au type de poste de travail', 'LD1.103', NULL, 'LD1.103', NULL, NULL, FALSE, 412),
('Q226', 'Q226', 25, NULL, 'Le PRP dispose d''un dossier individuel prouvant formation initiale, expérience et formation continue spécifiques au fonctionnement de la ZAC et au type de poste de travail, mis à jour chaque année qui contient la', 'LD1.103', NULL, 'LD1.103', NULL, NULL, TRUE, 413),
('Q226.01', 'Q226.01', 25, NULL, 'documentation de formation initiale adaptée', 'LD1.103', NULL, 'LD1.103', NULL, NULL, FALSE, 414),
('Q226.02', 'Q226.02', 25, NULL, 'documentation d''expérience dans le domaine', 'LD1.103', NULL, 'LD1.103', NULL, NULL, FALSE, 415),
('Q226.03', 'Q226.03', 25, NULL, 'documentation de formation continue dans le domaine', 'LD1.103', NULL, 'LD1.103', NULL, NULL, FALSE, 416),
('Q227', 'Q227', 25, NULL, 'En cas d''inaptitude du PRP à assurer ses fonctions, le pharmacien gérant en est averti par écrit', '2.13', NULL, '2.13', NULL, NULL, FALSE, 417),
('Q228', 'Q228', 25, NULL, 'Un pharmacien remplaçant le PRP est désigné', '2.06', NULL, '2.06', NULL, NULL, FALSE, 418),
('Q229', 'Q229', 25, NULL, 'Le remplaçant du PRP est nommément désigné par écrit à l''avance (et non improvisé le jour de l''absence), avec son propre dossier de compétences à jour', '2.06', NULL, '2.06', NULL, NULL, FALSE, 419),
('Q230', 'Q230', 25, NULL, 'Les fonctions et responsabilités attribuées au remplaçant du PRP sont formalisées', '2.06', NULL, '2.06', NULL, NULL, FALSE, 420),
('Q231', 'Q231', 25, NULL, 'Le pharmacien désigné remplaçant du PRP présente les compétences nécessaires à sa prise de fonction et  justifie d''une formation', '2.06', NULL, '2.06', NULL, NULL, FALSE, 421),
('Q232', 'Q232', 25, NULL, 'Le pharmacien désigné remplaçant du PRP dispose d''un dossier individuel prouvant formation initiale, expérience et formation continue spécifiques à la préparation stérile, mis à jour chaque année, qui contient la', '2.06', NULL, '2.06', NULL, NULL, TRUE, 422),
('Q232.01', 'Q232.01', 25, NULL, 'documentation de formation initiale adaptée', '2.06', NULL, '2.06', NULL, NULL, FALSE, 423),
('Q232.02', 'Q232.02', 25, NULL, 'documentation d''expérience dans le domaine', '2.06', NULL, '2.06', NULL, NULL, FALSE, 424),
('Q232.03', 'Q232.03', 25, NULL, 'documentation de formation continue dans le domaine', '2.06', NULL, '2.06', NULL, NULL, FALSE, 425),
('Q233', 'Q233', 25, NULL, 'Le pharmacien désigné remplaçant du PRP présente les compétences nécessaires à sa prise de fonction et  justifie d''une formation (fonctionnement de la ZAC / type de poste de travail)', 'LD1.103', NULL, 'LD1.103', NULL, NULL, FALSE, 426),
('Q234', 'Q234', 25, NULL, 'Le pharmacien désigné remplaçant du PRP dispose d''un dossier individuel prouvant formation initiale, expérience et formation continue spécifiques (fonctionnement de la ZAC / type de poste de travail), mis à jour chaque année, qui contient la', 'LD1.103', NULL, 'LD1.103', NULL, NULL, TRUE, 427),
('Q234.01', 'Q234.01', 25, NULL, 'documentation de formation initiale adaptée', 'LD1.103', NULL, 'LD1.103', NULL, NULL, FALSE, 428),
('Q234.02', 'Q234.02', 25, NULL, 'documentation d''expérience dans le domaine', 'LD1.103', NULL, 'LD1.103', NULL, NULL, FALSE, 429),
('Q234.03', 'Q234.03', 25, NULL, 'documentation de formation continue dans le domaine', 'LD1.103', NULL, 'LD1.103', NULL, NULL, FALSE, 430),
('Q235', 'Q235', 25, NULL, 'Une personne responsable des contrôles est désignée', '6.16', NULL, '6.16', NULL, NULL, FALSE, 431),
('Q236', 'Q236', 25, NULL, 'Les fonctions et responsabilités attribuées à la personne responsable des contrôles sont formalisées', '6.16', NULL, '6.16', NULL, NULL, FALSE, 432),
('Q237', 'Q237', 25, NULL, 'La personne responsable des contrôles dispose d''un dossier individuel prouvant formation initiale, expérience et formation continue spécifiques, mis à jour chaque année, qui contient la', '6.16', NULL, '6.16', NULL, NULL, TRUE, 433),
('Q237.01', 'Q237.01', 25, NULL, 'documentation de formation initiale adaptée à la supervision des contrôles', '6.16', NULL, '6.16', NULL, NULL, FALSE, 434),
('Q237.02', 'Q237.02', 25, NULL, 'documentation d''expérience dans le domaine des contrôles', '6.16', NULL, '6.16', NULL, NULL, FALSE, 435),
('Q237.03', 'Q237.03', 25, NULL, 'documentation de formation continue dans le domaine des contrôles', '6.16', NULL, '6.16', NULL, NULL, FALSE, 436),
('Q238', 'Q238', 25, NULL, 'La personne responsable des contrôles dispose d''un dossier de compétences distinct de celui du PRP, avec preuve d''actualisation régulière de ses connaissances analytiques', '6.16', NULL, '6.16', NULL, NULL, FALSE, 437),
('Q239', 'Q239', 25, NULL, 'L''effectif Pharmacien est suffisant (calculateur de la SFPO)', '2.07', NULL, '2.07, 2.01', NULL, NULL, FALSE, 438),
('Q240', 'Q240', 25, NULL, 'L''effectif PP(H) est suffisant (calculateur de la SFPO)', '2.07', NULL, '2.07, 2.01', NULL, NULL, FALSE, 439),
('Q241', 'Q241', 25, NULL, 'Les effectifs sont adaptés à l''activité de contrôle', '6.14', NULL, '6.14, 2.01', NULL, NULL, FALSE, 440),
('Q242', 'Q242', 25, NULL, 'L'' effectif en personnels dédiés aux approvisionnement, stockage est suffisant', '2.07', NULL, '2.07, 2.01', NULL, NULL, FALSE, 441),
('Q243', 'Q243', 25, NULL, 'L''effectif du personnel d''entretien est  suffisant (calculateur de la SFPO)', '2.07', NULL, '2.07, 2.01', NULL, NULL, FALSE, 442),
('Q244', 'Q244', 26, NULL, 'Le PRP s’assure du respect des règles des Bonnes Pratiques de Préparation (BPP) et de la qualité des préparations réalisées par la réalisation réguliere d''une auto-inspection relative à l''application des BPP', '2.12', NULL, '2.12', NULL, NULL, FALSE, 443),
('Q245', 'Q245', 26, NULL, 'Le PRP  est donc responsable notamment :', '2.12', NULL, '2.12', NULL, NULL, TRUE, 444),
('Q245.01', 'Q245.01', 26, NULL, 'de tâches liées au management du système qualité', '2.12', NULL, '2.12', NULL, NULL, FALSE, 445),
('Q245.01.01', 'Q245.01.01', 26, NULL, 'de l''élaboration et la validation du dossier de préparation', '2.12', NULL, '2.12', NULL, NULL, FALSE, 446),
('Q245.01.02', 'Q245.01.02', 26, NULL, 'de l''approbation des procédures et des modes opératoires, y compris les modifications', '2.12', NULL, '2.12', NULL, NULL, FALSE, 447),
('Q245.01.03', 'Q245.01.03', 26, NULL, 'de la surveillance et du contrôle de l’environnement de préparation', '2.12', NULL, '2.12', NULL, NULL, FALSE, 448),
('Q245.01.04', 'Q245.01.04', 26, NULL, 'de l''hygiène et de la sécurité dans les locaux', '2.12', NULL, '2.12', NULL, NULL, FALSE, 449),
('Q245.01.05', 'Q245.01.05', 26, NULL, 'de la validation des procédés', '2.12', NULL, '2.12', NULL, NULL, FALSE, 450),
('Q245.01.06', 'Q245.01.06', 26, NULL, 'du suivi et de l''adéquation de la formation requise pour le personnel', '2.12', NULL, '2.12', NULL, NULL, FALSE, 451),
('Q245.01.07', 'Q245.01.07', 26, NULL, 'de la participation à des revues qualité', '2.12', NULL, '2.12', NULL, NULL, FALSE, 452),
('Q245.01.08', 'Q245.01.08', 26, NULL, 'de la mise en œuvre d’une procédure efficace de communication pour remonter les problèmes de qualité en temps utile aux personnes appropriées', '2.12', NULL, '2.12', NULL, NULL, FALSE, 453),
('Q245.01.09', 'Q245.01.09', 26, NULL, 'de l''archivage des dossiers de lots et des dossiers de préparations', '2.12', NULL, '2.12', NULL, NULL, FALSE, 454),
('Q245.01.10', 'Q245.01.10', 26, NULL, 'de la sélection des fournisseurs, des sous-traitants et des prestataires des activités externalisées', '2.12', NULL, '2.12', NULL, NULL, FALSE, 455),
('Q245.02', 'Q245.02', 26, NULL, 'de tâches liées à la réalisation des préparations', '2.12', NULL, '2.12', NULL, NULL, FALSE, 456),
('Q245.02.01', 'Q245.02.01', 26, NULL, 'des conditions de stockage des MPUP, des articles de conditionnement, des produits intermédiaires et des préparations terminées', '2.12', NULL, '2.12', NULL, NULL, FALSE, 457),
('Q245.02.02', 'Q245.02.02', 26, NULL, 'des instructions concernant les opérations de réalisation de la préparation et vérifier leur stricte exécution', '2.12', NULL, '2.12', NULL, NULL, FALSE, 458),
('Q245.02.03', 'Q245.02.03', 26, NULL, 'de l''évaluation des dossiers de lot et de leur signature par une personne autorisée', '2.12', NULL, '2.12', NULL, NULL, FALSE, 459),
('Q245.02.04', 'Q245.02.04', 26, NULL, 'de l’entretien des locaux et des équipements ainsi que de leur qualification', '2.12', NULL, '2.12', NULL, NULL, FALSE, 460),
('Q245.02.05', 'Q245.02.05', 26, NULL, 'de s''assurer que les validations nécessaires ont bien été effectuées.', '2.12', NULL, '2.12', NULL, NULL, FALSE, 461),
('Q245.03', 'Q245.03', 26, NULL, 'de tâches liées au contrôle de la qualité', '2.12', NULL, '2.12', NULL, NULL, FALSE, 462),
('Q245.03.01', 'Q245.03.01', 26, NULL, 'd''accepter ou de refuser, selon ce qu’il juge approprié, les MPUP, les articles de conditionnement, les produits intermédiaires et les préparations terminées', '2.12', NULL, '2.12', NULL, NULL, FALSE, 463),
('Q245.03.02', 'Q245.03.02', 26, NULL, 'de s’assurer que tous les contrôles requis ont été effectués et que les dossiers correspondants ont été évalués', '2.12', NULL, '2.12', NULL, NULL, FALSE, 464),
('Q245.03.03', 'Q245.03.03', 26, NULL, 'de s’assurer que les validations nécessaires ont bien été effectuées.', '2.12', NULL, '2.12', NULL, NULL, FALSE, 465),
('Q246', 'Q246', 26, NULL, 'Le PRP valide toute nouvelle préparation devant être réalisée', '2.05', NULL, '2.05', NULL, NULL, FALSE, 466),
('Q247', 'Q247', 26, NULL, 'Cette décision est formalisée (annexe II)', '2.05', NULL, '2.05', NULL, NULL, FALSE, 467),
('Q248', 'Q248', 26, NULL, 'Le PRP s''assure de la qualification des matériels et installations, définit les conditions de requalification et leur périodicité', '3.48', NULL, '3.48', NULL, NULL, FALSE, 468),
('Q249', 'Q249', 26, NULL, 'Le PRP prévoit des instructions qui garantissent que les opérateurs signalent toute affection pouvant avoir une influence sur la qualité de la préparation réalisée. La déclaration des affections nécessitant une éviction du personnel de la zone de préparation est organisée.', '2.26', NULL, '2.26', NULL, NULL, FALSE, 469),
('Q250', 'Q250', 26, NULL, 'Le PRP et l''encadrement s''assurent que les personnes à qui on délègue certaines tâches ont les qualifications requises', '2.10', NULL, '2.10', NULL, NULL, FALSE, 470),
('Q251', 'Q251', 26, NULL, 'Cette délégation de tâche est enregistrée nominativement (qui, quelle tâche, sur quelle base de qualification)', '2.10', NULL, '2.10', NULL, NULL, FALSE, 471),
('Q252', 'Q252', 26, NULL, 'Le personnel travaillant en ZAC est pleinement conscient des conséquences potentielles de toute déviation aux procédures validées, pour l''intégrité de la préparation et la sécurité du patient/personnel.', 'LD1.104', NULL, 'LD1.104', NULL, NULL, FALSE, 472),
('Q253', 'Q253', 27, NULL, 'La procédure de formation initiale (avec habillitation) et continue, comprend un plan de formation, une formation spécifique :', '2.01', NULL, '2.01, 2.02, 2.14, 2.15, 2.18, 2.16, 4.23, 6.17, LD1.106, LD2.013, LD2.014', NULL, NULL, TRUE, 473),
('Q253.01', 'Q253.01', 27, NULL, 'à la réalisation des prépration stériles', '2.01', NULL, '2.01, 2.02, 2.14, 2.16', NULL, NULL, FALSE, 474),
('Q253.02', 'Q253.02', 27, NULL, 'à la manipulation des produits à risque', '2.01', NULL, '2.01, 2.02, 2.14, 2.16', NULL, NULL, FALSE, 475),
('Q253.03', 'Q253.03', 27, NULL, 'à la connaissance des BPP', '2.01', NULL, '2.01, 2.02, 2.14, LD1.106', NULL, NULL, FALSE, 476),
('Q253.04', 'Q253.04', 27, NULL, 'aux contrôles', '2.01', NULL, '2.01, 2.14, 2.16, 6.17', NULL, NULL, FALSE, 477),
('Q253.05', 'Q253.05', 27, NULL, 'aux opérations de nettoyage et de désinfection', '2.01', NULL, '2.01, 2.14, 2.16', NULL, NULL, FALSE, 478),
('Q253.06', 'Q253.06', 27, NULL, 'aux réapprovisionnement des zones', '2.01', NULL, '2.01, 2.14, LD2.014', NULL, NULL, FALSE, 479),
('Q253.07', 'Q253.07', 27, NULL, 'à la maintenance', '2.01', NULL, '2.01, 2.14, 2.16, LD2.014', NULL, NULL, FALSE, 480),
('Q253.08', 'Q253.08', 27, NULL, 'à l''évacuation des déchets', '2.01', NULL, '2.01, 2.14, LD2.014', NULL, NULL, FALSE, 481),
('Q253.09', 'Q253.09', 27, NULL, 'à l''entrée des locaux', '2.01', NULL, '2.01, 2.14, 2.15, LD1.106', NULL, NULL, FALSE, 482),
('Q253.10', 'Q253.10', 27, NULL, 'aux  procédures relatives à l''habillage, à l''hygiène et à la protection du personne', '2.01', NULL, '2.01, 4.23, LD2.013', NULL, NULL, FALSE, 483),
('Q254', 'Q254', 27, NULL, 'Dans le cadre de l''habillitation spécifique à la réalisation des préprations stériles (formation intiale et continue) à destination des PPH et personnels pharmaceutiques, celle-ci  comprend un test de remplissage aseptique (éléments de preuve)', 'LD1.107', NULL, 'LD1.107', NULL, NULL, FALSE, 484),
('Q255', 'Q255', 27, NULL, 'La liste des personnes ayant réussi le test de remplissage aseptique est à jour et consultable, avec exclusion automatique des non-validés du planning de préparation stérile', 'LD1.107', NULL, 'LD1.107', NULL, NULL, FALSE, 485),
('Q256', 'Q256', 27, NULL, 'Les connaissances et pratiques du personnel sont maintenues à jour, avec une évaluation au moins annuelle adaptée au niveau de risque des préparations réalisées.', 'LD1.108', NULL, 'LD1.108', NULL, NULL, FALSE, 486),
('Q257', 'Q257', 27, NULL, 'Le taux de réalisation effective de l''évaluation annuelle est mesuré (% du personnel évalué dans les temps), avec relance en cas de retard', 'LD1.108', NULL, 'LD1.108', NULL, NULL, FALSE, 487),
('Q258', 'Q258', 27, NULL, 'Dans le cadre du plan de formation, les fréquences de formations et d’évaluations pour la réalisation de préparations aseptiques sont définies et sont adaptées à l''activité réelle de préparations aseptiques (LD1 tableau 5 utilisé comme repère, non comme minimum figé sans analyse).', 'LD1.109', NULL, 'LD1.109', NULL, NULL, FALSE, 488),
('Q259', 'Q259', 27, NULL, 'La procédure de formation initiale (avec habillitation) et continue, dans le cadre des procédures relatives à l''habillage, à l''hygiène et à la protection du personne, prévoit une formation complémentaire spécifique qui porte sur', 'LD2.013', NULL, 'LD2.013', NULL, NULL, TRUE, 489),
('Q259.01', 'Q259.01', 27, NULL, 'la nature des produits manipulés', 'LD2.013', NULL, 'LD2.013', NULL, NULL, FALSE, 490),
('Q259.02', 'Q259.02', 27, NULL, 'l’identification et la compréhension des risques notamment grâce à la connaissance de l’étiquetage', 'LD2.013', NULL, 'LD2.013', NULL, NULL, FALSE, 491),
('Q259.03', 'Q259.03', 27, NULL, 'les dispositifs de protection collective et individuelle à utiliser', 'LD2.013', NULL, 'LD2.013', NULL, NULL, FALSE, 492),
('Q259.04', 'Q259.04', 27, NULL, 'la conduite à tenir en cas d’incident et l’utilisation des kits de décontamination et de(s) trousse(s) d’urgence', 'LD2.013', NULL, 'LD2.013', NULL, NULL, FALSE, 493),
('Q259.05', 'Q259.05', 27, NULL, 'le dispositif existant de déclaration des accidents d’exposition', 'LD2.013', NULL, 'LD2.013', NULL, NULL, FALSE, 494),
('Q260', 'Q260', 27, NULL, 'La procédure de formation initiale (avec habillitation) et continue, comprend une formation spécifique, pour les :', '2.01', NULL, '2.01, 2.02, 2.14, 2.15, 2.16, 2.18, 6.17, LD1.106, LD2.013, LD2.014', NULL, NULL, TRUE, 495),
('Q260.01', 'Q260.01', 27, NULL, 'Pharmaciens', '2.01', NULL, '2.01, 2.02, 2.14, 2.15, 2.16, 2.18, 6.17, LD1.106, LD2.013, LD2.014', NULL, NULL, FALSE, 496),
('Q260.02', 'Q260.02', 27, NULL, 'Internes en pharmacie', '2.01', NULL, '2.01, 2.02, 2.14, 2.15, 2.16, 2.18, 6.17, LD1.106, LD2.013, LD2.014', NULL, NULL, FALSE, 497),
('Q260.03', 'Q260.03', 27, NULL, 'Etudiants en 5ème AHU', '2.01', NULL, '2.01, 2.02, 2.14, 2.15, 2.16, 2.18, 6.17, LD1.106, LD2.013, LD2.014', NULL, NULL, FALSE, 498),
('Q260.04', 'Q260.04', 27, NULL, 'PP(H)', '2.01', NULL, '2.01, 2.02, 2.14, 2.15, 2.16, 2.18, 6.17, LD1.106, LD2.013, LD2.014', NULL, NULL, FALSE, 499),
('Q260.05', 'Q260.05', 27, NULL, 'personnel affecté au nettoyage', '2.01', NULL, '2.01, 2.15, 2.18, LD1.106, LD2.013, LD2.014', NULL, NULL, FALSE, 500);
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('Q260.06', 'Q260.06', 27, NULL, 'personnel affecté à la manutention, aux approvisionnement, stockage', '2.01', NULL, '2.01, 2.15, 2.18, LD1.106, LD2.013, LD2.014', NULL, NULL, FALSE, 501),
('Q261', 'Q261', 27, NULL, 'Les éléments de preuve de la formation initiale sont enregistrés pour l''ensemble du personnel (pharmaciens, internes en pharmacie, étudiants en 5ème AHU, PP(H), personnel affecté au nettoyage, personnel affecté à la manutention, aux approvisionnement, stockage)', '2.17', NULL, '2.17', NULL, NULL, FALSE, 502),
('Q262', 'Q262', 27, NULL, 'La formation est assurée en interne ou par des organismes habilités (les citer)', '2.17', NULL, '2.17', NULL, NULL, FALSE, 503),
('Q263', 'Q263', 27, NULL, 'Un tableau de suivi des compétences est mis en place', '2.17', NULL, '2.17', NULL, NULL, FALSE, 504),
('Q264', 'Q264', 27, NULL, 'Les planning, par poste, sont établis en fonction du tableau de suivi des compétences.', '2.17', NULL, '2.17', NULL, NULL, FALSE, 505),
('Q265', 'Q265', 27, NULL, 'La procédure d''accès aux locaux implique une formation spécifique à l''entrée dans les locaux de préparation, au personnel suceptible d''intervenir dans les locaux (biomédical, technique et hygiène des locaux, prestataire externe…) (éléments de preuve)', 'LD1.116', NULL, 'LD1.116', NULL, NULL, FALSE, 506),
('Q266', 'Q266', 27, NULL, 'Dans le cas où les prestations de nettoyage, d''entretien, d''évacuation des déchets et de maintenance sont sous-traitées, le cahier des charges prévoit que le prestataire forme le personnel affecté à la spécificité de ses missions', 'LD2.014', NULL, 'LD2.014', NULL, NULL, FALSE, 507),
('Q267', 'Q267', 28, NULL, 'Dans le cadre des procédures relatives à l''habillage, à l''hygiène et à la protection du personnel, les éléments suivants sont pris en compte :', '4.23', NULL, '4.23, 2.21, 2.22, 2.23, 2.25, LD1.111, LD1.114', NULL, NULL, TRUE, 508),
('Q267.01', 'Q267.01', 28, NULL, 'le port de vêtements et de chaussures de travail adaptés en fonction des travaux à effectuer', '4.23', NULL, '4.23, 2.22, 2.23', NULL, NULL, FALSE, 509),
('Q267.02', 'Q267.02', 28, NULL, 'le port de gants avec définition de la fréquence de changement des gants stériles', '4.23', NULL, '4.23, 2.21, 2.25', NULL, NULL, FALSE, 510),
('Q267.03', 'Q267.03', 28, NULL, 'le port de la charlotte', '4.23', NULL, '4.23, 2.22, 2.23', NULL, NULL, FALSE, 511),
('Q267.04', 'Q267.04', 28, NULL, 'le port de cache barbe', '4.23', NULL, '4.23, 2.22, 2.23', NULL, NULL, FALSE, 512),
('Q267.05', 'Q267.05', 28, NULL, 'les EPI et la définition des conditions d''utilisation', '4.23', NULL, '4.23, 2.25', NULL, NULL, FALSE, 513),
('Q267.06', 'Q267.06', 28, NULL, 'l''absence de port de montres-bracelets, les bijoux et autres objets personnels tels que les téléphones portables', '4.23', NULL, '4.23, LD1.111', NULL, NULL, FALSE, 514),
('Q267.07', 'Q267.07', 28, NULL, 'l''absence de maquillage (incluant le vernis à ongle),', '4.23', NULL, '4.23, LD1.111', NULL, NULL, FALSE, 515),
('Q267.08', 'Q267.08', 28, NULL, 'l''adaptation du type d''équipement de protection (de qualité) à la classe de la zone de travail ainsi qu''aux préparations réalisées', '4.23', NULL, '4.23, 2.25', NULL, NULL, FALSE, 516),
('Q268', 'Q268', 28, NULL, 'La procédure relative à l''hygiène du personnel mentionne l''obligation de signaler toute affection pouvant entrainer un risque de contamination 
des préparations', 'LD1.110', NULL, 'LD1.110', NULL, NULL, FALSE, 517),
('Q269', 'Q269', 28, NULL, 'La procédure relative à l''habillage précise que', 'LD1.112', NULL, 'LD1.112, LD1.042', NULL, NULL, TRUE, 518),
('Q269.01', 'Q269.01', 28, NULL, 'la tenue portée est adaptée au procédé et au niveau de propreté de la zone,', 'LD1.112', NULL, 'LD1.112', NULL, NULL, FALSE, 519),
('Q269.02', 'Q269.02', 28, NULL, 'les vêtements personnels ne sont pas introduits dans les sas menant aux classes B ou C.', 'LD1.112', NULL, 'LD1.112, LD1.114', NULL, NULL, FALSE, 520),
('Q269.03', 'Q269.03', 28, NULL, 'le changement tenue de ville / tenue de travail se fait dans le vestiaire du personnel', 'LD1.042', NULL, 'LD1.042', NULL, NULL, FALSE, 521),
('Q269.04', 'Q269.04', 28, NULL, 'le changement tenue de travail / tenue appropriée à la classe cible du local de la ZAC  se fait dans le sas', 'LD1.042', NULL, 'LD1.042', NULL, NULL, FALSE, 522),
('Q270', 'Q270', 28, NULL, 'La procédure relative à l''habillage du personnel précise les types de vêtements et d’équipements requis pour chaque classe ; le type d''équipement de protection est de qualité adapté à la classe de la zone de travail ainsi qu''aux préparations réalisées :', 'LD1.113', NULL, 'LD1.113', NULL, NULL, TRUE, 523),
('Q270.01', 'Q270.01', 28, NULL, 'Classe D : Les cheveux et, le cas échéant, la barbe sont couverts. Un vêtement protecteur et des chaussures ou des couvre-chaussures adaptés sont à porter', 'LD1.113', NULL, 'LD1.113', NULL, NULL, FALSE, 524),
('Q270.02', 'Q270.02', 28, NULL, 'Classe C : Les cheveux et le cas échéant, la barbe et la moustache sont couverts. Un masque couvrant le visage pour éviter l’émission de gouttelettes est utilisé si nécessaire. Des gants sont à porter. Ils sont stériles si besoin. Un vêtement constitué d’une veste et d’un pantalon ou d’une combinaison, serré aux poignets et muni d’un col montant, ainsi que de chaussures ou couvre-chaussures adaptés sont à porter. Le tissu ne libère pratiquement pas de fibres ou de particules', 'LD1.113', NULL, 'LD1.113', NULL, NULL, FALSE, 525),
('Q270.03', 'Q270.03', 28, NULL, 'Classes A et B : Un vêtement protecteur propre et stérile, ainsi que masques, gants et autres protections stériles sont portés par chaque opérateur en zone de classe A et B. Une cagoule enferme totalement les cheveux et, le cas échéant, la barbe et la moustache ; cette cagoule est reprise dans le col de la veste ; un masque couvre le visage pour éviter l''émission de gouttelettes. Des gants stérilisés et non poudrés, ainsi que des bottes stérilisées ou désinfectées sont à porter. Le bas du pantalon est enserré dans les bottes, de même que les manchettes dans les gants. Ce vêtement protecteur ne libère pratiquement ni fibres ni particules et retient les particules émises par l’opérateur', 'LD1.113', NULL, 'LD1.113', NULL, NULL, FALSE, 526),
('Q271', 'Q271', 28, NULL, 'Dans le cadre des procédures relatives à l''habillage, à l''hygiène et à la protection du personnel, il est précisé', 'LD2.037', NULL, 'LD2.037, LD2.038, LD2.039, LD2.040, LD2.041, LD2.042, 3.02', NULL, NULL, TRUE, 527),
('Q271.01', 'Q271.01', 28, NULL, 'que l''utilisation de plusieurs paire de gants est préconisée', 'LD2.037', NULL, 'LD2.037, LD2.038, LD2.040', NULL, NULL, FALSE, 528),
('Q271.02', 'Q271.02', 28, NULL, 'que le choix des gants est adapté à la nature du produit manipulé', 'LD2.037', NULL, 'LD2.037, LD2.038, LD2.040', NULL, NULL, FALSE, 529),
('Q271.03', 'Q271.03', 28, NULL, 'qu''en cas de manipulation d''une substance CMR en dehors d''un isolateur, l''EPI comprend l''utilisation d''une sur-blouse, de manchon pour avant-bras et de gants', 'LD2.037', NULL, 'LD2.037, LD2.038, LD2.039', NULL, NULL, FALSE, 530),
('Q271.04', 'Q271.04', 28, NULL, 'que des masques FFP2, FFP3 ou  appareil respiratoire isolant sont disponibles en cas de "danger respiratoire" caractérisé', 'LD2.037', NULL, 'LD2.037, LD2.038, LD2.041', NULL, NULL, FALSE, 531),
('Q271.05', 'Q271.05', 28, NULL, 'que des lunettes de protection/écrans faciaux sont disponibles en cas de "danger occulaire" caractérisé', 'LD2.037', NULL, 'LD2.037, LD2.038, LD2.042', NULL, NULL, FALSE, 532),
('Q271.06', 'Q271.06', 28, NULL, 'que les EPI et EPC, adaptés au niveau de risque, sont utilisés y compris au cours des opérations de nettoyage ou de maintenance réalisées à l’intérieur de la zone de préparation et lors des changements de matériels', '3.02', NULL, '3.02, LD2.015', NULL, NULL, FALSE, 533),
('Q272', 'Q272', 28, NULL, 'La procédure d''habillage favorise l''utilisation d''une tenue à usage unique', 'LD2.037', NULL, 'LD2.037, LD2.055', NULL, NULL, FALSE, 534),
('Q273', 'Q273', 28, NULL, 'En cas d''utilisation de tenue à usage multiple, un dispositif fermé est prévu pour stocker les vêtements contaminés et les nettoyer', 'LD2.055', NULL, 'LD2.055', NULL, NULL, FALSE, 535),
('Q274', 'Q274', 28, NULL, 'Dans le cadre de la procédure qui décrit les règles d''hygiène, il et précisé qu''il est interdit notamment de de manger, de boire, de mâcher ou de fumer, ainsi que de garder de la nourriture, des boissons, du tabac ou des effets personnels', '2.27', NULL, '2.27', NULL, NULL, FALSE, 536),
('Q275', 'Q275', 28, NULL, 'Dans le cadre de la procédure relative à la protection du personnel,', '2.20', NULL, '2.20', NULL, NULL, TRUE, 537),
('Q275.01', 'Q275.01', 28, NULL, 'des contrôles du risque de contamination microbiologique (prélèvement, lavage des mains, état des locaux..) et des contrôles sont réalisés conformemment à ces procédures (éléments de preuve)', '2.20', NULL, '2.20', NULL, NULL, FALSE, 538),
('Q275.02', 'Q275.02', 28, NULL, 'la maitrise du risque de contamination chimique (EPI, état des locaux, contrôles surfaciques...) est prise en compte et des contrôles sont réalisés conformément à ces procédures (éléments de preuve)', '2.20', NULL, '2.20', NULL, NULL, FALSE, 539),
('Q276', 'Q276', 28, NULL, 'La procédure relative à la protection du personnel prend en compte les risque liés à l''entretien, les maintenance curatives et préventives des locaux et des équipements', '3.05', NULL, '3.05', NULL, NULL, FALSE, 540),
('Q277', 'Q277', 28, NULL, 'La procédure relative à la protection du personnel s''applique pour les étapes de préparation et d’échantillonnage et des contrôles de MPUP, ainsi que les préparations terminées.', 'LD2.050', NULL, 'LD2.050', NULL, NULL, FALSE, 541),
('Q278', 'Q278', 30, NULL, 'Les matériels et installations sont adaptés aux opérations à effectuer et permettent de prévenir toute atteinte à la qualité des produits', '3.01', NULL, '3.01', NULL, NULL, FALSE, 542),
('Q279', 'Q279', 30, NULL, 'L''autorisation d''accès aux zones de préparations est validée par le PRP/pharmacien gérant  (seules les personnes autorisées peuvent pénétrer dans ces zones)', '3.13', NULL, '3.13', NULL, NULL, FALSE, 543),
('Q280', 'Q280', 30, NULL, 'Le nombre maximal de personnes autorisées simultanément dans chaque zone de préparation est affiché/connu, avec un contrôle du respect effectif de cette limite', 'LD1.105', NULL, 'LD1.105', NULL, NULL, FALSE, 544),
('Q281', 'Q281', 31, NULL, 'Les locaux et les équipements sont adaptés aux opérations à réaliser (surface, nature de l''équipement adapté au risque,…) (recommandations SFPO)', '1.07', NULL, '1.07, 3.03, 3.35, 5.05, LD1.032, 6.14', NULL, NULL, FALSE, 545),
('Q282', 'Q282', 31, NULL, 'L''organisation des locaux permet un déroulement logique des opérations  et une séparation des activités qui le nécessitent  (éviter tout croisement des flux de personnes, de produits et de matériels pour prévenir les contaminations)', '3.03', NULL, '3.03, 3.26, 3.35, LD1.042', NULL, NULL, FALSE, 546),
('Q283', 'Q283', 31, NULL, 'Les sols/murs/plafonds/autres surfaces de la ZAC sont conçus pour permettre nettoyage/désinfection répété sans dégradation (norme EN 14441)', '3.21', NULL, '3.21, 3.07, LD1.044', NULL, NULL, FALSE, 547),
('Q284', 'Q284', 31, NULL, 'L''efficacité du nettoyage (contaminations croisée)s est démontrée par des résultats de contrôle (prélèvements de surface)', '3.08', NULL, '3.08', NULL, NULL, FALSE, 548),
('Q285', 'Q285', 31, NULL, 'Il existe des mesures appropriées évitant les contaminations provenant de l''extérieur de la zone de contamination (insectes, pollens, …)', '3.09', NULL, '3.09, 2.24', NULL, NULL, FALSE, 549),
('Q286', 'Q286', 31, NULL, 'Un dispositif physique anti-nuisibles (moustiquaire, piège) est en place et contrôlé périodiquement', '3.09', NULL, '3.09, 2.24', NULL, NULL, FALSE, 550),
('Q287', 'Q287', 31, NULL, 'Un contrôle visuel documenté (photo, check-list) atteste régulièrement de la propreté/rangement/éclairage réel des zones', '3.12', NULL, '3.12', NULL, NULL, FALSE, 551),
('Q288', 'Q288', 31, NULL, 'Il existe des documents  et/ou des supports dématérialisés ou non,  enregistrant tous les facteurs pouvant influer sur la qualité des préparations (T°, P°, hygrométrie). Une gestion des alarmes est organisée', '3.10', NULL, '3.10, 3.31, 1.07, LD1.049, LD1.052, LD1.131, LD1.157', NULL, NULL, FALSE, 552),
('Q289', 'Q289', 31, NULL, 'Le système d''enregistrement des paramètres d''ambiance (T°, P°, hygrométrie) génère une alarme exploitée en temps réel, avec trace des actions prises en cas de dépassement', '3.10', NULL, '3.10, 3.31, LD1.049, LD1.052, LD1.131, LD1.157', NULL, NULL, FALSE, 553),
('Q290', 'Q290', 31, NULL, 'Le système de gestion des alarmes (T°, P°, hygrométrie) est testé périodiquement, avec preuve du dernier test et délai réel d''alerte du PRP', '3.10', NULL, '3.10, 3.31, LD1.049, LD1.052, LD1.131, LD1.157', NULL, NULL, FALSE, 554),
('Q291', 'Q291', 31, NULL, 'Les conditions d''environnement requises (T°, P°, hygrométrie) sont définies avec des valeurs seuils d’alerte et d’action chiffrées & avec contrôle documenté de leur respect', '3.10', NULL, '3.10, 3.31, LD1.051, LD1.131', NULL, NULL, FALSE, 555),
('Q292', 'Q292', 31, NULL, 'L''organisation des locaux permet un contact audio/visuel entre les opérateurs', 'LD2.024', NULL, 'LD2.024', NULL, NULL, FALSE, 556),
('Q293', 'Q293', 31, NULL, 'Les locaux disposent des aménagements et installations adaptés à l’hygiène, à la protection et à la sécurité du personnel compte tenu de la nature des produits détenus et manipulés.', '3.11', NULL, '3.11', NULL, NULL, FALSE, 557),
('Q294', 'Q294', 31, NULL, 'Les aménagements d''hygiène et de sécurité (lave-mains, douches, rince-yeux) sont vérifiés fonctionnels lors d''une visite terrain récente', '3.11', NULL, '3.11', NULL, NULL, FALSE, 558),
('Q295', 'Q295', 31, NULL, 'La distinction locale/zone est appliquée de façon cohérente dans tous les documents qualité (procédures, plans), évitant toute ambiguïté', '3.14', NULL, '3.14', NULL, NULL, FALSE, 559),
('Q296', 'Q296', 31, NULL, 'Des locaux et équipements spécifiques sont réservés pour', '3.16', NULL, '3.16', NULL, NULL, TRUE, 560),
('Q296.01', 'Q296.01', 31, NULL, 'les préparations non stériles', '3.16', NULL, '3.16', NULL, NULL, FALSE, 561),
('Q296.02', 'Q296.02', 31, NULL, 'les préparations stériles (hors anti-cancéreux et CMR)', '3.16', NULL, '3.16', NULL, NULL, FALSE, 562),
('Q296.03', 'Q296.03', 31, NULL, 'les préparations à risques (stériles et non stériles)', '3.16', NULL, '3.16', NULL, NULL, FALSE, 563),
('Q296.04', 'Q296.04', 31, NULL, 'la reconstitution des MTI ou mise en forme des MTI préparés ponctuellement', '3.16', NULL, '3.16', NULL, NULL, FALSE, 564),
('Q297', 'Q297', 31, NULL, 'Le choix de la zone d''atmosphère contrôlée est adapté aux opérations réalisées et justifiée au regard du niveau de risque défini dans les généralités.', 'LD1.118', NULL, 'LD1.118', NULL, NULL, TRUE, 565),
('Q297.01', 'Q297.01', 31, NULL, 'Pour les préparations stérilisées en phase terminale avec risque potentiel de contamination microbiologique, la classe de ZAC retenue est conforme au tableau 6 (LD1)', 'LD1.119', NULL, 'LD1.119', NULL, NULL, FALSE, 566),
('Q297.02', 'Q297.02', 31, NULL, 'Pour les préparations stérilisées en phase terminale sans risque potentiel de contamination microbiologique, la classe de ZAC retenue est conforme au tableau (LD1)', 'LD1.120', NULL, 'LD1.120', NULL, NULL, FALSE, 567),
('Q297.03', 'Q297.03', 31, NULL, 'Pour les préparations aseptiques, la classe de ZAC retenue est conforme au tableau 8 (LD1)', 'LD1.121', NULL, 'LD1.121', NULL, NULL, FALSE, 568),
('Q298', 'Q298', 31, NULL, 'Lorsque la préparation fait intervenir une filtration stérilisante, le tableau 8 (LD1) est adapté en conséquence et cette adaptation est tracée.', 'LD1.122', NULL, 'LD1.122', NULL, NULL, FALSE, 569),
('Q299', 'Q299', 31, NULL, 'Des locaux et équipements spécifiques sont réservés pour les produits pulvérulents', '5.14', NULL, '5.14', NULL, NULL, FALSE, 570),
('Q300', 'Q300', 31, NULL, 'Le local dédié aux produits pulvérulents dispose d''un confinement spécifique vérifié (dépression, filtration) et non une affectation d''usage', '5.14', NULL, '5.14', NULL, NULL, FALSE, 571),
('Q301', 'Q301', 31, NULL, 'Il existe une signalétique appropriée à l''usage des locaux', '3.17', NULL, '3.17, LD2.023', NULL, NULL, TRUE, 572),
('Q301.01', 'Q301.01', 31, NULL, 'risque chimique (substances CMR Main Jaune)', '3.17', NULL, '3.17, LD2.023', NULL, NULL, FALSE, 573),
('Q301.02', 'Q301.02', 31, NULL, 'risque biologique (agents biologiques des groupes 2, 3 ou 4 = logo Biohazard)', '3.17', NULL, '3.17, LD2.023', NULL, NULL, FALSE, 574),
('Q301.03', 'Q301.03', 31, NULL, 'rique azote', '3.17', NULL, '3.17, LD2.023', NULL, NULL, FALSE, 575),
('Q302', 'Q302', 31, NULL, 'Un contrôle a vérifié la signalétique lors de la dernière inspection visuelle documentée des locaux', '3.17', NULL, '3.17, LD2.023', NULL, NULL, FALSE, 576),
('Q303', 'Q303', 31, NULL, 'Les préparations contenant des substances chimiques pouvant présenter un risque pour la santé et l''environnement sont effectuées dans des locaux dédiés', '3.18', NULL, '3.18', NULL, NULL, FALSE, 577),
('Q304', 'Q304', 31, NULL, 'Les locaux et zones de préparation sont correctement ventilés (rapport de qualification)', '3.20', NULL, '3.20', NULL, NULL, FALSE, 578),
('Q305', 'Q305', 31, NULL, 'Les locaux présentent un système de renouvellement d''air', 'LD2.027', NULL, 'LD2.027', NULL, NULL, FALSE, 579),
('Q306', 'Q306', 31, NULL, 'Le taux de renouvellement d''air mesuré est conforme à la valeur cible définie pour chaque local, avec preuve de mesure récente', 'LD2.027', NULL, 'LD2.027', NULL, NULL, FALSE, 580),
('Q307', 'Q307', 31, NULL, 'Les locaux présentent un système d''extraction d''air', 'LD2.028', NULL, 'LD2.028', NULL, NULL, FALSE, 581),
('Q308', 'Q308', 31, NULL, 'Le point de rejet de l''air extrait est conforme (hauteur, filtration) pour éviter toute recontamination de l''environnement', 'LD2.028', NULL, 'LD2.028', NULL, NULL, FALSE, 582),
('Q309', 'Q309', 31, NULL, 'Le planning d''entretien des locaux est suivi avec un enregistrement de chaque passage (date, opérateur), permettant de vérifier son respect effectif', '3.21', NULL, '3.21', NULL, NULL, FALSE, 583),
('Q310', 'Q310', 31, NULL, 'Si les productions d’une ou de plusieurs préparations sont organisées "par campagne" l’organisation de la zone de préparation est adaptée', '3.23', NULL, '3.23', NULL, NULL, FALSE, 584),
('Q311', 'Q311', 31, NULL, 'Les dispositions suivantes sont respectées :', '3.24', NULL, '3.24', NULL, NULL, TRUE, 585),
('Q311.01', 'Q311.01', 31, NULL, 'préparation des différentes formes pharmaceutiques dans des zones adaptées séparées', '3.24', NULL, '3.24', NULL, NULL, FALSE, 586),
('Q311.02', 'Q311.02', 31, NULL, 'production « par campagne » à considérer le cas échéant', '3.24', NULL, '3.24', NULL, NULL, FALSE, 587),
('Q311.03', 'Q311.03', 31, NULL, 'mise en oeuvre d''opérations de nettoyage et de désinfection appropriées', '3.24', NULL, '3.24', NULL, NULL, FALSE, 588),
('Q312', 'Q312', 31, NULL, 'Les procédures de nettoyage/décontamination inter-campagne sont validées par des prélèvements de contrôle démontrant l''absence de contamination croisée résiduelle', 'LD2.022', NULL, 'LD2.022', NULL, NULL, FALSE, 589),
('Q313', 'Q313', 32, NULL, 'Les ZAC utilisées sont classées A, B, C ou D selon le nombre maximal de particules autorisées, et cette classification est cohérente avec l''activité qui y est réalisée.', 'LD1.033', NULL, 'LD1.033', NULL, NULL, FALSE, 590),
('Q314', 'Q314', 32, NULL, 'Le rapport d''analyse annuel est conforme aux BPP, à savoir que le nombre maximal autorisé de particules par m3 (de taille égale ou supérieur à) des différentes classes est :
   * Au repos :
      Classe A : 3520 (0,5 μm) et 20 (5 μm)
      Classe B : 3520 (0,5 μm) et 29 (5 μm)
      Classe C : 352 000 (0,5 μm) et 2900 (5 μm)
      Classe D : 3 520 000 (0,5 μm) et 29 000 (5μm)
   * En activité :
      Classe A : 3520 (0,5 μm) et 20 (5 μm)
      Classe B : 352 000 (0,5 μm) et 2900 (5 μm)
      Classe C : 3 520 000 (0,5 μm) et 29 000 (5μm)
      Classe D : Non défini', 'LD1.033', NULL, 'LD1.033', NULL, NULL, FALSE, 591),
('Q315', 'Q315', 32, NULL, 'Les ZAC (locaux et équipements) sont qualifiées et font l''objet d''une maintenance assurant la maîtrise continue de leurs qualités microbiologique et particulaire.', 'LD1.035', NULL, 'LD1.035', NULL, NULL, FALSE, 592),
('Q316', 'Q316', 33, NULL, 'La classification des ZAC est distincte de la surveillance microbiologique, et les deux états « au repos » et « en activité » sont caractérisés séparément. Le rapport d''analyse annuel est conforme aux BPP, à savoir que le nombre maximal autorisé de particules par m3 (de taille égale ou supérieur à) des différentes classes est :
   * Au repos :
      Classe A : 3520 (0,5 μm) et 20 (5 μm)
      Classe B : 3520 (0,5 μm) et 29 (5 μm)
      Classe C : 352 000 (0,5 μm) et 2900 (5 μm)
      Classe D : 3 520 000 (0,5 μm) et 29 000 (5μm)
   * En activité :
      Classe A : 3520 (0,5 μm) et 20 (5 μm)
      Classe B : 352 000 (0,5 μm) et 2900 (5 μm)
      Classe C : 3 520 000 (0,5 μm) et 29 000 (5μm)
      Classe D : Non défini', 'LD1.037', NULL, 'LD1.037', NULL, NULL, FALSE, 593),
('Q317', 'Q317', 33, NULL, 'La conception des ZAC permet d''atteindre les niveaux de propreté requis « au repos » (installation achevée, opérateurs absents) pour garantir les conditions « en activité » (installations en fonctionnement, opérateurs présents en nombre prévu).', 'LD1.038', NULL, 'LD1.038', NULL, NULL, FALSE, 594),
('Q318', 'Q318', 33, NULL, 'Les contrôles particulaires « au repos » sont réalisés en l''absence de personnel, après un temps d''épuration adapté aux caractéristiques de l''installation (délai défini et documenté).', 'LD1.039', NULL, 'LD1.039', NULL, NULL, FALSE, 595),
('Q319', 'Q319', 33, NULL, 'Toute ZAC contenant un ou des postes à flux d''air unidirectionnel est de classe B ou C selon le procédé, ce qui est vérifié', 'LD1.062', NULL, 'LD1.062', NULL, NULL, FALSE, 596),
('Q320', 'Q320', 33, NULL, 'Toute ZAC contenant un isolateur en pression positive est  au minimum de classe D, ce qui est vérifié', 'LD1.073', NULL, 'LD1.073', NULL, NULL, FALSE, 597),
('Q321', 'Q321', 33, NULL, 'Toute ZAC contenant un isolateur en dépression est de classe C, ce qui est vérifié.', 'LD1.081', NULL, 'LD1.081', NULL, NULL, FALSE, 598),
('Q322', 'Q322', 34, NULL, 'Les sas d''entrée et de sortie des ZAC sont identifiés comme volumes de transit entre zones de classes/risques différents, et leur conception est adaptée à cette fonction.', 'LD1.040', NULL, 'LD1.040', NULL, NULL, FALSE, 599),
('Q323', 'Q323', 34, NULL, 'L''entrée et la sortie de la ZAC se fait par des sas', 'LD1.040', NULL, 'LD1.040', NULL, NULL, FALSE, 600);
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('Q324', 'Q324', 34, NULL, 'Les sas sont intégrés à la ZAC qu''ils desservent, avec une surveillance et des contrôles identiques à ceux de la ZAC elle-même.', 'LD1.041', NULL, 'LD1.041', NULL, NULL, FALSE, 601),
('Q325', 'Q325', 34, NULL, 'Le(s) sas du personnel est (sont) distinct(s) du vestiaire du personnel', 'LD1.042', NULL, 'LD1.042', NULL, NULL, FALSE, 602),
('Q326', 'Q326', 34, NULL, 'Il existe un système d''asservissement au niveau des portes d''un sas', 'LD1.043', NULL, 'LD1.043', NULL, NULL, FALSE, 603),
('Q327', 'Q327', 34, NULL, 'Le système d''asservissement des portes du sas est testé périodiquement', 'LD1.043', NULL, 'LD1.043', NULL, NULL, FALSE, 604),
('Q328', 'Q328', 34, NULL, 'Les surfaces apparentes des ZAC (y compris plafonds) sont', 'LD1.044', NULL, 'LD1.044', NULL, NULL, TRUE, 605),
('Q328.01', 'Q328.01', 34, NULL, 'lisses', 'LD1.044', NULL, 'LD1.044', NULL, NULL, FALSE, 606),
('Q328.02', 'Q328.02', 34, NULL, 'lavables', 'LD1.044', NULL, 'LD1.044', NULL, NULL, FALSE, 607),
('Q328.03', 'Q328.03', 34, NULL, 'imperméables', 'LD1.044', NULL, 'LD1.044', NULL, NULL, FALSE, 608),
('Q328.04', 'Q328.04', 34, NULL, 'sans fissures', 'LD1.044', NULL, 'LD1.044', NULL, NULL, FALSE, 609),
('Q329', 'Q329', 34, NULL, 'Un contrôle périodique vérifie l''absence de fissures/imperfections des surfaces', '3.21', NULL, '3.21', NULL, NULL, FALSE, 610),
('Q330', 'Q330', 34, NULL, 'Il n''y a pas de carrelage', 'LD1.045', NULL, 'LD1.045', NULL, NULL, FALSE, 611),
('Q331', 'Q331', 34, NULL, 'Les plinthes sont conçues affleurantes pour limiter l''accumulation de poussières.', 'LD1.045', NULL, 'LD1.045', NULL, NULL, FALSE, 612),
('Q332', 'Q332', 34, NULL, 'Les faux plafonds sont scellés et étanches', 'LD1.046', NULL, 'LD1.046', NULL, NULL, FALSE, 613),
('Q333', 'Q333', 34, NULL, 'L''étanchéité des faux plafonds est vérifiée par un contrôle physique documenté (test de pression, inspection visuelle)', 'LD1.046', NULL, 'LD1.046', NULL, NULL, FALSE, 614),
('Q334', 'Q334', 34, NULL, 'Les canalisations et les gaines ne perturbent pas le nettoyage et leurs orifices sont scellés et étanches', 'LD1.047', NULL, 'LD1.047', NULL, NULL, FALSE, 615),
('Q335', 'Q335', 34, NULL, 'Les éviers et canalisations d''évacuation sont exclus des zones de classe A et B.', 'LD1.048', NULL, 'LD1.048', NULL, NULL, FALSE, 616),
('Q336', 'Q336', 34, NULL, 'L''alimentation en air filtré garantit en permanence une pression positive et un écart de pression compris entre 10 et 15 pascals entre locaux adjacents de classes différentes (sauf exception en cas de manipulation de produits à risque pour le personnel et l''environnement, comme les produits pulvérulents)', 'LD1.049', NULL, 'LD1.049, LD1.051', NULL, NULL, FALSE, 617),
('Q337', 'Q337', 34, NULL, 'A chaque début de session de production, le différenciel de pression est vérifié', 'LD1.157', NULL, 'LD1.157', NULL, NULL, FALSE, 618),
('Q338', 'Q338', 34, NULL, 'Le schéma aéraulique est validé comme ne présentant pas de risque de contamination (positionnement adapté des bouches de soufflage/reprise, absence d''entraînement de particules vers une zone à plus haut risque).', 'LD1.053', NULL, 'LD1.053', NULL, NULL, FALSE, 619),
('Q339', 'Q339', 34, NULL, 'L''accès aux locaux techniques ne se fait pas depuis une zone classée', 'LD1.055', NULL, 'LD1.055', NULL, NULL, FALSE, 620),
('Q340', 'Q340', 34, NULL, 'Le taux de brassage horaire d’air est connu et adapté à la taille de chaque local local ainsi qu’aux équipements et effectifs qui y sont présents', 'LD1.056', NULL, 'LD1.056', NULL, NULL, FALSE, 621),
('Q341', 'Q341', 34, NULL, 'Le système de traitement d''air est équipé de filtres appropriés type HEPA', 'LD1.056', NULL, 'LD1.056', NULL, NULL, FALSE, 622),
('Q342', 'Q342', 34, NULL, 'Le taux de renouvellement d''air est adapté et justifié au regard de l''utilisation de chaque ZAC selon  la norme EN14644', 'LD1.057', NULL, 'LD1.057', NULL, NULL, FALSE, 623),
('Q343', 'Q343', 35, NULL, 'Le système de traitement d''air permet le respect des normes environnementales et de sécurité du personnel.', 'LD1.058', NULL, 'LD1.058', NULL, NULL, FALSE, 624),
('Q344', 'Q344', 35, NULL, 'En cas de préparation en zone en dépression, la conception des locaux et des équipements permettent de s''assurer de la qualité microbiologique de la préparation réalisée.', 'LD1.059', NULL, 'LD1.059', NULL, NULL, FALSE, 625),
('Q345', 'Q345', 35, NULL, 'Il existe un local dédié ou à défaut une zone dédiée pour les préparations non stériles contenant des substances pouvant présenter un risque pour la santé et l’environnement', 'LD2.019', NULL, 'LD2.019', NULL, NULL, FALSE, 626),
('Q346', 'Q346', 35, NULL, 'La préparations des formes orales classées CMR est réalisée dans des locaux et équipents adaptés et dédiés.', '3.25', NULL, '3.25', NULL, NULL, FALSE, 627),
('Q347', 'Q347', 35, NULL, 'Le local dédié aux formes orales CMR dispose d''un confinement spécifique vérifié distinct du local des formes orales standards', '3.25', NULL, '3.25', NULL, NULL, FALSE, 628),
('Q348', 'Q348', 35, NULL, 'Il existe un local dédié pour les préparations stériles contenant des substances chimiques pouvant présenter un risque pour la santé et l’environnement', 'LD2.019', NULL, 'LD2.019', NULL, NULL, FALSE, 629),
('Q349', 'Q349', 35, NULL, 'Il existe un local dédié pour les préparations stériles contenant des substances biologiques (MTI) et chimiques non CMR', 'LD2.019', NULL, 'LD2.019', NULL, NULL, FALSE, 630),
('Q350', 'Q350', 35, NULL, 'Les équipements sont différents pour les substances biologiques (MTI) et chimiques non CMR.', 'LD2.019', NULL, 'LD2.019', NULL, NULL, FALSE, 631),
('Q351', 'Q351', 35, NULL, 'A défaut, un même équipement est utilisé pour la réalisation des préparations de substances biologiques et chimiques non CMR sous réserve d''une analyse de risque', 'LD2.019', NULL, 'LD2.019', NULL, NULL, FALSE, 632),
('Q352', 'Q352', 35, NULL, 'Il existe un local, identifié, dédié au contrôle ; a minima une zone identifiée', '3.26', NULL, '3.26, 3.28', NULL, NULL, FALSE, 633),
('Q353', 'Q353', 35, NULL, 'Les locaux et zones de contrôle sont conçus afin d''éviter les confusions et  contaminations croisées.', '3.27', NULL, '3.27', NULL, NULL, FALSE, 634),
('Q354', 'Q354', 35, NULL, 'Les locaux ou zones sont adaptés aux contrôles à réaliser', '6.15', NULL, '6.15', NULL, NULL, FALSE, 635),
('Q355', 'Q355', 35, NULL, 'La gestion des contrôles microbiologiques est réalisée dans un local dédié de l''unité ou externalisée', '3.29', NULL, '3.29', NULL, NULL, FALSE, 636),
('Q356', 'Q356', 35, NULL, 'Les locaux et zones de stockage sont conçus afin d''éviter les confusions et  contaminations croisées.', '3.22', NULL, '3.22, 3.32', NULL, NULL, FALSE, 637),
('Q357', 'Q357', 35, NULL, 'Un système et un plan de stockage et de rangement cohérents permettent de réduire le risque de confusion entre les différents produits.', '3.22', NULL, '3.22', NULL, NULL, FALSE, 638),
('Q358', 'Q358', 35, NULL, 'Les locaux et zones de stockage sont adaptés afin de respecter les différentes catégories de matériels et de produits. Il existe un local / une zone de', '3.30', NULL, '3.30, 3.33, 5.07, 5.08', NULL, NULL, TRUE, 639),
('Q358.01', 'Q358.01', 35, NULL, 'réception / décartonnage', '3.30', NULL, '3.30, 5.07, 5.08', NULL, NULL, FALSE, 640),
('Q358.02', 'Q358.02', 35, NULL, 'stockage médicaments', '3.30', NULL, '3.30, 5.07', NULL, NULL, FALSE, 641),
('Q358.03', 'Q358.03', 35, NULL, 'stockage DMS / consommables', '3.30', NULL, '3.30, 5.07', NULL, NULL, FALSE, 642),
('Q358.04', 'Q358.04', 35, NULL, 'stockage des prépations en attente de libération', '3.30', NULL, '3.30, 5.07, 5.08', NULL, NULL, FALSE, 643),
('Q358.05', 'Q358.05', 35, NULL, 'stockage préparations en attente de dispensation', '5.07', NULL, '5.07, 5.08', NULL, NULL, FALSE, 644),
('Q358.06', 'Q358.06', 35, NULL, 'quarantaine dédiée et identifiée pour les MPUP, DMS ou préparations terminées en quarantaine, refusés, retournés ou rappelés', '3.30', NULL, '3.30, 3.33, 5.07, 5.08', NULL, NULL, FALSE, 645),
('Q359', 'Q359', 35, NULL, 'Le stock de MPUP et articles de condionnement est le plus limité possible dans les locaux de préparation', '3.32', NULL, '3.32, LD2.025', NULL, NULL, FALSE, 646),
('Q360', 'Q360', 35, NULL, 'Le stock de MPUP en zone de préparation est limité à un seuil défini (quantité maximale autorisée)', '3.32', NULL, '3.32, LD2.025', NULL, NULL, FALSE, 647),
('Q361', 'Q361', 35, NULL, 'Les vestiaires sont facilement accessibles et d’une taille adaptée au nombre de personnes intervenant dans les activités de préparation.', '3.34', NULL, '3.34', NULL, NULL, FALSE, 648),
('Q362', 'Q362', 35, NULL, 'Les toilettes et les sanitaires ne communiquent pas directement avec les zones de préparation', '3.34', NULL, '3.34', NULL, NULL, FALSE, 649),
('Q363', 'Q363', 35, NULL, 'Le sas du personnel est distinct du vestiaire du personnel', 'LD1.042', NULL, 'LD1.042', NULL, NULL, FALSE, 650),
('Q364', 'Q364', 35, NULL, 'Les locaux et zones de nettoyage du matériel sont adaptés à l''activité', '3.35', NULL, '3.35', NULL, NULL, FALSE, 651),
('Q365', 'Q365', 35, NULL, 'Les zones annexes (notamment les zones techniques avec les CTA) sont facilement accessibles et ne nécessitent pas le passage par les zones classées, notamment pour leur entretien/réparation', '3.36', NULL, '3.36, LD1.097', NULL, NULL, FALSE, 652),
('Q366', 'Q366', 35, NULL, 'Les locaux intégrent un local/zone d''élimination des déchets', '3.37', NULL, '3.37', NULL, NULL, FALSE, 653),
('Q367', 'Q367', 35, NULL, 'La zone d''élimination des déchets est dimensionnée pour le volume réel généré, sans accumulation constatée lors des visites', '3.37', NULL, '3.37', NULL, NULL, FALSE, 654),
('Q368', 'Q368', 35, NULL, 'Les locaux et zones annexes sont conçus afin d''éviter les confusions et  contaminations croisées', '3.38', NULL, '3.38', NULL, NULL, FALSE, 655),
('Q369', 'Q369', 35, NULL, 'Une zone dédiée au décartonnage, distincte de la zone de préparation, est identifiée et utilisée systématiquement pour retirer les conditionnements externes avant introduction en ZAC.', 'LD1.050', NULL, 'LD1.050', NULL, NULL, FALSE, 656),
('Q370', 'Q370', 35, NULL, 'Les zones de stockage médicaments et dé-cartonnage ont un gradient de pression négatif.', 'LD1.060', NULL, 'LD1.060', NULL, NULL, FALSE, 657),
('Q371', 'Q371', 35, NULL, 'Il existe un système conforme à la réglementation en vigueur d''évacuation de l''eau et des fluides liquides contaminés afin de protéger l''environnement dans les locaux où sont manipulées des substances CMR', 'LD2.026', NULL, 'LD2.026', NULL, NULL, FALSE, 658),
('Q372', 'Q372', 35, NULL, 'Il existe une zone de nettoyage du matériel et équipements définie pour les produits à risque', 'LD2.029', NULL, 'LD2.029', NULL, NULL, FALSE, 659),
('Q373', 'Q373', 37, NULL, 'Le poste à flux d''air unidirectionnel utilisé (horizontal ou vertical) distribue l''air dans une seule direction sur toute la surface à protéger, ce qui est vérifié lors de la qualification.', 'LD1.061', NULL, 'LD1.061', NULL, NULL, FALSE, 660),
('Q374', 'Q374', 37, NULL, 'Une alimentation en air filtré maintient en permanence une pression positive pendant la préparation sous flux d''air unidirectionnel ce qui est vérifié lors de la qualification.', 'LD1.064', NULL, 'LD1.064', NULL, NULL, FALSE, 661),
('Q375', 'Q375', 37, NULL, 'Les dysfonctionnements du système de traitement d''air sont signalés par une alarme', 'LD1.065', NULL, 'LD1.065', NULL, NULL, FALSE, 662),
('Q376', 'Q376', 37, NULL, 'Une surveillance régulière des paramètres physiques (vitesse d''air, pression) est effectuée régulièrement et fait l''objet d''une traçabilité', 'LD1.066', NULL, 'LD1.066', NULL, NULL, FALSE, 663),
('Q377', 'Q377', 37, NULL, 'Une surveillance régulière des paramètres microbiologiques du poste est réalisée et fait l''objet d''une traçabilité', 'LD1.066', NULL, 'LD1.066', NULL, NULL, FALSE, 664),
('Q378', 'Q378', 38, NULL, 'En cas de préparations portant un risque pour le personnel ou l''environnement, l''utilisation d''un poste de sécurité de type II ou III est utilisé', 'LD1.067', NULL, 'LD1.067', NULL, NULL, FALSE, 665),
('Q379', 'Q379', 38, NULL, 'En cas de préparations portant un risque pour le personnel ou l''environnement, l''air extrait est rejété hors du bâtiment', 'LD1.067', NULL, 'LD1.067', NULL, NULL, FALSE, 666),
('Q380', 'Q380', 38, NULL, 'En cas de préparations portant un risque pour le personnel ou l''environnement, l''alimentation en air filtré est maintenu tout le temps de la préparation', 'LD1.067', NULL, 'LD1.067', NULL, NULL, FALSE, 667),
('Q381', 'Q381', 38, NULL, 'Le schéma aéraulique des postes utilisés pour produits à risque tient compte à la fois du risque pour l''opérateur et pour l''environnement.', 'LD1.068', NULL, 'LD1.068', NULL, NULL, FALSE, 668),
('Q382', 'Q382', 38, NULL, 'En cas de manipulation à risque de dispersion d''OGM, celles-ci ont lieu dans un PSM type II ou d''un isolateur', 'LD2.021', NULL, 'LD2.021', NULL, NULL, FALSE, 669),
('Q383', 'Q383', 38, NULL, 'La décongélation de médicaments OGM de classe de confinement > C1 ou C1, si les contenants nécessitent d’être ouverts, sont réalisées dans un PSM type II ou d''un isolateur', 'LD2.021', NULL, 'LD2.021', NULL, NULL, FALSE, 670),
('Q384', 'Q384', 39, NULL, 'Les surfaces intérieures d''un isolateur subissent régulièrement une stérilisation de contact, selon un procédé et une fréquence validés et font l''objet d''un enregistrement', 'LD1.069', NULL, 'LD1.069', NULL, NULL, FALSE, 671),
('Q385', 'Q385', 39, NULL, 'Tout objet introduit dans un isolateur est soumis à un procédé validé de stérilisation de contact (ou introduit via un dispositif double-porte à connexion étanche depuis un conditionnement stérile).', 'LD1.069', NULL, 'LD1.069', NULL, NULL, FALSE, 672),
('Q386', 'Q386', 39, NULL, 'Les dispositifs utilisés lors des préparations ou de leur contrôle sont stériles et sont introduits dans l''isolateur par un sas après un procédé validé de stérilisation de contact', 'LD1.075', NULL, 'LD1.075', NULL, NULL, FALSE, 673),
('Q387', 'Q387', 39, NULL, 'Le système de ventilation des isolateurs est autonome, pourvu en amont et en aval de filtres HEPA', 'LD1.070', NULL, 'LD1.070', NULL, NULL, FALSE, 674),
('Q388', 'Q388', 39, NULL, 'Le gradient de pression (positif ou négatif) est qualifié selon les recommandations du fabriquant', 'LD1.070', NULL, 'LD1.070', NULL, NULL, FALSE, 675),
('Q389', 'Q389', 39, NULL, 'L''étanchéité des isolateurs est régulièrement vérifiée et tracée, y compris gants et annexes', 'LD1.070', NULL, 'LD1.070, LD1.071', NULL, NULL, FALSE, 676),
('Q390', 'Q390', 39, NULL, 'Les gants des isolateurs sont changés à rythme régulier selon une fréquence définie en fonction de l''activité', 'LD1.072', NULL, 'LD1.072', NULL, NULL, FALSE, 677),
('Q391', 'Q391', 39, NULL, 'Les isolateurs sont essentiellement en pression positive et sont placés au minimum dans une ZAC de classe D', 'LD1.073', NULL, 'LD1.073', NULL, NULL, FALSE, 678),
('Q392', 'Q392', 39, NULL, 'L''agent stérilisant par contact de l''air et des surfaces de l''isolateur et de ses annexes est obligatoire', 'LD1.077', NULL, 'LD1.077', NULL, NULL, FALSE, 679),
('Q393', 'Q393', 39, NULL, 'Le procédé de stérilisation de contact des surfaces à l''intérieur de l''isolateur est validé avec des charges représentative de l''activité à l''aide des indicateurs biologiques mentionnés au chapire 5.1.2 de la Pharmacopée Européenne', 'LD1.076', NULL, 'LD1.076, LD1.078', NULL, NULL, FALSE, 680),
('Q394', 'Q394', 40, NULL, 'Pour les médicaments à risque manipulés en système clos, l''isolateur peut être placé en pression positive par rapport à l''environnement externe - ce choix est justifié.', 'LD1.079', NULL, 'LD1.079', NULL, NULL, FALSE, 681),
('Q395', 'Q395', 40, NULL, 'Les préparations réalisée selon un procédé en système ouvert et utilisant une ou plusieurs MPUP pulvérulentes sont préférentiellement réalisées dans un isolateur en pression négative par rapport à l''environnement', 'LD1.080', NULL, 'LD1.080', NULL, NULL, FALSE, 682),
('Q396', 'Q396', 40, NULL, 'Le pharmacien responsable des préparations dispose du schéma aéraulique qui tient  compte du risque pour l''opérateur et pour l''environnement.', 'LD1.082', NULL, 'LD1.082', NULL, NULL, FALSE, 683),
('Q397', 'Q397', 41, NULL, 'Les matériels, les instruments de mesure, de pesée, d’enregistrement et de contrôle présentent la précision nécessaire. Ils sont étalonnés selon la réglementation en vigueur.', '3.40', NULL, '3.40', NULL, NULL, FALSE, 684),
('Q398', 'Q398', 41, NULL, 'Les équipements et le matériel (comme par exemple les balances, les pipettes, les caméras, les automates et d’une manière générale les instruments analytiques utilisés pour le contrôle qualité et les contrôles d’environnement) sont adaptés aux contrôles à réaliser.', '6.19', NULL, '6.19', NULL, NULL, FALSE, 685),
('Q399', 'Q399', 41, NULL, 'Le versionning des logiciels métier est testé et il existe un cahier de test .', '3.41', NULL, '3.41', NULL, NULL, FALSE, 686),
('Q400', 'Q400', 41, NULL, 'La DSI porte la dynamique de sécurité et de maintenance du système informatique et des logiciels. Ils permettent la sauvegarde et l''archivage des données et le secret médical selon la législation en vigueur (loi RGPD).', '3.41', NULL, '3.41, 3.42', NULL, NULL, FALSE, 687),
('Q401', 'Q401', 41, NULL, 'La qualification de conception est systématiquement réalisée et documentée avant commande de tout nouvel équipement critique (et non après réception)', '3.46', NULL, '3.46', NULL, NULL, FALSE, 688),
('Q402', 'Q402', 41, NULL, 'Le planning annuel de qualification/contrôle/maintenance des équipements et des installations est partagé avec le PRP', '3.04', NULL, '3.04', NULL, NULL, FALSE, 689),
('Q403', 'Q403', 41, NULL, 'Le planning annuel de qualification/contrôle/maintenance des équipements et des installations est accessible avec un statut à jour (fait/à faire/en retard) consultable à tout moment', '3.04', NULL, '3.04', NULL, NULL, FALSE, 690),
('Q404', 'Q404', 41, NULL, 'Le planning annuel de qualification/contrôle/maintenance des équipements et des installations est suivi avec un taux de réalisation mesuré (échéances tenues vs reportées)', '3.04', NULL, '3.04, 3.47', NULL, NULL, FALSE, 691),
('Q405', 'Q405', 41, NULL, 'Le planning annuel de qualification/contrôle/maintenance des équipements et des installations concerne a minima', '3.04', NULL, '3.04', NULL, NULL, TRUE, 692),
('Q405.01', 'Q405.01', 41, NULL, 'les systèmes de traitement d’air et d’eau (servant à la réalisation des préparations) ;', '3.04', NULL, '3.04', NULL, NULL, FALSE, 693),
('Q405.02', 'Q405.02', 41, NULL, 'les isolateurs, postes à flux d''air unidirectionnel, enceintes blindées, stérilisateurs, automates de préparation, pompes péristaltiques (selon la situation)', '3.04', NULL, '3.04', NULL, NULL, FALSE, 694),
('Q405.03', 'Q405.03', 41, NULL, 'les balances et autres instruments de mesures, les systèmes de chauffage', '3.04', NULL, '3.04', NULL, NULL, FALSE, 695),
('Q405.04', 'Q405.04', 41, NULL, 'les instruments de contrôles', '3.04', NULL, '3.04', NULL, NULL, FALSE, 696),
('Q406', 'Q406', 41, NULL, 'Entre deux qualifications, un contrôle de paramètres clés est réalisé pour vérifier le maintien en bon état de fonctionnement de l''équipement', '3.40', NULL, '3.40, 3.49', NULL, NULL, FALSE, 697),
('Q407', 'Q407', 41, NULL, 'Les équipements et le matériel (comme par exemple les balances, les pipettes, les caméras, les automates et d’une manière générale les instruments analytiques utilisés pour le contrôle qualité et les contrôles d’environnement) sont :', '6.19', NULL, '6.19', NULL, NULL, TRUE, 698),
('Q407.01', 'Q407.01', 41, NULL, 'qualifiés initialement', '6.19', NULL, '6.19', NULL, NULL, FALSE, 699),
('Q407.02', 'Q407.02', 41, NULL, 'requalifiés périodiquement', '6.19', NULL, '6.19', NULL, NULL, FALSE, 700);
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('Q407.03', 'Q407.03', 41, NULL, 'entretenus régulièrement', '6.19', NULL, '6.19', NULL, NULL, FALSE, 701),
('Q408', 'Q408', 41, NULL, 'La verrerie utilisée pour les opérations de contrôle est vérifiée propre et adaptée avant chaque usage.', '6.20', NULL, '6.20', NULL, NULL, FALSE, 702),
('Q409', 'Q409', 42, NULL, 'L''ensemble des équipements, locaux et zones de la ZAC est requalifié au moins une fois par an, avec des requalifications intermédiaires en cas de modification.', 'LD1.091', NULL, 'LD1.091', NULL, NULL, FALSE, 703),
('Q410', 'Q410', 42, NULL, 'La qualification des équipements, locaux et zones de la ZAC est réalisée conformément aux textes, normes et référentiels en vigueur.', 'LD1.092', NULL, 'LD1.092', NULL, NULL, FALSE, 704),
('Q411', 'Q411', 42, NULL, 'Les fréquences des contrôles physiques et microbiologiques (air, surface) sont définies à l''issue de la qualification, en fonction de l''utilisation réelle et des anomalies déjà rencontrées (à défaut fréquence selon LD1 tableau 4)', 'LD1.093', NULL, 'LD1.093', NULL, NULL, FALSE, 705),
('Q412', 'Q412', 42, NULL, 'La maintenance préventive régulière, planifiée et procédurée, validée le PRP, est réalisée sans affecter le fonctionnement des ZAC', 'LD1.094', NULL, 'LD1.094', NULL, NULL, FALSE, 706),
('Q413', 'Q413', 42, NULL, 'L''équipement et le matériel d''analyse font l''objet d''un entretien permettant de maintenir leurs performances dans la durée.', '6.22', NULL, '6.22', NULL, NULL, FALSE, 707),
('Q414', 'Q414', 43, NULL, 'Les matériels et appareils sont déplaçables hors ZAC, dans la mesure du possible, pour permettre leur entretien/réparation.', 'LD1.097', NULL, 'LD1.097', NULL, NULL, FALSE, 708),
('Q415', 'Q415', 43, NULL, 'Lorsque l''entretien est réalisé en ZAC et que la propreté n''a pas pu être maintenue, un nettoyage/désinfection est réalisé jusqu''à obtention d''un niveau de propreté microbiologique adapté, avant toute réutilisation.', 'LD1.098', NULL, 'LD1.098', NULL, NULL, FALSE, 709),
('Q416', 'Q416', 43, NULL, 'Les matériels de préparation réutilisables utilisés pour la réalisation de préparations contenant des produits à risque sont identifiés et dédiés à cette activité', 'LD2.031', NULL, 'LD2.031', NULL, NULL, FALSE, 710),
('Q417', 'Q417', 44, NULL, 'L''équipement métrologique, audiovisuel et informatique introduit en ZAC est limitant en émission de particules, à surface lisse et non poreuse, nettoyable et compatible avec les produits de nettoyage/stérilisation de contact.', 'LD1.099', NULL, 'LD1.099', NULL, NULL, FALSE, 711),
('Q418', 'Q418', 44, NULL, 'Le cablâge des appareils dans la ZAC est compatible avec le bionettoyage', 'LD1.100', NULL, 'LD1.100', NULL, NULL, FALSE, 712),
('Q419', 'Q419', 45, NULL, 'Il existe un système de communication fonctionnel entre les zones', 'LD1.101', NULL, 'LD1.101', NULL, NULL, FALSE, 713),
('Q420', 'Q420', 47, NULL, 'Il existe d''enregistrements relatifs aux opérations de nettoyage et désinfection (locaux ou des zones, équipement, appareils', 'LD1.083', NULL, 'LD1.083, LD1.087', NULL, NULL, FALSE, 714),
('Q421', 'Q421', 47, NULL, 'Pour chaque opération est portée mention de la date, de l''opérateur et/ou  du nom de la societé en cas d’intervention extérieure.', 'LD1.083', NULL, 'LD1.083, LD1.087', NULL, NULL, FALSE, 715),
('Q422', 'Q422', 47, NULL, 'La solution désinfectante ainsi que son système de dispersion ou diffusion est validé par le PRP (efficacité, spectre d''action, absence de résidu).', 'LD1.084', NULL, 'LD1.084', NULL, NULL, FALSE, 716),
('Q423', 'Q423', 47, NULL, 'Les résultats des contrôles microbiologiques sont disponibles et accessibles en moins de 5 min en cas de contrôle', 'LD1.085', NULL, 'LD1.085', NULL, NULL, FALSE, 717),
('Q424', 'Q424', 47, NULL, 'L''analyse régulière des résultats des prélèvement microbiologiques des ZAC est effective', 'LD1.085', NULL, 'LD1.085', NULL, NULL, FALSE, 718),
('Q425', 'Q425', 48, NULL, 'La stérilisation de contact ne se substitue pas au nettoyage/désinfection, qui reste systématiquement réalisé.', 'LD1.090', NULL, 'LD1.090', NULL, NULL, FALSE, 719),
('Q426', 'Q426', 50, NULL, 'Les opérations aseptiques sont surveillées en activité par des contrôles microbiologiques adaptés, permettant de détecter tout niveau inhabituel de contamination.', 'LD1.149', NULL, 'LD1.149', NULL, NULL, FALSE, 720),
('Q427', 'Q427', 50, NULL, 'Les méthodes d’échantillonnage utilisées en activité n’interférent avec la protection des zones.', 'LD1.151', NULL, 'LD1.151', NULL, NULL, FALSE, 721),
('Q428', 'Q428', 50, NULL, 'Le procédé de stérilisation de contact ne modifie pas la qualité des milieux de culture utilisés.', 'LD1.152', NULL, 'LD1.152', NULL, NULL, FALSE, 722),
('Q429', 'Q429', 51, NULL, 'Le bon fonctionnement des sas (et autres dispositifs de transfert) est vérifié lors des qualifications et après toute intervention sur le système & est tracé', 'LD1.156', NULL, 'LD1.156', NULL, NULL, FALSE, 723),
('Q430', 'Q430', 51, NULL, 'Les essais de laminarité, vitesse, débit et intégrité des filtres sont tracés', 'LD1.158', NULL, 'LD1.158', NULL, NULL, FALSE, 724),
('Q431', 'Q431', 51, NULL, 'La présence physique et le bon fonctionnement des EPC adaptés sont vérifiés régulièrement pour chaque local concerné', 'LD2.032', NULL, 'LD2.032', NULL, NULL, FALSE, 725),
('Q432', 'Q432', 51, NULL, 'Les préparations pulvérulentes non stériles sont réalisées dans des enceintes ventilées aspirantes ou des isolateurs (ou boîtes à gants). L’environnement immédiat à cet équipement peut être non classé.', 'LD2.033', NULL, 'LD2.033', NULL, NULL, FALSE, 726),
('Q433', 'Q433', 51, NULL, 'Les filtres des EPC sont changés en limitant la contamination lors des opérations de maintenance (sac étanche par exemple)', 'LD2.034', NULL, 'LD2.034', NULL, NULL, FALSE, 727),
('Q434', 'Q434', 51, NULL, 'Les filtres des EPC (HEPA et/ou charbon) font l''objet d''un suivi et d''une maintenance', 'LD2.035', NULL, 'LD2.035', NULL, NULL, FALSE, 728),
('Q435', 'Q435', 51, NULL, 'Au repos, la surveillance régulière des zones permettant de vérifier la qualité particulaire correspondant à leur classe est effective', 'LD1.159', NULL, 'LD1.159', NULL, NULL, FALSE, 729),
('Q436', 'Q436', 52, NULL, 'Les MPUP et les articles de conditionnement réceptionnés et les préparations terminées sont mis en quarantaine physiquement, et informatiquement le cas échéant, immédiatement après leur réception ou leur préparation.', '5.08', NULL, '5.08', NULL, NULL, FALSE, 730),
('Q437', 'Q437', 52, NULL, 'Les MPUP et DM sont manipulés, transportés et stockés de manière à conserver leur qualité jusqu''à péremption', '1.07', NULL, '1.07', NULL, NULL, FALSE, 731),
('Q438', 'Q438', 52, NULL, 'Seuls des MPUP et des articles de conditionnement approuvés et libérés en vue de leur usage sont employés pour la préparation', '5.09', NULL, '5.09', NULL, NULL, FALSE, 732),
('Q439', 'Q439', 52, NULL, 'La conformité à l''article L. 5121-6 est vérifiée et tracée individuellement pour chaque lot de MPUP reçu', '5.29', NULL, '5.29', NULL, NULL, FALSE, 733),
('Q440', 'Q440', 52, NULL, 'Les articles de conditionnement bénéficient du même circuit de contrôle (réception, conservation, libération) que les MPUP, avec un statut « libéré » formalisé avant utilisation.', '5.32', NULL, '5.32', NULL, NULL, FALSE, 734),
('Q441', 'Q441', 52, NULL, 'L''état de propreté (et de stérilité le cas échéant) des matériels est vérifié avant usage.', '5.11', NULL, '5.11', NULL, NULL, FALSE, 735),
('Q442', 'Q442', 52, NULL, 'Les matériels sont conservés à l''abri de l''humidité et de la poussière', '5.11', NULL, '5.11', NULL, NULL, FALSE, 736),
('Q443', 'Q443', 52, NULL, 'Pour les opérations de préparation ou de conditionnement où cela se justifie, les rendements sont contrôlés et des bilans comparatifs effectués pour assurer qu’il n’y a pas d’écarts supérieurs aux limites acceptables définies par les spécifications (cf. Annexe II partie 3).', '5.12', NULL, '5.12', NULL, NULL, FALSE, 737),
('Q444', 'Q444', 52, NULL, 'Les MPUP, les articles de conditionnement et les préparations terminées ou non sont clairement étiquetés à chaque étape de la préparation', '5.16', NULL, '5.16', NULL, NULL, TRUE, 738),
('Q444.01', 'Q444.01', 52, NULL, 'réception', '5.16', NULL, '5.16', NULL, NULL, FALSE, 739),
('Q444.02', 'Q444.02', 52, NULL, 'stockage prépation en attente de contrôle', '5.16', NULL, '5.16', NULL, NULL, FALSE, 740),
('Q444.03', 'Q444.03', 52, NULL, 'stockage prépation en attente de libération', '5.16', NULL, '5.16', NULL, NULL, FALSE, 741),
('Q444.04', 'Q444.04', 52, NULL, 'stockage préparations en attente de dispensation', '5.16', NULL, '5.16', NULL, NULL, FALSE, 742),
('Q444.05', 'Q444.05', 52, NULL, 'quarantaine dédiée et identifiée pour les MPUP, DMS ou préparations terminées en quarantaine, refusés, retournés ou rappelés', '5.16', NULL, '5.16', NULL, NULL, FALSE, 743),
('Q445', 'Q445', 52, NULL, 'Toutes les mesures techniques et organisationnelles nécessaires sont prises pour éviter les contaminations croisées.', '5.17', NULL, '5.17', NULL, NULL, FALSE, 744),
('Q446', 'Q446', 52, NULL, 'Les procédés de préparation sont validées et peuvent faire appel à des contrôles d''environnement adaptés', 'LD2.043', NULL, 'LD2.043', NULL, NULL, FALSE, 745),
('Q447', 'Q447', 52, NULL, 'Les validations sont réexaminées à intervalles définis pour vérifier qu''elles restent valables, avec revalidation complète en cas d''accumulation de modifications mineures.', '5.25', NULL, '5.25', NULL, NULL, FALSE, 746),
('Q448', 'Q448', 52, NULL, 'Tous les composants d''une préparation (la ou les substances actives, le ou les excipients et les éléments de mise en forme pharmaceutique comme les gélules vides) sont considérés comme MPUP', '5.26', NULL, '5.26', NULL, NULL, FALSE, 747),
('Q449', 'Q449', 52, NULL, 'Les MPUP cédées à la pharmacie sont  à usage pharmaceutique', '5.27', NULL, '5.27', NULL, NULL, FALSE, 748),
('Q450', 'Q450', 52, NULL, 'La vérification de la conformité du certificat d''analyse des MPUP est enregistrée', '5.28', NULL, '5.28', NULL, NULL, FALSE, 749),
('Q451', 'Q451', 52, NULL, 'Les MPUP sont conservées dans leur récipient d''origine', '5.30', NULL, '5.30', NULL, NULL, FALSE, 750),
('Q452', 'Q452', 52, NULL, 'En cas de transvasement exceptionnel, le récipient de destination est équivalent, propre et étiqueté (lot, péremption, fabricant), et le mélange de lots est exclu.', '5.30', NULL, '5.30', NULL, NULL, FALSE, 751),
('Q453', 'Q453', 52, NULL, 'La date d''ouverture et de péremption après ouverture de la MPUP sont consignées sur le conditionnement primaire', '5.31', NULL, '5.31', NULL, NULL, FALSE, 752),
('Q454', 'Q454', 52, NULL, 'Les MPUP utilisées sont préférentiellement des spécialités pharmaceutiques stériles ; à défaut, leur conformité à la Pharmacopée (contamination microbiologique initiale, endotoxines) est vérifiée et documentée.', 'LD1.124', NULL, 'LD1.124', NULL, NULL, FALSE, 753),
('Q455', 'Q455', 52, NULL, 'Pour les préparations à partir de MPUP non stériles, le niveau de contamination initiale est évalué et démontré minimal avant utilisation.', 'LD1.125', NULL, 'LD1.125', NULL, NULL, FALSE, 754),
('Q456', 'Q456', 52, NULL, 'Les articles de conditionnement primaire utilisés sont stériles, apyrogènes, et adaptés à leur usage.', 'LD1.127', NULL, 'LD1.127', NULL, NULL, FALSE, 755),
('Q457', 'Q457', 52, NULL, 'Lorsqu''un matériel non stérile est utilisé pour une préparation stérile, un procédé de stérilisation est adapté est appliqué', 'LD1.134', NULL, 'LD1.134', NULL, NULL, FALSE, 756),
('Q458', 'Q458', 52, NULL, 'Les opérations de vide de ligne et de nettoyage des équipements et locaux sont tracées et vérifiées avant toute opération de préparation (type check list)', '5.35', NULL, '5.35, 5.54', NULL, NULL, FALSE, 757),
('Q459', 'Q459', 52, NULL, 'La conformité des contrôles de l''environnement avant manipulation puis conditionnement est vérifiée et tracée (type check list)', '5.36', NULL, '5.36, 5.55, 5.58', NULL, NULL, FALSE, 758),
('Q460', 'Q460', 52, NULL, 'Un/des dispositif(s) de récupération des déchets, correctement identifié, prêt à l''utilisation, est mis à disposition dans la zone de préparation', '5.37', NULL, '5.37', NULL, NULL, TRUE, 759),
('Q460.01', 'Q460.01', 52, NULL, 'pour les déchets concentrés', '5.37', NULL, '5.37', NULL, NULL, FALSE, 760),
('Q460.02', 'Q460.02', 52, NULL, 'pour les déchets dilués et le matériel utilisé en contact avec un cytotoxique', '5.37', NULL, '5.37', NULL, NULL, FALSE, 761),
('Q460.03', 'Q460.03', 52, NULL, 'pour les DAOM', '5.37', NULL, '5.37', NULL, NULL, FALSE, 762),
('Q461', 'Q461', 52, NULL, 'L''opérateur rassemble systématiquement, avant de débuter, l''ensemble des MPUP, articles de conditionnement, matériels et documents valides nécessaires à la préparation.', '5.38', NULL, '5.38', NULL, NULL, FALSE, 763),
('Q462', 'Q462', 52, NULL, 'L''opérateur vérifie systématiquement, avant de débuter, les MPUP et le matériel', '5.39', NULL, '5.39', NULL, NULL, TRUE, 764),
('Q462.01', 'Q462.01', 52, NULL, 'Dénomination (DCI ou non commercial)', '5.39', NULL, '5.39', NULL, NULL, FALSE, 765),
('Q462.02', 'Q462.02', 52, NULL, 'Dosage', '5.39', NULL, '5.39', NULL, NULL, FALSE, 766),
('Q462.03', 'Q462.03', 52, NULL, 'Forme pharmaceutique', '5.39', NULL, '5.39', NULL, NULL, FALSE, 767),
('Q462.04', 'Q462.04', 52, NULL, 'Lot', '5.39', NULL, '5.39', NULL, NULL, FALSE, 768),
('Q462.05', 'Q462.05', 52, NULL, 'Péremption', '5.39', NULL, '5.39', NULL, NULL, FALSE, 769),
('Q462.06', 'Q462.06', 52, NULL, 'Qualités organoleptiques', '5.39', NULL, '5.39', NULL, NULL, FALSE, 770),
('Q462.06.01', 'Q462.06.01', 52, NULL, 'Limpidité en cas de solution', '5.39', NULL, '5.39', NULL, NULL, FALSE, 771),
('Q462.06.02', 'Q462.06.02', 52, NULL, 'Absence de particule ou de précipité visible en cas de solution', '5.39', NULL, '5.39', NULL, NULL, FALSE, 772),
('Q462.06.03', 'Q462.06.03', 52, NULL, 'Absence de changement de coloration', '5.39', NULL, '5.39', NULL, NULL, FALSE, 773),
('Q462.06.04', 'Q462.06.04', 52, NULL, 'Absence de déphasage en cas d''émulsion', '5.39', NULL, '5.39', NULL, NULL, FALSE, 774),
('Q462.06.05', 'Q462.06.05', 52, NULL, 'Etat physique des poudres', '5.39', NULL, '5.39', NULL, NULL, FALSE, 775),
('Q462.07', 'Q462.07', 52, NULL, 'Intégrité des emballages pour les produits stériles', '5.39', NULL, '5.39', NULL, NULL, FALSE, 776),
('Q462.08', 'Q462.08', 52, NULL, 'Date de péremption de la stérilité des emballages', '5.39', NULL, '5.39', NULL, NULL, FALSE, 777),
('Q462.09', 'Q462.09', 52, NULL, 'Reliquats (le cas échéant) : dénomination, dosage, forme pharmaceutique, lot, péremption', '5.39', NULL, '5.39', NULL, NULL, FALSE, 778),
('Q463', 'Q463', 52, NULL, 'Le matériel de pesée/mesure de volume utilisé a une portée et une sensibilité adaptées aux masses/volumes réellement mesurés.', '5.41', NULL, '5.41, 5.42', NULL, NULL, FALSE, 779),
('Q464', 'Q464', 52, NULL, 'L''identité et la quantité (masse/volume) de chaque MPUP sont vérifiées (double contrôle ou autre dispositif d''enregistrement automatique validé), et cette vérification est tracée dans le dossier de lot au moment de l''utilisation de la MPUP.', '5.44', NULL, '5.44', NULL, NULL, FALSE, 780),
('Q465', 'Q465', 52, NULL, 'La pesée/mesure des MPUP est réalisée sans altérer leurs qualités physico-chimiques/microbiologiques ni leur stérilité, et sans créer de risque de contamination de l''environnement.', '5.45', NULL, '5.45', NULL, NULL, FALSE, 781),
('Q466', 'Q466', 52, NULL, 'Le délai entre la mesure des quantités/volumes et la réalisation de la préparation est réduit au minimum afin de ne pas porter atteinte à l''intégrité du produit.', '5.46', NULL, '5.46', NULL, NULL, FALSE, 782),
('Q467', 'Q467', 52, NULL, 'La préparation est réalisée en stricte conformité avec les instructions du dossier de préparation (composition qualitative et quantitative détaillée).', '5.47', NULL, '5.47', NULL, NULL, FALSE, 783),
('Q468', 'Q468', 52, NULL, 'Pour les préparations orales pulvérulentes à partir d''une spécialité autorisée, l''excipient majoritaire de la formulation est privilégié comme diluant, avec une justification en cas d''écart.', '5.48', NULL, '5.48', NULL, NULL, FALSE, 784),
('Q469', 'Q469', 52, NULL, 'La préparation est réalisée en continu jusqu''à son terme, sans conservation à un stade intermédiaire sauf justification technique documentée ; le cas échéant, le conditionnement intermédiaire est étiqueté de façon à permettre son identification précise.', '5.50', NULL, '5.50', NULL, NULL, FALSE, 785),
('Q470', 'Q470', 52, NULL, 'L''identification des contenant est apposée dès la fin du remplissage/fermeture des récipients (ou selon une méthode garantissant une sécurité équivalente), afin d''éviter toute confusion (par exemple : préparation en cours, préparation en attente de contrôle).', '5.51', NULL, '5.51, 5.52', NULL, NULL, FALSE, 786),
('Q471', 'Q471', 52, NULL, 'Les résidus restant après préparation sont détruits conformément à la réglementation en vigueur, avec traçabilité de la destruction', '5.53', NULL, '5.53', NULL, NULL, FALSE, 787),
('Q472', 'Q472', 52, NULL, 'Les opérations de conditionnementles sont respectées et enregistrées dans le dossier de préparation', '5.56', NULL, '5.56', NULL, NULL, FALSE, 788),
('Q473', 'Q473', 52, NULL, 'L''identité et l''état de propreté des articles de conditionnement sont vérifiés avant leur utilisation.', '5.57', NULL, '5.57', NULL, NULL, FALSE, 789),
('Q474', 'Q474', 52, NULL, 'Un bilan comparatif est réalisé en fin de conditionnement, avec destruction tracée de l''excédent d''articles pré-imprimés le cas échéant.', '5.59', NULL, '5.59', NULL, NULL, FALSE, 790),
('Q475', 'Q475', 52, NULL, 'L’intervalle de temps entre le début de la préparation et le conditionnement est le plus court possible', 'LD2.046', NULL, 'LD2.046', NULL, NULL, FALSE, 791),
('Q476', 'Q476', 52, NULL, 'Les préparations sont placées dans un conditionnement primaire étanche', 'LD2.047', NULL, 'LD2.047', NULL, NULL, FALSE, 792),
('Q477', 'Q477', 52, NULL, 'La fermeture du conditionnement primaire est vérifiée', 'LD2.048', NULL, 'LD2.048', NULL, NULL, FALSE, 793),
('Q478', 'Q478', 52, NULL, 'Le transport est sécurisé (contenant étanches, maintien de la t°…) et conforme à la réglementation en vigueur', 'LD2.051', NULL, 'LD2.051', NULL, NULL, FALSE, 794),
('Q479', 'Q479', 52, NULL, 'Le conditionnement (et l''emballage extérieur le cas échéant) garantit l''intégrité de la préparation pendant l''acheminement, dans le respect des conditions de conservation définies au dossier de préparation.', '5.60', NULL, '5.60', NULL, NULL, FALSE, 795),
('Q480', 'Q480', 52, NULL, 'L''acheminement hors du site de production est réalisé en tenant compte des conditions de conservation telles que définies dans le dossier de préparation', '5.60', NULL, '5.60', NULL, NULL, FALSE, 796),
('Q481', 'Q481', 52, NULL, 'Les préparations retournées directement par les patients sont exclues de la réattribution.', '5.62', NULL, '5.62', NULL, NULL, FALSE, 797),
('Q482', 'Q482', 52, NULL, 'La réattribution s''appuie sur une nouvelle prescription.', '5.64', NULL, '5.64', NULL, NULL, FALSE, 798),
('Q483', 'Q483', 52, NULL, 'La réattribution nécessite la mise en place d’une gestion et d’une traçabilité spécifique des préparations concernées.', '5.64', NULL, '5.64', NULL, NULL, FALSE, 799),
('Q484', 'Q484', 52, NULL, 'La réattribution est documentée dans le ou les dossiers de lot des préparations correspondantes.', '5.64', NULL, '5.64', NULL, NULL, FALSE, 800);
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('Q485', 'Q485', 52, NULL, 'Pour les préparations à conditions de conservation particulières l''absence de rupture de la chaîne de conservation est vérifiée et tracée avant réattribution.', '5.65', NULL, '5.65', NULL, NULL, FALSE, 801),
('Q486', 'Q486', 52, NULL, 'La réattribution des préparations fait l''objet d''un ré-etiquettage', '5.66', NULL, '5.66', NULL, NULL, FALSE, 802),
('Q487', 'Q487', 52, NULL, 'Le ré-etiquettage d''une préparation réattribuée fait l''objet d''un contrôle et est enregistré dans le dossier de lot', '5.66', NULL, '5.66', NULL, NULL, FALSE, 803),
('Q488', 'Q488', 52, NULL, 'La réattribution des préparations fait l''objet d''un enregistrement', '5.66', NULL, '5.66', NULL, NULL, FALSE, 804),
('Q489', 'Q489', 52, NULL, 'La nécessité de contrôles supplémentaires avant réattribution est évaluée par la personne responsable du contrôle (et le cas échéant de la préparation).', '5.67', NULL, '5.67', NULL, NULL, FALSE, 805),
('Q490', 'Q490', 52, NULL, 'La décision de libération d''une préparation réattribuée est prise par la personne habilitée après examen de tous les documents pertinents, et enregistrée dans le dossier de lot.', '5.68', NULL, '5.68', NULL, NULL, FALSE, 806),
('Q491', 'Q491', 53, NULL, 'Le contrôle de la qualité pharmaceutique mis en œuvre pour déterminer la conformité aux caractéristiques attendues et prendre une décision d’acceptation ou de refus s''applique à chaque', '6.01', NULL, '6.01, 1.08', NULL, NULL, TRUE, 807),
('Q491.01', 'Q491.01', 53, NULL, 'MPUP et  articles de conditionnement', '6.01', NULL, '6.01, 1.08', NULL, NULL, FALSE, 808),
('Q491.02', 'Q491.02', 53, NULL, 'préparations en cours de réalisation', '6.01', NULL, '6.01, 1.08', NULL, NULL, FALSE, 809),
('Q491.03', 'Q491.03', 53, NULL, 'préparations utilisées pour la réalisation d’autres préparations', '6.01', NULL, '6.01, 1.08', NULL, NULL, FALSE, 810),
('Q491.04', 'Q491.04', 53, NULL, 'préparations terminées', '6.01', NULL, '6.01, 1.08', NULL, NULL, FALSE, 811),
('Q492', 'Q492', 53, NULL, 'Le contrôle de la qualité concerne', '1.08', NULL, '1.08, 6.02', NULL, NULL, TRUE, 812),
('Q492.01', 'Q492.01', 53, NULL, 'l''échantillonnage (MPUP, articles de conditionnement, poche mère sur certains robots, préparations terminées', '1.08', NULL, '1.08, 6.02', NULL, NULL, FALSE, 813),
('Q492.02', 'Q492.02', 53, NULL, 'les spécifications et le contrôle', '1.08', NULL, '1.08, 6.02', NULL, NULL, FALSE, 814),
('Q492.03', 'Q492.03', 53, NULL, 'l’organisation, l’établissement des documents et des procédures de libération', '6.02', NULL, '6.02', NULL, NULL, FALSE, 815),
('Q493', 'Q493', 53, NULL, 'Chacune des étapes du cycle de contrôle est effectivement mise en œuvre et tracée', '6.03', NULL, '6.03', NULL, NULL, TRUE, 816),
('Q493.01', 'Q493.01', 53, NULL, 'réception des MPUP, articles de conditionnements, préparations sous-traitées,…', '6.03', NULL, '6.03', NULL, NULL, FALSE, 817),
('Q493.02', 'Q493.02', 53, NULL, 'contrôle en cours de préparation', '6.03', NULL, '6.03', NULL, NULL, FALSE, 818),
('Q493.03', 'Q493.03', 53, NULL, 'contrôle des préparations pharmaceutiques terminées', '6.03', NULL, '6.03', NULL, NULL, FALSE, 819),
('Q493.04', 'Q493.04', 53, NULL, 'contrôle libératoires', '6.03', NULL, '6.03', NULL, NULL, FALSE, 820),
('Q493.05', 'Q493.05', 53, NULL, 'contrôle de stabilité des préparation et d''absence d''interactions contenant/contenu (le cas échéant)', '6.03', NULL, '6.03', NULL, NULL, FALSE, 821),
('Q494', 'Q494', 53, NULL, 'Ne sont libérées que les MPUP (préparations particulières type ONC21), les articles de conditionnement, les produits intermédiaires, les préparations utilisées pour la réalisation d’autres préparations et les préparations terminées ayant été vérifiés et conformes aux spécifications requises', '1.08', NULL, '1.08, 1.07, 6.02', NULL, NULL, FALSE, 822),
('Q495', 'Q495', 53, NULL, 'La nature des contrôles à effectuer est définie pour chaque préparation', '1.09', NULL, '1.09', NULL, NULL, FALSE, 823),
('Q496', 'Q496', 53, NULL, 'Les contrôles sont justifiés par l''analyse de risque réalisée pour chaque préparation (cf. annexe BPP)', '1.09', NULL, '1.09', NULL, NULL, FALSE, 824),
('Q497', 'Q497', 53, NULL, 'L''éventail des contrôles mobilisables est défini par type de préparation, avec une justification du choix retenu dans chaque cas :', '6.04', NULL, '6.04', NULL, NULL, TRUE, 825),
('Q497.01', 'Q497.01', 53, NULL, 'contrôles de recevabilité documentaire (MPUP, réactifs, étalons de référence…)', '6.04', NULL, '6.04', NULL, NULL, FALSE, 826),
('Q497.02', 'Q497.02', 53, NULL, 'contrôles physico-chimiques', '6.04', NULL, '6.04', NULL, NULL, FALSE, 827),
('Q497.03', 'Q497.03', 53, NULL, 'contrôles pharmacotechniques', '6.04', NULL, '6.04', NULL, NULL, FALSE, 828),
('Q497.04', 'Q497.04', 53, NULL, 'contrôles microbiologiques', '6.04', NULL, '6.04', NULL, NULL, FALSE, 829),
('Q497.05', 'Q497.05', 53, NULL, 'contrôles de radioactivité le cas échéant', '6.04', NULL, '6.04', NULL, NULL, FALSE, 830),
('Q497.06', 'Q497.06', 53, NULL, 'contrôles de l’environnement (air, surfaces, eau)', '6.04', NULL, '6.04', NULL, NULL, FALSE, 831),
('Q497.07', 'Q497.07', 53, NULL, 'tous autres contrôles jugés nécessaires', '6.04', NULL, '6.04', NULL, NULL, FALSE, 832),
('Q498', 'Q498', 53, NULL, 'En cas de non-conformité par rapport aux spécifications requises des réclamations et analyses sont effectuées pour prendre des mesures correctrices adaptées (le cas échéant)', '1.07', NULL, '1.07', NULL, NULL, FALSE, 833),
('Q499', 'Q499', 53, NULL, 'La pharmacie dispose d''accès à la dernière version de : ''Pharmacopée Européenne (référentiel officiel) et/ou Pharmacopée Française, dont le Formulaire National (référentiel officiel) et ou Pharmacopées des autres états membres de l''UE et ou Pharmacopées d''états hors UE et ou en l''absence de référentiel disponible : méthodes internes et/ou méthodes fournisseurs et/ou méthodes décrites dans la littérature', '6.05', NULL, '6.05, 6.06, 6.07, 6.08', NULL, NULL, FALSE, 834),
('Q500', 'Q500', 53, NULL, 'Les méthodes analytiques issues de référentiels officiels font l''objet d''une phase de mise en œuvre technique documentée au sein de l''établissement avant utilisation en routine.', '6.09', NULL, '6.09', NULL, NULL, FALSE, 835),
('Q501', 'Q501', 53, NULL, 'Les méthodes de contrôle non officielles sont validées selon un référentiel reconnu (ex. ICH Q2), avec un dossier de validation disponible.', '6.10', NULL, '6.10', NULL, NULL, FALSE, 836),
('Q502', 'Q502', 53, NULL, 'Les contrôles d''environnement s''appuient sur des référentiels adaptés et identifiés (normes ISO NF ISO 14644 et NF ISO 14698, recommandations spécifiques).', '6.11', NULL, '6.11', NULL, NULL, FALSE, 837),
('Q503', 'Q503', 53, NULL, 'En cas de sous-traitance des contrôles, ce recours est mentionné dans le dossier de préparation', '6.12', NULL, '6.12', NULL, NULL, FALSE, 838),
('Q504', 'Q504', 53, NULL, 'Il existe une convention de sous-traitance des contrôles', '6.12', NULL, '6.12', NULL, NULL, FALSE, 839),
('Q505', 'Q505', 53, NULL, 'Le périmètre du contrôle couvre systématiquement la/les substance(s) active(s), le/les excipient(s), le/les produit(s) intermédiaire(s), la préparation terminée et les articles de conditionnement.', '6.13', NULL, '6.13', NULL, NULL, FALSE, 840),
('Q506', 'Q506', 53, NULL, 'L''organisation garantit une indépendance effective entre l''activité de contrôle et l''activité de préparation', '6.14', NULL, '6.14', NULL, NULL, FALSE, 841),
('Q507', 'Q507', 53, NULL, 'Sauf exception justifiée et documentée, le contrôle est systématiquement réalisé par une personne différente de celle ayant réalisé la préparation.', '6.18', NULL, '6.18', NULL, NULL, FALSE, 842),
('Q508', 'Q508', 55, NULL, 'Les contrôles analytiques se font à l''aide d''étalons de références', '6.23', NULL, '6.23', NULL, NULL, FALSE, 843),
('Q509', 'Q509', 55, NULL, 'Les étalons primaires qualifiés et certifiés sont utilisés en priorité ; les étalons secondaires éventuellement utilisés sont qualifiés par rapport à un étalon primaire officiel.', '6.24', NULL, '6.24', NULL, NULL, FALSE, 844),
('Q510', 'Q510', 55, NULL, 'Des étalons secondaires sont  éventuellement utilisés s''ils sont qualifiés par rapport à un étalon primaire officiel.', '6.24', NULL, '6.24', NULL, NULL, FALSE, 845),
('Q511', 'Q511', 55, NULL, 'Chaque étalon de référence dispose d''un dossier comportant son certificat d''origine (étalon primaire)', '6.25', NULL, '6.25', NULL, NULL, FALSE, 846),
('Q512', 'Q512', 55, NULL, 'Chaque étalon secondaire dispose d''un dossier comportant les comptes rendus d''analyse d''étalonnage (étalon secondaire).', '6.25', NULL, '6.25', NULL, NULL, FALSE, 847),
('Q513', 'Q513', 55, NULL, 'La réalisation d''une solution titrée et de chaque réactif est associée à une fiche comportant :', '6.27', NULL, '6.27', NULL, NULL, TRUE, 848),
('Q513.01', 'Q513.01', 55, NULL, 'identification de l''opérateur ayant réalisé l''opération', '6.27', NULL, '6.27', NULL, NULL, FALSE, 849),
('Q513.02', 'Q513.02', 55, NULL, 'la date de la réalisation', '6.27', NULL, '6.27', NULL, NULL, FALSE, 850),
('Q513.03', 'Q513.03', 55, NULL, 'les quantités/volumes exacts mis en œuvre', '6.27', NULL, '6.27', NULL, NULL, FALSE, 851),
('Q513.04', 'Q513.04', 55, NULL, 'date limite de validité', '6.27', NULL, '6.27', NULL, NULL, FALSE, 852),
('Q513.05', 'Q513.05', 55, NULL, 'étiquetage conforme', '6.27', NULL, '6.27', NULL, NULL, FALSE, 853),
('Q514', 'Q514', 55, NULL, 'La documentation du contrôle de la qualité suit les principes énoncés au chapitre 4', '6.28', NULL, '6.28', NULL, NULL, FALSE, 854),
('Q515', 'Q515', 55, NULL, 'Les rapports ou certificats d''analyse avec les résultats sont conservés et accessibles', '6.29', NULL, '6.29', NULL, NULL, FALSE, 855),
('Q516', 'Q516', 55, NULL, 'Les rapports ou certificats de validation des méthodes de contrôle sont accessibles à tout moment', '6.29', NULL, '6.29', NULL, NULL, FALSE, 856),
('Q517', 'Q517', 55, NULL, 'Les enregistrements concernant l''étalonnage, la qualification et la maintenance des équipements de contrôle sont accesibles', '6.29', NULL, '6.29', NULL, NULL, FALSE, 857),
('Q518', 'Q518', 55, NULL, 'Les enregistrements des résultats des contrôles de l''environnement sont accessibles', '6.29', NULL, '6.29', NULL, NULL, FALSE, 858),
('Q519', 'Q519', 57, NULL, 'Le numéro d''enregistrement à réception de la MPUP est reporté sur le conditionnement primaire.', '6.32', NULL, '6.32', NULL, NULL, FALSE, 859),
('Q520', 'Q520', 57, NULL, 'En cas de réception de plusieurs lots, ceux-ci sont considérés individuellement pour l’enregistrement, l’échantillonnage, le contrôle et l’acceptation.', '6.32', NULL, '6.32', NULL, NULL, FALSE, 860),
('Q521', 'Q521', 57, NULL, 'La décision d''acceptation des MPUP et des articles de contionnement est faite par un pharmacien et enregistré sur le registre manuscrit ou informatisé d''entrée des MPUP', '6.33', NULL, '6.33', NULL, NULL, FALSE, 861),
('Q522', 'Q522', 57, NULL, 'Le statut de la MPUP (acceptation) est reporté sur l’étiquetage du récipient en contact avec la MPUP.', '6.33', NULL, '6.33', NULL, NULL, FALSE, 862),
('Q523', 'Q523', 57, NULL, 'La décision d''un refus par le pharmacien subit le même traitement qu''une mention d''acceptation', '6.34', NULL, '6.34', NULL, NULL, FALSE, 863),
('Q524', 'Q524', 57, NULL, 'En cas de refus de la réception, la procédure prévoit un renvoi au fournisseur dans les plus brefs délais ou une destruction après autorisation du fournisseur, avec génération d''un certificat de destruction', '6.35', NULL, '6.35', NULL, NULL, FALSE, 864),
('Q525', 'Q525', 57, NULL, 'Les produits refusés sont stockés dans l''intervalle dans une zone isolée avec étiquette « produit refusé ».', '6.35', NULL, '6.35', NULL, NULL, FALSE, 865),
('Q526', 'Q526', 57, NULL, 'La source d''approvisionnement des MPUP est prise en compte comme un des paramètres critiques pour orienter le niveau de contrôle', '6.36', NULL, '6.36', NULL, NULL, FALSE, 866),
('Q527', 'Q527', 57, NULL, 'Les MPUP sont répertoriées en 3 catégories selon leur provenance et leurs caractéristiques, et les contrôles à réaliser sont définis pour chaque catégorie', '6.37', NULL, '6.37', NULL, NULL, FALSE, 867),
('Q528', 'Q528', 58, NULL, 'Pour les MPUP éligibles à la 1ère catégorie, l''ensemble des critères requis (établissement autorisé/déclaré, certificat BPP, système d''inviolabilité, certificat d''analyse du lot) est vérifié et documenté.', '6.38', NULL, '6.38', NULL, NULL, FALSE, 868),
('Q529', 'Q529', 58, NULL, 'Pour les MPUP éligibles à la 1ère catégorie, la vérification de recevabilité réalisée pour chaque réception consiste en', '6.39', NULL, '6.39', NULL, NULL, TRUE, 869),
('Q529.01', 'Q529.01', 58, NULL, 'la vérification de la concordance entre la commande et le produit reçu muni de son système d’inviolabilité', '6.39', NULL, '6.39', NULL, NULL, FALSE, 870),
('Q529.02', 'Q529.02', 58, NULL, 'la vérification de la présence d’un certificat d’analyse du lot et de sa conformité', '6.39', NULL, '6.39', NULL, NULL, FALSE, 871),
('Q529.03', 'Q529.03', 58, NULL, 'l''adéquation entre la dénomination, le numéro de lot et la date de péremption figurant sur le conditionnement de la MPUP et ceux figurant sur le certificat d’analyse', '6.39', NULL, '6.39', NULL, NULL, FALSE, 872),
('Q529.04', 'Q529.04', 58, NULL, 'la vérification de la  présence d’une date de péremption sur le conditionnement', '6.39', NULL, '6.39', NULL, NULL, FALSE, 873),
('Q530', 'Q530', 58, NULL, 'La traçabilité de cette vérification est assurée.', '6.40', NULL, '6.40, 6.46', NULL, NULL, FALSE, 874),
('Q531', 'Q531', 58, NULL, 'L''absence d''obligation d''échantillothèque pour les MPUP de 1ère catégorie est correctement appliquée (ni excès ni omission par rapport aux autres catégories).', '6.41', NULL, '6.41', NULL, NULL, FALSE, 875),
('Q532', 'Q532', 59, NULL, 'Lorsqu''une spécialité pharmaceutique disposant d''une AMM/autorisation d''importation est utilisée comme MPUP (2ème catégorie), l''absence de contrôle « matière première » exigé est cohérente avec l''absence de MPUP adaptée disponible.', '6.42', NULL, '6.42', NULL, NULL, FALSE, 876),
('Q533', 'Q533', 59, NULL, 'Le déconditionnement d''une spécialité utilisée comme MPUP fait systématiquement l''objet d''une évaluation de l''impact sur la qualité, la stabilité, la sécurité et l''efficacité de la préparation (cf. Annexe IV).', '6.43', NULL, '6.43', NULL, NULL, FALSE, 877),
('Q534', 'Q534', 59, NULL, 'Un contrôle de la préparation pharmaceutique est réalisé, même sur une préparation à base d''une spécialité pharmaceutique', '6.44', NULL, '6.44', NULL, NULL, FALSE, 878),
('Q535', 'Q535', 59, NULL, 'L''absence d''obligation d''échantillothèque pour LES MPUP de 2ème catégorie est correctement appliquée.', '6.45', NULL, '6.45', NULL, NULL, FALSE, 879),
('Q536', 'Q536', 60, NULL, 'Pour les MPUP de 3ème catégorie, le contrôle complet requis (au-delà des points de recevabilité) est systématiquement réalisé et documenté.', '6.46', NULL, '6.46', NULL, NULL, FALSE, 880),
('Q537', 'Q537', 60, NULL, 'En l''absence d''au moins un des éléments de recevabilité listés, un contrôle complet est déclenché systématiquement sur la MPUP concernée.', '6.47', NULL, '6.47', NULL, NULL, TRUE, 881),
('Q537.01', 'Q537.01', 60, NULL, 'les contenants disposent d’un système d’inviolabilité', '6.47', NULL, '6.47', NULL, NULL, FALSE, 882),
('Q537.02', 'Q537.02', 60, NULL, 'les MPUP disposent d’un certificat d’analyse du lot correspondant', '6.47', NULL, '6.47', NULL, NULL, FALSE, 883),
('Q537.03', 'Q537.03', 60, NULL, 'les contenants disposent d’une date de péremption ou d’une date de re-contrôle', '6.47', NULL, '6.47', NULL, NULL, FALSE, 884),
('Q537.04', 'Q537.04', 60, NULL, 'les substances actives disposent d’un certificat de conformité aux Bonnes Pratiques de Fabrication (BPF)', '6.47', NULL, '6.47', NULL, NULL, FALSE, 885),
('Q538', 'Q538', 60, NULL, 'Le contrôle complet consiste à s’assurer de la conformité de la MPUP aux exigences de la Pharmacopée.', '6.48', NULL, '6.48', NULL, NULL, FALSE, 886),
('Q539', 'Q539', 60, NULL, 'Le cas échéant, des contrôles physico-chimiques, des études toxicologiques ou microbiennes sont mise en œuvre en l''absence de référentiel disponible', '6.49', NULL, '6.49', NULL, NULL, FALSE, 887),
('Q540', 'Q540', 60, NULL, 'Une échantillothèque est constituée pour les MPUP de 3ème catégorie.', '6.50', NULL, '6.50', NULL, NULL, FALSE, 888),
('Q541', 'Q541', 60, NULL, 'Pour les MPUP décrites à la Pharmacopée, la conformité à la monographie est démontrée, et la présence d''un certificat CEP est recherchée et valorisée dans le choix du fournisseur.', '6.51', NULL, '6.51', NULL, NULL, FALSE, 889),
('Q542', 'Q542', 60, NULL, 'La date de péremption ou de re-contrôle figure sur chaque conditionnement primaire de MPUP, et cette présence est vérifiée à chaque préparation.', '6.52', NULL, '6.52', NULL, NULL, FALSE, 890),
('Q543', 'Q543', 60, NULL, 'En l''absence de date de péremption/re-contrôle indiquée par le fabricant/fournisseur, le conditionnement est systématiquement refusé.', '6.53', NULL, '6.53', NULL, NULL, FALSE, 891),
('Q544', 'Q544', 60, NULL, 'En cas de re-contrôle, celui-ci correspond à un contrôle complet tel que défini au point 6.48.', '6.54', NULL, '6.54', NULL, NULL, FALSE, 892),
('Q545', 'Q545', 60, NULL, 'Les dates d''ouverture et de fin d''utilisation communiquées par le fournisseur sont clairement reportées sur le conditionnement de la MPUP.', '6.55', NULL, '6.55', NULL, NULL, FALSE, 893),
('Q546', 'Q546', 60, NULL, 'La vérification de recevabilité des articles de conditionnement suit une procédure formalisée équivalente à celle des MPUP à savoir', '6.56', NULL, '6.56', NULL, NULL, TRUE, 894),
('Q546.01', 'Q546.01', 60, NULL, 'vérification de la concordance des produits réceptionnés par rapport à la commande', '6.56', NULL, '6.56', NULL, NULL, FALSE, 895),
('Q546.02', 'Q546.02', 60, NULL, 'vérification de l’intégrité de l’emballage et du conditionnement primaire', '6.56', NULL, '6.56', NULL, NULL, FALSE, 896),
('Q546.03', 'Q546.03', 60, NULL, 'vérification, le cas échéant, de la présence d’un certificat d’analyse de conformité à la Pharmacopée, et/ou de spécifications internes (stérilité, certificat de stérilisation …)', '6.56', NULL, '6.56', NULL, NULL, FALSE, 897),
('Q546.04', 'Q546.04', 60, NULL, 'vérification, le cas échéant, du marquage CE', '6.56', NULL, '6.56', NULL, NULL, FALSE, 898),
('Q547', 'Q547', 60, NULL, 'Le contrôle des préparations pharmaceutiques terminées comprennent le', '6.57', NULL, '6.57', NULL, NULL, TRUE, 899),
('Q547.01', 'Q547.01', 60, NULL, 'contrôle des paramètres critiques du procédé de préparation nécessitant éventuellement des contrôles intermédiaires', '6.57', NULL, '6.57', NULL, NULL, FALSE, 900);
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('Q547.02', 'Q547.02', 60, NULL, 'contrôle des aspects pharmacotechniques', '6.57', NULL, '6.57', NULL, NULL, FALSE, 901),
('Q547.03', 'Q547.03', 60, NULL, 'contrôle des aspects physico-chimiques (couleur, précipité, dosages qualitatifs et quantitatifs)', '6.57', NULL, '6.57', NULL, NULL, FALSE, 902),
('Q547.04', 'Q547.04', 60, NULL, 'contrôle des aspects microbiologiques (prélèvements) ==> essai de stérilité le cas échéant', '6.57', NULL, '6.57', NULL, NULL, FALSE, 903),
('Q547.05', 'Q547.05', 60, NULL, 'contrôle des enregistrements', '6.57', NULL, '6.57', NULL, NULL, FALSE, 904),
('Q547.06', 'Q547.06', 60, NULL, 'contrôle de l''étiquetage', '6.57', NULL, '6.57', NULL, NULL, FALSE, 905),
('Q547.07', 'Q547.07', 60, NULL, 'contrôle de l''adéquation entre la prescription et l''étiquetage de la préparation terminée', '6.57', NULL, '6.57', NULL, NULL, FALSE, 906),
('Q548', 'Q548', 60, NULL, 'Les éléments critiques de la préparation contrôlés par double-contrôle par une tierce personne (a minima), ou intelligence artificielle, ou autres contrôles concernent', '6.57', NULL, '6.57', NULL, NULL, TRUE, 907),
('Q548.01', 'Q548.01', 60, NULL, 'les paramètres critiques du procédé de préparation nécessitant éventuellement des contrôles intermédiaires', '6.57', NULL, '6.57', NULL, NULL, FALSE, 908),
('Q548.02', 'Q548.02', 60, NULL, 'les aspects pharmacotechniques', '6.57', NULL, '6.57', NULL, NULL, FALSE, 909),
('Q548.03', 'Q548.03', 60, NULL, 'les aspects physico-chimiques', '6.57', NULL, '6.57', NULL, NULL, FALSE, 910),
('Q548.04', 'Q548.04', 60, NULL, 'les aspects microbiologiques, le cas échéant', '6.57', NULL, '6.57', NULL, NULL, FALSE, 911),
('Q548.05', 'Q548.05', 60, NULL, 'les systèmes d’enregistrement (chromatogrammes, vidéo…)', '6.57', NULL, '6.57', NULL, NULL, FALSE, 912),
('Q548.06', 'Q548.06', 60, NULL, 'la conformité de l’étiquetage', '6.57', NULL, '6.57', NULL, NULL, FALSE, 913),
('Q548.07', 'Q548.07', 60, NULL, 'l’adéquation entre la prescription et l’étiquetage de la préparation terminée', '6.57', NULL, '6.57', NULL, NULL, FALSE, 914),
('Q549', 'Q549', 60, NULL, 'Les contrôles réalisés sont conformes aux procédures et modes opératoires, et listés pour chaque préparation dans l''Annexe II partie 3 du dossier de préparation', '6.58', NULL, '6.58, 6.60', NULL, NULL, TRUE, 915),
('Q549.01', 'Q549.01', 60, NULL, 'Identité du patient (correspondance prescription / fiche de fabrication)', '6.58', NULL, '6.58', NULL, NULL, FALSE, 916),
('Q549.02', 'Q549.02', 60, NULL, 'MPUP et Solvants', '6.58', NULL, '6.58, 6.60', NULL, NULL, FALSE, 917),
('Q549.02.01', 'Q549.02.01', 60, NULL, '> DCI ou nom commercial', '6.58', NULL, '6.58, 6.60', NULL, NULL, FALSE, 918),
('Q549.02.02', 'Q549.02.02', 60, NULL, '> Forme pharmaceutique', '6.58', NULL, '6.58, 6.60', NULL, NULL, FALSE, 919),
('Q549.02.03', 'Q549.02.03', 60, NULL, '> Dosage ou concentration', '6.58', NULL, '6.58, 6.60', NULL, NULL, FALSE, 920),
('Q549.02.04', 'Q549.02.04', 60, NULL, '> Lot', '6.58', NULL, '6.58', NULL, NULL, FALSE, 921),
('Q549.02.05', 'Q549.02.05', 60, NULL, '> Péremption', '6.58', NULL, '6.58', NULL, NULL, FALSE, 922),
('Q549.03', 'Q549.03', 60, NULL, 'Volumes', '6.58', NULL, '6.58, 6.60', NULL, NULL, FALSE, 923),
('Q549.03.01', 'Q549.03.01', 60, NULL, '> à retirer', '6.58', NULL, '6.58', NULL, NULL, FALSE, 924),
('Q549.03.02', 'Q549.03.02', 60, NULL, '> à prélever', '6.58', NULL, '6.58', NULL, NULL, FALSE, 925),
('Q549.03.03', 'Q549.03.03', 60, NULL, '> à injecter', '6.58', NULL, '6.58', NULL, NULL, FALSE, 926),
('Q549.04', 'Q549.04', 60, NULL, 'Matériel utilisé', '6.58', NULL, '6.58', NULL, NULL, FALSE, 927),
('Q549.05', 'Q549.05', 60, NULL, 'Etiquetage (correspondance avec la prescription)', '6.58', NULL, '6.58, 6.60', NULL, NULL, FALSE, 928),
('Q550', 'Q550', 60, NULL, 'Les contrôles effectués tiennent compte des critères suivants :', '6.59', NULL, '6.59', NULL, NULL, FALSE, 929),
('Q550.01', 'Q550.01', 60, NULL, 'type de préparation (extemporanée et/ou pouvant être stockée)', '6.59', NULL, '6.59', NULL, NULL, FALSE, 930),
('Q550.02', 'Q550.02', 60, NULL, 'destination de la préparation ou du lot de préparation : préparation destinée à un seul patient ou lot destiné à plusieurs patients', '6.59', NULL, '6.59', NULL, NULL, FALSE, 931),
('Q550.03', 'Q550.03', 60, NULL, 'forme pharmaceutique', '6.59', NULL, '6.59', NULL, NULL, FALSE, 932),
('Q550.04', 'Q550.04', 60, NULL, 'classification de la préparation au regard de l’Annexe III ou de l’une analyse de risque formalisée', '6.59', NULL, '6.59', NULL, NULL, FALSE, 933),
('Q550.05', 'Q550.05', 60, NULL, 'type d''opération pharmaceutique nécessaire à la à la réalisation de la préparation', '6.59', NULL, '6.59', NULL, NULL, FALSE, 934),
('Q550.06', 'Q550.06', 60, NULL, 'nombre d''unité préparée', '6.59', NULL, '6.59', NULL, NULL, FALSE, 935),
('Q550.07', 'Q550.07', 60, NULL, 'type d''opération d contrôle réalisé (destructif ou non)', '6.59', NULL, '6.59', NULL, NULL, FALSE, 936),
('Q550.08', 'Q550.08', 60, NULL, 'caractère destructif ou non des opérations de contrôle.', '6.59', NULL, '6.59', NULL, NULL, FALSE, 937),
('Q551', 'Q551', 60, NULL, 'La réalisation d''une uniformité de masse est réalisée selon les normes de la Pharmacopée (ou méthode équivalente) pour les formes pharmaceutiques unitaires', '6.61', NULL, '6.61', NULL, NULL, FALSE, 938),
('Q552', 'Q552', 60, NULL, 'Pour les préparations stockées (ou pour un lot destiné à plus de 10 personnes), une uniformité de teneur (ou des contrôles intermédiaires/finaux équivalents) est mise en œuvre et documentée.', '6.62', NULL, '6.62', NULL, NULL, FALSE, 939),
('Q553', 'Q553', 60, NULL, 'L''absence de contrôle ou un nombre restreint de contrôles est systématiquement justifié et tracé dans le dossier de préparation.', '6.63', NULL, '6.63', NULL, NULL, FALSE, 940),
('Q554', 'Q554', 60, NULL, 'Un échantillon de chaque lot de préparations terminées est conservé (sauf exception justifiée), en quantité suffisante pour permettre l''analyse complète prévue par la procédure.', '6.64', NULL, '6.64', NULL, NULL, FALSE, 941),
('Q555', 'Q555', 60, NULL, 'L''exemption d''échantillothèque pour les lots destinés à moins de 10 patients est appliquée.', '6.65', NULL, '6.65', NULL, NULL, FALSE, 942),
('Q556', 'Q556', 60, NULL, 'Les échantillons sont conservés dans les conditions prévues pour la préparation, pendant une durée au moins égale à la péremption + 1 an (sauf exception justifiée).', '6.66', NULL, '6.66', NULL, NULL, FALSE, 943),
('Q557', 'Q557', 60, NULL, 'Les récipients contenant les échantillons sont clairements idéentifiés et mentionnent de façon apparente, au minimum :', '6.67', NULL, '6.67', NULL, NULL, TRUE, 944),
('Q557.01', 'Q557.01', 60, NULL, 'numéro de lot', '6.67', NULL, '6.67', NULL, NULL, FALSE, 945),
('Q557.02', 'Q557.02', 60, NULL, 'date de l''échantillonage', '6.67', NULL, '6.67', NULL, NULL, FALSE, 946),
('Q557.03', 'Q557.03', 60, NULL, 'date de péremption', '6.67', NULL, '6.67', NULL, NULL, FALSE, 947),
('Q557.04', 'Q557.04', 60, NULL, 'numéro d''enregistrement dans l''échantillothèque', '6.67', NULL, '6.67', NULL, NULL, FALSE, 948),
('Q557.05', 'Q557.05', 60, NULL, 'la mention "Ne Pas Dispenser"', '6.67', NULL, '6.67', NULL, NULL, FALSE, 949),
('Q558', 'Q558', 60, NULL, 'L''utilisation d''un code regroupant l''ensemble de ces informations est utilisée', '6.67', NULL, '6.67', NULL, NULL, FALSE, 950),
('Q559', 'Q559', 60, NULL, 'Chaque lot de préparation fait l''objet d''une libération pharmaceutique fondée sur l''ensemble des informations disponibles dans le dossier de lot, selon la même stratégie que celle définie au chapitre 6.', '6.68', NULL, '6.68', NULL, NULL, FALSE, 951),
('Q560', 'Q560', 60, NULL, 'La libération pharmaceutique des préparations terminées prend en compte l’examen de l’ensemble des éléments pertinents', '6.68', NULL, '6.68', NULL, NULL, TRUE, 952),
('Q560.01', 'Q560.01', 60, NULL, 'le dossier de lot de la préparation', '6.68', NULL, '6.68', NULL, NULL, FALSE, 953),
('Q560.02', 'Q560.02', 60, NULL, 'les résultats des contrôles de l''environnement', '6.68', NULL, '6.68', NULL, NULL, FALSE, 954),
('Q560.02.01', 'Q560.02.01', 60, NULL, '> température', '6.68', NULL, '6.68', NULL, NULL, FALSE, 955),
('Q560.02.02', 'Q560.02.02', 60, NULL, '> pressions', '6.68', NULL, '6.68', NULL, NULL, FALSE, 956),
('Q560.02.03', 'Q560.02.03', 60, NULL, '> hygrométrie', '6.68', NULL, '6.68', NULL, NULL, FALSE, 957),
('Q560.02.04', 'Q560.02.04', 60, NULL, '> microbiologique', '6.68', NULL, '6.68', NULL, NULL, FALSE, 958),
('Q560.03', 'Q560.03', 60, NULL, 'les conditions du cycle de stérilisation (le cas échéant)', '6.68', NULL, '6.68', NULL, NULL, FALSE, 959),
('Q560.04', 'Q560.04', 60, NULL, 'les double-contrôles réalisés pendant la préparation ou les résultats des contrôles (pesé, dosage, contrôle vidéo)', '6.68', NULL, '6.68', NULL, NULL, FALSE, 960),
('Q560.05', 'Q560.05', 60, NULL, 'la correspondance entre la prescription, la fiche de fabrication et l''étiquetage', '6.68', NULL, '6.68', NULL, NULL, FALSE, 961),
('Q560.06', 'Q560.06', 60, NULL, 'la conformité aux spécifications attendues de la préparation terminée', '6.68', NULL, '6.68', NULL, NULL, FALSE, 962),
('Q560.06.01', 'Q560.06.01', 60, NULL, '-> couleur / transparence', '6.68', NULL, '6.68', NULL, NULL, FALSE, 963),
('Q560.06.02', 'Q560.06.02', 60, NULL, '-> limpidité / précipité', '6.68', NULL, '6.68', NULL, NULL, FALSE, 964),
('Q560.07', 'Q560.07', 60, NULL, 'l''examen du conditionnement final (sachet hermétique, protection UV si besoin)', '6.68', NULL, '6.68', NULL, NULL, FALSE, 965),
('Q560.08', 'Q560.08', 60, NULL, 'la vérification de l''étiquetage', '6.68', NULL, '6.68', NULL, NULL, FALSE, 966),
('Q560.09', 'Q560.09', 60, NULL, 'le respect des procédures d''assurance qualité', '6.68', NULL, '6.68', NULL, NULL, FALSE, 967),
('Q560.09.01', 'Q560.09.01', 60, NULL, '-> personnel habilité', '6.68', NULL, '6.68', NULL, NULL, FALSE, 968),
('Q560.09.02', 'Q560.09.02', 60, NULL, '-> locaux et équipements adaptés', '6.68', NULL, '6.68', NULL, NULL, FALSE, 969),
('Q561', 'Q561', 60, NULL, 'La décision de libération et son enregistrement n''est prise que par un pharmacien', '6.69', NULL, '6.69', NULL, NULL, FALSE, 970),
('Q562', 'Q562', 60, NULL, 'Le choix des contrôles sont fonction des caractéristiques de la préparation et de son utilisation', '6.71', NULL, '6.71', NULL, NULL, FALSE, 971),
('Q563', 'Q563', 60, NULL, 'Le choix entre contrôle à 100% et contrôle par échantillonnage est justifié et adapté à l''entité contrôlée (unité ou lot).', '6.72', NULL, '6.72', NULL, NULL, FALSE, 972),
('Q564', 'Q564', 60, NULL, 'L''échantillonnage réalisé est représentatif du lot, y compris lorsque celui-ci est constitué de sous-lots ultérieurement rassemblés.', '6.73', NULL, '6.73', NULL, NULL, FALSE, 973),
('Q565', 'Q565', 60, NULL, 'En cas de lot composé de plusieurs sous-lots, un plan d''échantillonnage par sous-lot est réalisé pour vérifier l''homogénéité du lot final.', '6.74', NULL, '6.74', NULL, NULL, FALSE, 974),
('Q566', 'Q566', 60, NULL, 'Pour chaque procédure d''échantilonnage il est précisé explicitement le type d''échantillonnage retenu (simple ou multiple) et le nombre d''unités prélevées.', '6.75', NULL, '6.75', NULL, NULL, FALSE, 975),
('Q567', 'Q567', 60, NULL, 'En cas d''échantillonnage multiple, la destination de chaque prélèvement (pharmacotechnique, physico-chimique, microbiologique, contrôle supplémentaire, échantillothèque) est définie dans la procédure.', '6.76', NULL, '6.76', NULL, NULL, FALSE, 976),
('Q568', 'Q568', 60, NULL, 'La durée de stabilité de la préparation est déterminée comme la durée pendant laquelle la préparation conserve, dans des limites spécifiées, ses qualités tout au long de sa conservation', '6.78', NULL, '6.78', NULL, NULL, FALSE, 977),
('Q569', 'Q569', 60, NULL, 'Un contrôle de stabilité est misen oeuvre pour toute préparation réalisée à l''avance et destinée à une conservation prolongée, en cohérence avec sa forme pharmaceutique.', '6.77', NULL, '6.77', NULL, NULL, FALSE, 978),
('Q570', 'Q570', 60, NULL, 'La date de péremption est déterminée à partir de la date de réalisation effective de la préparation.', '6.79', NULL, '6.79', NULL, NULL, FALSE, 979),
('Q571', 'Q571', 60, NULL, 'La détermination de la date de péremption s''appuie sur une réflexion documentée intégrant les propriétés physico-chimiques, les données bibliographiques, les analyses réalisées, la forme pharmaceutique, le type de conditionnement et la présence/absence de conservateur.', '6.80', NULL, '6.80', NULL, NULL, FALSE, 980),
('Q572', 'Q572', 60, NULL, 'La date de péremption de la préparation terminée est déterminée indépendamment de celle de la spécialité utilisée comme MPUP .', '6.81', NULL, '6.81', NULL, NULL, FALSE, 981),
('Q573', 'Q573', 60, NULL, 'Les durées de stabilité retenues sont, chaque fois que possible, fondées sur des données analytiques plutôt que sur des données bibliographiques seules.', '6.82', NULL, '6.82', NULL, NULL, FALSE, 982),
('Q574', 'Q574', 60, NULL, 'Les méthodes analytiques de stabilité utilisées sont validées et permettent de quantifier la/les substance(s) active(s), les produits de dégradation et de détecter toute autre altération.', '6.83', NULL, '6.83', NULL, NULL, FALSE, 983),
('Q575', 'Q575', 60, NULL, 'La stabilité microbiologique est étudiée pour l''ensemble des préparations conservées, avec démonstration du maintien de la qualité microbiologique conforme à la Pharmacopée Européenne.', '6.84', NULL, '6.84', NULL, NULL, FALSE, 984),
('Q576', 'Q576', 62, NULL, 'Une convention de sous-traitance est systématiquement mise en place avant toute action de sous-traitance des préparations.', '7.01', NULL, '7.01', NULL, NULL, FALSE, 985),
('Q577', 'Q577', 62, NULL, 'Le contrat de sous-traitance respecte le CSP et les BPP', '7.01', NULL, '7.01', NULL, NULL, FALSE, 986),
('Q578', 'Q578', 62, NULL, 'Les conventions de sous-traitance en place dans le secteur de pharmacotechnie concernent la totalité des opérations de préparations, et/ou le contrôle des MPUP et préparations finies et/ou le transport de la préparation', '7.02', NULL, '7.02', NULL, NULL, FALSE, 987),
('Q579', 'Q579', 62, NULL, 'Le périmètre exact de la sous-traitance est défini de façon non ambiguë, évitant toute zone grise de responsabilité', '7.03', NULL, '7.03', NULL, NULL, FALSE, 988),
('Q580', 'Q580', 63, NULL, 'Il existe d''un contrat écrit entre le donneur d''ordre et le sous-traitant (que l''on sous-traite ou que l''on soit le sous-traitant) spécifiant', '7.04', NULL, '7.04', NULL, NULL, TRUE, 989),
('Q580.01', 'Q580.01', 63, NULL, '* les obligations', '7.04', NULL, '7.04', NULL, NULL, FALSE, 990),
('Q580.01.01', 'Q580.01.01', 63, NULL, '-> du donneur d''ordre', '7.04', NULL, '7.04', NULL, NULL, FALSE, 991),
('Q580.01.02', 'Q580.01.02', 63, NULL, '-> du sous-traitant', '7.04', NULL, '7.04', NULL, NULL, FALSE, 992),
('Q580.02', 'Q580.02', 63, NULL, '* les responsabilités', '7.04', NULL, '7.04', NULL, NULL, FALSE, 993),
('Q580.02.01', 'Q580.02.01', 63, NULL, '-> du donneur d''ordre', '7.04', NULL, '7.04', NULL, NULL, FALSE, 994),
('Q580.02.02', 'Q580.02.02', 63, NULL, '-> du sous-traitant', '7.04', NULL, '7.04', NULL, NULL, FALSE, 995),
('Q580.03', 'Q580.03', 63, NULL, '* les tâches dévolues', '7.04', NULL, '7.04', NULL, NULL, FALSE, 996),
('Q580.03.01', 'Q580.03.01', 63, NULL, '-> au donneur d''ordre', '7.04', NULL, '7.04', NULL, NULL, FALSE, 997),
('Q580.03.02', 'Q580.03.02', 63, NULL, '-> au sous-traitant', '7.04', NULL, '7.04', NULL, NULL, FALSE, 998),
('Q580.04', 'Q580.04', 63, NULL, '* les exigences', '7.04', NULL, '7.04', NULL, NULL, FALSE, 999),
('Q580.04.01', 'Q580.04.01', 63, NULL, '-> du donneur d''ordre', '7.04', NULL, '7.04', NULL, NULL, FALSE, 1000);
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('Q580.04.02', 'Q580.04.02', 63, NULL, '-> du sous-traitant', '7.04', NULL, '7.04', NULL, NULL, FALSE, 1001),
('Q581', 'Q581', 63, NULL, 'Il existe d''une contrat unique global (dans la mesure du possible) ou de contrats réunis consultables ensembles', '7.05', NULL, '7.05', NULL, NULL, FALSE, 1002),
('Q582', 'Q582', 63, NULL, 'Le contrat précise la possibilité d''inspection de l''activité de sous-traitance par les autorités compétentes', '7.06', NULL, '7.06', NULL, NULL, FALSE, 1003),
('Q583', 'Q583', 63, NULL, 'Toutes les activités à effectuer par le sous-traitant sont mentionnées dans le contrat', '7.21', NULL, '7.21', NULL, NULL, FALSE, 1004),
('Q584', 'Q584', 63, NULL, 'Les modalités de communication et de commande entre les 2 parties sont précisées et formalisées', '7.21', NULL, '7.21', NULL, NULL, TRUE, 1005),
('Q584.01', 'Q584.01', 63, NULL, 'Il existe une procédure ou un document', '7.21', NULL, '7.21', NULL, NULL, FALSE, 1006),
('Q584.02', 'Q584.02', 63, NULL, 'Cette procédure est validée par les deux parties', '7.21', NULL, '7.21', NULL, NULL, FALSE, 1007),
('Q585', 'Q585', 63, NULL, 'Le contrat mentionne la possibilité pour le sous-traitant de refuser la réalisation d''une préparation sous réserve d''une justification écrite', '7.21', NULL, '7.21, 7.25', NULL, NULL, FALSE, 1008),
('Q586', 'Q586', 63, NULL, 'Toutes les activités à effectuer par le sous-traitant sont mentionnées dans le contrat. Le(s) pharmacien responsable des préparations( du donneur d''ordre et du sous traitant) est associé à la rédaction/signature du contrat de sous-traitance.', '7.22', NULL, '7.22', NULL, NULL, FALSE, 1009),
('Q587', 'Q587', 63, NULL, 'Pour chaque sous-traitance, le contrat est écrit et défini précisément les responsabilités des les processus mis en places (comme l''étiquetage, les contrôles des MPUP, DM, préparations terminées, les conditions de conservations et de transport, la gestion du rappel des lots et des non-conformités, la durée du-dit contrat et les modalités de reconduction)', '7.23', NULL, '7.23', NULL, NULL, FALSE, 1010),
('Q588', 'Q588', 63, NULL, 'Le contrat prévoit la possibilité d''un audit du sous-traitant par le donneur d''ordre', '7.24', NULL, '7.24', NULL, NULL, FALSE, 1011),
('Q589', 'Q589', 63, NULL, 'Le contrat prévoit la possibilité pour le donneur d''ordre de consulter les documents concernant la préparation sous-traitée (en cas de demande)', '7.24', NULL, '7.24', NULL, NULL, FALSE, 1012),
('Q590', 'Q590', 63, NULL, 'Le contrat de sous-traitance comprend un chapitre "réattribution des préparations"', '5.69', NULL, '5.69', NULL, NULL, FALSE, 1013),
('Q591', 'Q591', 64, NULL, 'La portée des prestations et les exigences associées demandées par le donneur d''ordre sont clairement stipulées', '7.07', NULL, '7.07', NULL, NULL, FALSE, 1014),
('Q592', 'Q592', 64, NULL, 'Le donneur d''ordre vérifie que le sous traitant dispose', '7.08', NULL, '7.08', NULL, NULL, TRUE, 1015),
('Q592.01', 'Q592.01', 64, NULL, '* de l''autorisation de réalisation des préparations magistrales stériles ou comportant des matières premières dangereuses pour le personnel et l’environnement délivrée par l''ARS', '7.08', NULL, '7.08', NULL, NULL, FALSE, 1016),
('Q592.02', 'Q592.02', 64, NULL, '* de l''autorisation réalisation des préparations hospitalières délivrée par l''ARS', '7.08', NULL, '7.08', NULL, NULL, FALSE, 1017),
('Q592.03', 'Q592.03', 64, NULL, '* l''autorisation de reconstitution de spécialités pharmaceutiques, y compris celles concernant les médicaments de thérapie innovante délivrée par l''ARS', '7.08', NULL, '7.08', NULL, NULL, FALSE, 1018),
('Q592.04', 'Q592.04', 64, NULL, '* des compétences nécessaires du sous-traitant à la réalisation de l''activité demandée', '7.08', NULL, '7.08', NULL, NULL, FALSE, 1019),
('Q593', 'Q593', 64, NULL, 'Le donneur d''ordre s''assure de l''application des BPP par le sous-traitant', '7.09', NULL, '7.09', NULL, NULL, FALSE, 1020),
('Q594', 'Q594', 64, NULL, 'Le donneur d''ordre est responsable de la transmission de toutes les informations et connaissances nécessaires à la réalisation du contrat de sous-traitance', '7.10', NULL, '7.10', NULL, NULL, FALSE, 1021),
('Q595', 'Q595', 64, NULL, 'La présence d''un système d''assurance qualité au sein de l''unité de préparation du sous-traitant a été vérifiée', '7.11', NULL, '7.11', NULL, NULL, FALSE, 1022),
('Q596', 'Q596', 64, NULL, 'Il existe une documentation du contrôle à réception par le donneur d''ordre des préparations sous-traitées, dont les éléments suivants', '7.12', NULL, '7.12', NULL, NULL, TRUE, 1023),
('Q596.01', 'Q596.01', 64, NULL, '* concordance entre la prescription et la préparation', '7.12', NULL, '7.12', NULL, NULL, FALSE, 1024),
('Q596.02', 'Q596.02', 64, NULL, '* conformité de l''étiquetage', '7.12', NULL, '7.12', NULL, NULL, FALSE, 1025),
('Q596.03', 'Q596.03', 64, NULL, '* intégrité physique du conditionnement', '7.12', NULL, '7.12', NULL, NULL, FALSE, 1026),
('Q596.04', 'Q596.04', 64, NULL, '* respect des conditions de conservation pendant le transport (enregistrements des sondes de température à archiver, abri de la lumière à vérifier)', '7.12', NULL, '7.12', NULL, NULL, FALSE, 1027),
('Q597', 'Q597', 64, NULL, 'Le donneur d''ordre est responsable de la dispensation de la préparation', '7.13', NULL, '7.13', NULL, NULL, FALSE, 1028),
('Q598', 'Q598', 65, NULL, 'Le sous-traitant est en mesure d''effectuer l''activité de préparation contractualisée', '7.14', NULL, '7.14', NULL, NULL, TRUE, 1029),
('Q598.01', 'Q598.01', 65, NULL, '* Locaux adaptés (ex : présence d''une ZAC)', '7.14', NULL, '7.14', NULL, NULL, FALSE, 1030),
('Q598.02', 'Q598.02', 65, NULL, '* Equipements et matériels adaptés (ex : PSC ou isolateur)', '7.14', NULL, '7.14', NULL, NULL, FALSE, 1031),
('Q598.03', 'Q598.03', 65, NULL, '* Autorisation de réalisation des préparations magistrales stériles ou comportant des matières premières dangereuses pour le personnel et l’environnement délivrée par l''ARS', '7.14', NULL, '7.14', NULL, NULL, FALSE, 1032),
('Q598.04', 'Q598.04', 65, NULL, '* Autorisation réalisation des préparations hospitalières délivrée par l''ARS', '7.14', NULL, '7.14', NULL, NULL, FALSE, 1033),
('Q598.05', 'Q598.05', 65, NULL, '* Autorisation de reconstitution de spécialités pharmaceutiques, y compris celles concernant les médicaments de thérapie innovante délivrée par l''ARS', '7.14', NULL, '7.14', NULL, NULL, FALSE, 1034),
('Q598.06', 'Q598.06', 65, NULL, '* Personnel compétent au sens du CSP et formé', '7.14', NULL, '7.14', NULL, NULL, FALSE, 1035),
('Q598.07', 'Q598.07', 65, NULL, '* Système d''assurance qualité mis en place', '7.14', NULL, '7.14', NULL, NULL, FALSE, 1036),
('Q599', 'Q599', 65, NULL, 'Le sous-traitant réalise les activités comme stipulés par le contrat', '7.15', NULL, '7.15', NULL, NULL, FALSE, 1037),
('Q600', 'Q600', 65, NULL, 'Il existe une procédure prévoyant un signalement immédiat au pharmacien donneur d''ordre en cas d''éléments susceptibles de remettre en cause la libération de la préparation (découverte d''erreur a posteriori)', '7.16', NULL, '7.16', NULL, NULL, FALSE, 1038),
('Q601', 'Q601', 65, NULL, 'Le contrat stipule le cas échéant la possibilité de sous-traitance du contrôle et du transport par le sous-traitant à un tiers', '7.17', NULL, '7.17', NULL, NULL, FALSE, 1039),
('Q602', 'Q602', 65, NULL, 'En cas de sous-traitance à un tiers, le donneur d''ordre en est informé (contrat et/ou courrier officiel)', '7.17', NULL, '7.17', NULL, NULL, FALSE, 1040),
('Q603', 'Q603', 65, NULL, 'En cas de sous-traitance, la rédaction du dossier de préparation incombe au sous-traitant', '7.18', NULL, '7.18', NULL, NULL, FALSE, 1041),
('Q604', 'Q604', 65, NULL, 'Le contrat précise que le sous-traitant est en charge de la rédaction de la totalité du dossier de préparation. Le certificat de libération des préparations est transmis au donneur d''ordre', '7.19', NULL, '7.19', NULL, NULL, FALSE, 1042),
('Q605', 'Q605', 65, NULL, 'Le refus par le sous-traitant de la réalisation d''une préparation doit être motivée (le cas échéant)', '7.20', NULL, '7.20', NULL, NULL, FALSE, 1043),
('Q606', 'Q606', 66, NULL, 'Le sous-traitant doit réaliser la totalité des opérations de préparation de', '7.26', NULL, '7.26', NULL, NULL, TRUE, 1044),
('Q606.01', 'Q606.01', 66, NULL, '* préparation', '7.26', NULL, '7.26', NULL, NULL, FALSE, 1045),
('Q606.02', 'Q606.02', 66, NULL, '* conditionnement', '7.26', NULL, '7.26', NULL, NULL, FALSE, 1046),
('Q606.03', 'Q606.03', 66, NULL, '* étiquetage', '7.26', NULL, '7.26', NULL, NULL, FALSE, 1047),
('Q607', 'Q607', 66, NULL, 'L''étiquetage est conforme au CSP et réalisé par le sous-traitant', '7.27', NULL, '7.27', NULL, NULL, TRUE, 1048),
('Q607.01', 'Q607.01', 66, NULL, '* Identité du patient (nom / prénom / date de naissance)', '7.27', NULL, '7.27', NULL, NULL, FALSE, 1049),
('Q607.02', 'Q607.02', 66, NULL, '* Nom de la préparation (DCI)', '7.27', NULL, '7.27', NULL, NULL, FALSE, 1050),
('Q607.03', 'Q607.03', 66, NULL, '* Dosage de la préparation', '7.27', NULL, '7.27', NULL, NULL, FALSE, 1051),
('Q607.04', 'Q607.04', 66, NULL, '* Forme pharmaceutique de la préparation', '7.27', NULL, '7.27', NULL, NULL, FALSE, 1052),
('Q607.05', 'Q607.05', 66, NULL, '* Numéro d''enregistrement de la préparation', '7.27', NULL, '7.27', NULL, NULL, FALSE, 1053),
('Q607.06', 'Q607.06', 66, NULL, '* Date de péremption', '7.27', NULL, '7.27', NULL, NULL, FALSE, 1054),
('Q607.07', 'Q607.07', 66, NULL, '* Modalités de conservation', '7.27', NULL, '7.27', NULL, NULL, FALSE, 1055),
('Q607.08', 'Q607.08', 66, NULL, '* Nom de la pharmacie sous-traitante', '7.27', NULL, '7.27', NULL, NULL, FALSE, 1056),
('Q607.09', 'Q607.09', 66, NULL, '* Nom de la pharmacie donneuse d''ordre', '7.27', NULL, '7.27', NULL, NULL, FALSE, 1057),
('Q608', 'Q608', 66, NULL, 'Le numéro d''ordonnancier est ajouté sur l''étiquette par le donneur d''ordre au moment de la dispensation', '7.27', NULL, '7.27', NULL, NULL, FALSE, 1058),
('Q609', 'Q609', 66, NULL, 'Les délais de réalisation des préparations sont mentionnés dans le contrat', '7.28', NULL, '7.28', NULL, NULL, TRUE, 1059),
('Q609.01', 'Q609.01', 66, NULL, '* pour les préparations habituelles', '7.28', NULL, '7.28', NULL, NULL, FALSE, 1060),
('Q609.02', 'Q609.02', 66, NULL, '* pour les préparations urgentes', '7.28', NULL, '7.28', NULL, NULL, FALSE, 1061),
('Q610', 'Q610', 66, NULL, 'Les formes pharmaceutiques réalisées par le sous-traitant sont spécifiées dans le contrat', '7.28', NULL, '7.28', NULL, NULL, FALSE, 1062),
('Q611', 'Q611', 67, NULL, 'Le recours à l''activité de sous-traitance des contrôles est justifié par l''absence d''équipements et de matériels adéquats et/ou si les contrôles sont rares', '7.29', NULL, '7.29', NULL, NULL, FALSE, 1063),
('Q612', 'Q612', 67, NULL, 'Le contrat de sous-traitance précise les responsabilité du donneur d''ordre et du sous traitant en matière de contrôle', '7.30', NULL, '7.30', NULL, NULL, TRUE, 1064),
('Q612.01', 'Q612.01', 67, NULL, 'MPUP', '7.30', NULL, '7.30', NULL, NULL, FALSE, 1065),
('Q612.02', 'Q612.02', 67, NULL, 'Préparation terminée', '7.30', NULL, '7.30', NULL, NULL, FALSE, 1066),
('Q613', 'Q613', 67, NULL, 'Le contrat stipule que le donneur d''ordre fournit toutes les informations dont le sous-traitant a besoin pour réaliser les contrôles (dossier de lot, enregistrements)', '7.31', NULL, '7.31', NULL, NULL, FALSE, 1067),
('Q614', 'Q614', 67, NULL, 'Délivrance par le sous-traitant d''un certificat d''analyse comportant par le sous traitant', '7.32', NULL, '7.32', NULL, NULL, TRUE, 1068),
('Q614.01', 'Q614.01', 67, NULL, '* les résultats qualitatifs avec leur spécifications', '7.32', NULL, '7.32', NULL, NULL, FALSE, 1069),
('Q614.02', 'Q614.02', 67, NULL, '* les résultats quantitatifs avec leur spécifications', '7.32', NULL, '7.32', NULL, NULL, FALSE, 1070),
('Q614.03', 'Q614.03', 67, NULL, '* les méthodes d''analyse utilisées', '7.32', NULL, '7.32', NULL, NULL, FALSE, 1071),
('Q614.04', 'Q614.04', 67, NULL, '* les référentiels utilisés', '7.32', NULL, '7.32', NULL, NULL, FALSE, 1072),
('Q614.05', 'Q614.05', 67, NULL, '* Une mention de conformité ou de non conformité de la préparation', '7.32', NULL, '7.32', NULL, NULL, FALSE, 1073),
('Q614.06', 'Q614.06', 67, NULL, '* la date du contrôle', '7.32', NULL, '7.32', NULL, NULL, FALSE, 1074),
('Q614.07', 'Q614.07', 67, NULL, '* la signature du responsable du contrôle', '7.32', NULL, '7.32', NULL, NULL, FALSE, 1075),
('Q615', 'Q615', 67, NULL, 'En cas de sous-traitance des contôles, le pharmacien responsable des  préparations tient compte des résultats fourni par le sous-traitant pour la réalisation des préparations', '7.33', NULL, '7.33', NULL, NULL, FALSE, 1076),
('Q616', 'Q616', 68, NULL, 'Les conditions particulières de transport figurent dans le contrat et sont vérifiées par des enregistrements', '7.34', NULL, '7.34', NULL, NULL, TRUE, 1077),
('Q616.01', 'Q616.01', 68, NULL, 'la durée moyenne de transport', '7.34', NULL, '7.34', NULL, NULL, FALSE, 1078),
('Q616.02', 'Q616.02', 68, NULL, 'les conditions particulières de conservation', '7.34', NULL, '7.34', NULL, NULL, FALSE, 1079),
('Q616.03', 'Q616.03', 68, NULL, 'la localisation exacte du lieu de livraison', '7.34', NULL, '7.34', NULL, NULL, FALSE, 1080),
('Q616.04', 'Q616.04', 68, NULL, 'la localisation et les conditions de remise avec le lieu de prise en charge', '7.34', NULL, '7.34', NULL, NULL, FALSE, 1081),
('Q616.05', 'Q616.05', 68, NULL, 'les lieux et délais de ruptures de charge quand ils existent', '7.34', NULL, '7.34', NULL, NULL, FALSE, 1082),
('Q616.06', 'Q616.06', 68, NULL, 'les délais de recours', '7.34', NULL, '7.34', NULL, NULL, FALSE, 1083),
('Q617', 'Q617', 68, NULL, 'En cas d''utilisation d''un service de colis postaux, les conditions de conservation et le délai de livraison sont compatibles avec la préparation', '7.35', NULL, '7.35', NULL, NULL, FALSE, 1084),
('Q618', 'Q618', 68, NULL, 'Le contrat prévoit l''utilisation d''emballage (ou conditionnement secondaire) hermétique et solide afin de permettre un transport sécurisé (à la fois pour la préparation, pour le transporteur et pour l''environnement)', '7.36', NULL, '7.36', NULL, NULL, FALSE, 1085),
('Q619', 'Q619', 68, NULL, 'Le contrat précise', '7.37', NULL, '7.37', NULL, NULL, TRUE, 1086),
('Q619.01', 'Q619.01', 68, NULL, '* que le transport des préparations terminées doit s''effectuer dans des conteneurs ou paquets clos', '7.37', NULL, '7.37', NULL, NULL, FALSE, 1087),
('Q619.02', 'Q619.02', 68, NULL, '* que ces conteneurs ou paquets sont scellés ou munis d''un dispositif de fermeture assurant la même sécurité', '7.37', NULL, '7.37', NULL, NULL, FALSE, 1088),
('Q619.03', 'Q619.03', 68, NULL, '* que l''identification et l''adresse de l''expéditeur doivent être mentionnées (sur l''ordre de mission, le colis, ...)', '7.37', NULL, '7.37', NULL, NULL, FALSE, 1089),
('Q619.04', 'Q619.04', 68, NULL, '* que l''identification et l''adresse du destinataire doivent être mentionnées (sur l''ordre de mission, le colis, ...)', '7.37', NULL, '7.37', NULL, NULL, FALSE, 1090),
('Q620', 'Q620', 68, NULL, 'Les conditions de transport particulières (température, absence de mouvement, protection de la lumière) doivent être stipulées dans le contrat et garanties par le transporteur', '7.38', NULL, '7.38', NULL, NULL, TRUE, 1091),
('Q620.01', 'Q620.01', 68, NULL, '* enregistrements du suivi des températures', '7.38', NULL, '7.38', NULL, NULL, FALSE, 1092),
('Q620.02', 'Q620.02', 68, NULL, '* contrôle de la durée du transport', '7.38', NULL, '7.38', NULL, NULL, FALSE, 1093),
('Q620.03', 'Q620.03', 68, NULL, '* maintien de l''obscurité', '7.38', NULL, '7.38', NULL, NULL, FALSE, 1094),
('Q620.04', 'Q620.04', 68, NULL, '* maintien de l''immobilité des conteneurs', '7.38', NULL, '7.38', NULL, NULL, FALSE, 1095),
('Q621', 'Q621', 69, NULL, 'Toute activité externalisée, couverte par le guide des BPP, est définie de manière appropriée, convenue et contrôlée afin d’éviter tout malentendu succeptible de conduire à un travail ou une préparation de qualité insuffisante et fait l''objet d''un contrat écrit entre le donneur d’ordre et le sous-traitant en vue de fixer clairement les obligations de chaque partie.', '7.39', NULL, '7.39', NULL, NULL, FALSE, 1096),
('Q622', 'Q622', 69, NULL, 'Les contrats de sous-traitance de prestations peuvent concerner', '7.40', NULL, '7.40', NULL, NULL, TRUE, 1097),
('Q622.01', 'Q622.01', 69, NULL, 'les systèmes de traitement de l''air', '7.40', NULL, '7.40', NULL, NULL, FALSE, 1098),
('Q622.02', 'Q622.02', 69, NULL, 'les systèmes de traitement de l''eau', '7.40', NULL, '7.40', NULL, NULL, FALSE, 1099),
('Q622.03', 'Q622.03', 69, NULL, 'les isolateurs', '7.40', NULL, '7.40', NULL, NULL, FALSE, 1100);
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('Q622.04', 'Q622.04', 69, NULL, 'les PSC', '7.40', NULL, '7.40', NULL, NULL, FALSE, 1101),
('Q623', 'Q623', 69, NULL, 'Ces contrats peuvent concerner les prestations de', '7.40', NULL, '7.40', NULL, NULL, FALSE, 1102),
('Q623.01', 'Q623.01', 69, NULL, 'surveillance des ZAC', '7.40', NULL, '7.40', NULL, NULL, FALSE, 1103),
('Q623.02', 'Q623.02', 69, NULL, 'mise à disposition des consommables stériles (vêtements, articles de conditionnement)', '7.40', NULL, '7.40', NULL, NULL, FALSE, 1104),
('Q623.03', 'Q623.03', 69, NULL, 'maintenance des équipements', '7.40', NULL, '7.40', NULL, NULL, FALSE, 1105),
('Q623.04', 'Q623.04', 69, NULL, 'manipulation et l''élimination des déchets', '7.40', NULL, '7.40', NULL, NULL, TRUE, 1106),
('Q623.04.01', 'Q623.04.01', 69, NULL, 'cytotoxiques', '7.40', NULL, '7.40', NULL, NULL, FALSE, 1107),
('Q623.04.02', 'Q623.04.02', 69, NULL, 'non cytotoxiques', '7.40', NULL, '7.40', NULL, NULL, FALSE, 1108),
('Q624', 'Q624', 71, NULL, 'Il existe un système d''enregistrement des réclamations', '8.03', NULL, '8.03', NULL, NULL, FALSE, 1109),
('Q625', 'Q625', 71, NULL, 'Il existe un système de traitement des reclamations (CREX, autre)', '8.03', NULL, '8.03', NULL, NULL, FALSE, 1110),
('Q626', 'Q626', 71, NULL, 'Ce traitement analyse causes et defauts (CREX, autre)', '8.05', NULL, '8.05', NULL, NULL, FALSE, 1111),
('Q627', 'Q627', 71, NULL, 'Ce traitement conduit à la mise en place de mesures correctives le cas echeant', '8.05', NULL, '8.05', NULL, NULL, FALSE, 1112),
('Q628', 'Q628', 71, NULL, 'Les analyses et mesures sont enregistrées dans le dossier de lot', '8.06', NULL, '8.06', NULL, NULL, FALSE, 1113),
('Q629', 'Q629', 71, NULL, 'A l''issu du CREX ou autre, un plan d''action est mis en place par le PRP', '8.07', NULL, '8.07', NULL, NULL, FALSE, 1114),
('Q630', 'Q630', 71, NULL, 'Les actions issue du CREX ou autre présentent des délais de mise en œuvre', '8.07', NULL, '8.07', NULL, NULL, FALSE, 1115),
('Q631', 'Q631', 71, NULL, 'Le PRP est responsable de l''ordre de destruction des préparations rappelées', '8.11', NULL, '8.11', NULL, NULL, FALSE, 1116),
('Q632', 'Q632', 71, NULL, 'Un rapport détaillé des opérations de rappel  est rédigé et conservé dans le dossier de lot.', '8.12', NULL, '8.12', NULL, NULL, FALSE, 1117),
('Q633', 'Q633', 71, NULL, 'Un bilan de rappel établit la balance entre le nombre d unités rappellées et le nombre d''unités retournées', '8.12', NULL, '8.12', NULL, NULL, FALSE, 1118),
('Q634', 'Q634', 72, NULL, 'Le système d''assurance qualité prévoit une auto-inspection ayant pour but la vérification du respect des BPP (via une procédure accompagnée d''une grille d''évaluation)', '9.01', NULL, '9.01', NULL, NULL, FALSE, 1119),
('Q635', 'Q635', 72, NULL, 'La grille d''auto-inspection couvre explicitement chaque chapitre des BPP, avec un score ou une conclusion formalisée débouchant sur des actions correctives tracées', '9.01', NULL, '9.01', NULL, NULL, FALSE, 1120),
('Q636', 'Q636', 72, NULL, 'La périodicité des auto-inspections par domaine (personnel, locaux, matériel, documents, préparation, contrôle, libération, réclamations) est définie et respectée.', '9.02', NULL, '9.02', NULL, NULL, FALSE, 1121),
('Q637', 'Q637', 72, NULL, 'Les auto-inspections sont conduites par des personnes compétentes mais n''intervenant pas directement dans le procédé observé', '9.03', NULL, '9.03', NULL, NULL, FALSE, 1122),
('Q638', 'Q638', 72, NULL, 'Chaque compte-rendu d''auto-inspection est  tracé. Il précise :', '9.04', NULL, '9.04', NULL, NULL, TRUE, 1123),
('Q638.01', 'Q638.01', 72, NULL, 'l''identité de la personne ayant réalisée l''auto-inspection', '9.04', NULL, '9.04', NULL, NULL, FALSE, 1124),
('Q638.02', 'Q638.02', 72, NULL, 'les observations', '9.04', NULL, '9.04', NULL, NULL, FALSE, 1125),
('Q638.03', 'Q638.03', 72, NULL, 'les mesures correctives proposées le cas échéant', '9.04', NULL, '9.04', NULL, NULL, FALSE, 1126),
('Q639', 'Q639', 72, NULL, 'Chaque compte-rendu d''auto-inspection intègre les observations et le cas échéant des propositions de mesures correctives', '9.04', NULL, '9.04', NULL, NULL, FALSE, 1127),
('Q640', 'Q640', 72, NULL, 'Des audit des pratiques sont réalisés régulièrement et enregistrés. Ils peuvent concerner', '2.11', NULL, '2.11, 2.18, 2.21, 2.22, 2.23, 2.25, 2.27, 5.40, LD1.111, LD1.116, LD2.013', NULL, NULL, TRUE, 1128),
('Q640.01', 'Q640.01', 72, NULL, 'la réalisation d''un test de lavage des mains', '2.11', NULL, '2.11, 2.18, 5.40', NULL, NULL, FALSE, 1129),
('Q640.02', 'Q640.02', 72, NULL, 'la simulation de bris de flacons', '2.11', NULL, '2.11, 2.18, 5.40, LD2.013', NULL, NULL, FALSE, 1130),
('Q640.03', 'Q640.03', 72, NULL, 'la vérification de l''adéquation de l''habillage (charlotte, gants, cache-barbe... ) correspond à la classe de ZAC concernée, pour chaque opérateur présent', '2.11', NULL, '2.11, 2.18, 2.21, 2.22, 2.23, 5.40, LD1.116', NULL, NULL, FALSE, 1131),
('Q640.04', 'Q640.04', 72, NULL, 'la vérification de l''absence de montres bracelets, maquillage (incluant le vernis à ongle), bijoux et autres objets personnels tels que les  téléphones portables', '2.11', NULL, '2.11, 2.18, 5.40, LD1.111, LD1.116', NULL, NULL, FALSE, 1132),
('Q640.05', 'Q640.05', 72, NULL, 'l''utilisation effective des EPI, avec cohérence au niveau d''exposition défini', '2.11', NULL, '2.11, 2.25, 5.40, LD1.116, LD2.013', NULL, NULL, FALSE, 1133),
('Q640.06', 'Q640.06', 72, NULL, 'la vérification de l''absence effective de nourriture/boisson en zone de préparation.', '2.27', NULL, '2.27', NULL, NULL, FALSE, 1134),
('Q641', 'Q641', 74, NULL, 'Le procédé de fabrication et l''environnement de préparation retenus sont adaptés aux risques spécifiques de la préparation réalisée (ex. risque microbiologique pour une préparation injectable, risque chimique/toxicologique pour une préparation cytotoxique), et cette adéquation fait l''objet d''une évaluation et de contrôles réguliers, documentés et tracés.', 'LD1.001', NULL, 'LD1.001', NULL, NULL, FALSE, 1135),
('Q642', 'Q642', 75, NULL, 'Le choix du procédé de préparation stérile (stérilisation terminale, filtration stérilisante ou préparation aseptique) est identifié et documenté le cas échant', 'LD1.002', NULL, 'LD1.002', NULL, NULL, FALSE, 1136),
('Q643', 'Q643', 76, NULL, 'Le cas échéant et lorsqu''elle est envisageable et que l''établissement dispose de l''équipement nécessaire, la stérilisation par la chaleur humide (autoclave) est privilégiée, sauf justification contraire', 'LD1.003', NULL, 'LD1.003', NULL, NULL, FALSE, 1137),
('Q644', 'Q644', 76, NULL, 'Le cas échéant, la préparation (notamment sa/ses substance(s) active(s)) présente des caractéristiques physico-chimiques compatibles avec la stérilisation envisagée, et les conditions de stérilisation font l''objet d''une validation appropriée', 'LD1.004', NULL, 'LD1.004', NULL, NULL, FALSE, 1138),
('Q645', 'Q645', 76, NULL, 'Le conditionnement final de la préparation répond aux exigences de la Pharmacopée pour les produits stériles', 'LD1.005', NULL, 'LD1.005', NULL, NULL, FALSE, 1139),
('Q646', 'Q646', 76, NULL, 'Des mesures de maîtrise du risque d''endotoxines bactériennes sont mises en œuvre à la fois sur les contenants intermédiaires et sur le contenant final (ex. qualité de l''eau, propreté des articles de conditionnement).', 'LD1.006', NULL, 'LD1.006', NULL, NULL, FALSE, 1140),
('Q647', 'Q647', 77, NULL, 'Le recours à la filtration stérilisante pour les MPUP non autoclavables est justifié, avec un choix de filtre adapté à la nature du produit et conforme aux exigences de la Pharmacopée.', 'LD1.007', NULL, 'LD1.007', NULL, NULL, FALSE, 1141),
('Q648', 'Q648', 77, NULL, 'Le reste du matériel utilisé pour la préparation est soumis à un procédé de stérilisation approprié et validé avant la filtration.', 'LD1.008', NULL, 'LD1.008', NULL, NULL, FALSE, 1142),
('Q649', 'Q649', 77, NULL, 'La filtration est à effectuer aussi près que possible du point de remplissage en environnement de classe A', 'LD1.009', NULL, 'LD1.009', NULL, NULL, FALSE, 1143),
('Q650', 'Q650', 77, NULL, 'Les solutions sont filtrées sur un filtre stérile à usage unique de porosité nominale ≤ 0,22 μm, et sa nature/ses caractéristiques sont tracées', 'LD1.010', NULL, 'LD1.010', NULL, NULL, FALSE, 1144),
('Q651', 'Q651', 77, NULL, 'La conformité de chaque lot de filtre est vérifiée via le certificat fournisseur, qui est archivé.', 'LD1.010', NULL, 'LD1.010', NULL, NULL, FALSE, 1145),
('Q652', 'Q652', 77, NULL, 'Il existe un document attestant la compatibilité physico-chimique de chaque molécule à filtrer (document officiel du laboratoire commercialisant la substance active, publication, …)', 'LD1.011', NULL, 'LD1.011', NULL, NULL, FALSE, 1146),
('Q653', 'Q653', 77, NULL, 'Une pré-filtration est réalisée sur un filtre antibactérien dans les cas où il est impossible de limiter la contamination microbienne initiale de la substance active', 'LD1.012', NULL, 'LD1.012', NULL, NULL, FALSE, 1147),
('Q654', 'Q654', 77, NULL, 'L''intégrité du filtre après usage est contrôlée, quand la conception du filtre le permet et le résultat est enregistré', 'LD1.013', NULL, 'LD1.013', NULL, NULL, FALSE, 1148),
('Q655', 'Q655', 77, NULL, 'Toute anomalie survenue lors de la filtration (ex. rupture d''intégrité du filtre) est enregistrée, analysée, et donne lieu à des actions correctives adaptées, documentées.', 'LD1.014', NULL, 'LD1.014', NULL, NULL, FALSE, 1149),
('Q656', 'Q656', 78, NULL, 'Les matériels de préparation utilisés (dispositifs de transfert, articles de conditionnement) sont stériles (méthode Pharmacopée), garantissant le maintien de la stérilité des composants tout au long du procédé aseptique.', 'LD1.015', NULL, 'LD1.015', NULL, NULL, FALSE, 1150),
('Q657', 'Q657', 78, NULL, 'Les préparations aseptiques sont réalisées dans une ZAC', 'LD1.016', NULL, 'LD1.016', NULL, NULL, FALSE, 1151),
('Q658', 'Q658', 78, NULL, 'Le choix entre procédé en système clos et procédé en système ouvert est explicite et tracé pour chaque type de préparation, en tenant compte du niveau de risque associé à chacun.', 'LD1.017', NULL, 'LD1.017', NULL, NULL, FALSE, 1152),
('Q659', 'Q659', 79, NULL, 'En système clos, le transfert du produit stérile est réalisé avec l''un des dispositifs listés ci-contre  garantissant l''absence de contact du produit stérile avec l''environnement pendant tout le prélèvement et le transfert', 'LD1.018', NULL, 'LD1.018', NULL, NULL, TRUE, 1153),
('Q659.01', 'Q659.01', 79, NULL, 'Aiguille stérile ou spike ou microspike', 'LD1.018', NULL, 'LD1.018', NULL, NULL, FALSE, 1154),
('Q659.02', 'Q659.02', 79, NULL, 'Seringue', 'LD1.018', NULL, 'LD1.018', NULL, NULL, FALSE, 1155),
('Q659.03', 'Q659.03', 79, NULL, 'Tubulure stérile', 'LD1.018', NULL, 'LD1.018', NULL, NULL, FALSE, 1156),
('Q659.04', 'Q659.04', 79, NULL, 'Autre dispositif de transfert stérile', 'LD1.018', NULL, 'LD1.018', NULL, NULL, FALSE, 1157),
('Q660', 'Q660', 79, NULL, 'En système clos, les caractéristiques du contenant initial des MPUP sont', 'LD1.018', NULL, 'LD1.018', NULL, NULL, TRUE, 1158),
('Q660.01', 'Q660.01', 79, NULL, 'Contenant initial avec bouchon en élastomère percutable à plusieurs reprises et/ou équipé de dispositifs de transfert (à privilégier)', 'LD1.018', NULL, 'LD1.018', NULL, NULL, FALSE, 1159),
('Q660.02', 'Q660.02', 79, NULL, 'Ampoule possible mais avec prélèvement dans un environnement de classe A', 'LD1.018', NULL, 'LD1.018', NULL, NULL, FALSE, 1160),
('Q661', 'Q661', 79, NULL, 'Seul du matériel stérile à usage unique et des MPUP stériles ou rendues stériles sont utilisés', 'LD1.019', NULL, 'LD1.019', NULL, NULL, FALSE, 1161),
('Q662', 'Q662', 79, NULL, 'Les MPUP utilisées sont principalements des spécialités pharmaceutiques stériles autorisées en France', 'LD1.020', NULL, 'LD1.020', NULL, NULL, FALSE, 1162),
('Q663', 'Q663', 79, NULL, 'Lorsqu''une préparation hospitalière est utilisée comme MPUP pour une autre préparation, sa stérilité est vérifiée et documentée avant utilisation.', 'LD1.021', NULL, 'LD1.021', NULL, NULL, FALSE, 1163),
('Q664', 'Q664', 79, NULL, 'Des reliquats stériles et apyrogènes peuvent être utilisés si', 'LD1.021', NULL, 'LD1.021', NULL, NULL, TRUE, 1164),
('Q664.01', 'Q664.01', 79, NULL, 'les reliquats de MPUP sont stériles et reconstituées de manière stérile', 'LD1.021', NULL, 'LD1.021', NULL, NULL, FALSE, 1165),
('Q664.02', 'Q664.02', 79, NULL, 'si la stabilité dans le temps documentée (durée précisée)', 'LD1.021', NULL, 'LD1.021', NULL, NULL, FALSE, 1166),
('Q664.03', 'Q664.03', 79, NULL, 'si les conditions de conservation sont garanties et documentées (température, lumière, hygrométrie, mouvement)', 'LD1.021', NULL, 'LD1.021', NULL, NULL, FALSE, 1167),
('Q665', 'Q665', 79, NULL, 'Les préparations terminées issues du système clos sont des solutions ou systèmes dispersés stériles, conditionnées dans un contenant stérile adapté à la voie d''administration prévue.', 'LD1.022', NULL, 'LD1.022', NULL, NULL, FALSE, 1168),
('Q666', 'Q666', 80, NULL, 'Toute étape de préparation non réalisée strictement en système clos est identifiée comme relevant du système ouvert, avec les mesures de maîtrise du risque associées.', 'LD1.023', NULL, 'LD1.023', NULL, NULL, FALSE, 1169),
('Q667', 'Q667', 80, NULL, 'Une attention particulière est portée à la qualité microbiologique des contenants intermédiaires utilisés en système ouvert et à la recherche d''endotoxines bactériennes lorsque pertinent.', 'LD1.024', NULL, 'LD1.024', NULL, NULL, FALSE, 1170),
('Q668', 'Q668', 80, NULL, 'Toute préparation aseptique en système ouvert est associée à une filtration stérilisante (filtre 0,22 μm), sauf exception dûment justifiée et documentée.', 'LD1.025', NULL, 'LD1.025', NULL, NULL, FALSE, 1171),
('Q669', 'Q669', 83, NULL, 'Chaque préparation stérile est réalisée dans une ZAC dont le niveau de propreté (classe) est adapté à l''opération réalisée, afin de réduire le risque de contamination des MPUP et des préparations terminées.', 'LD1.036', NULL, 'LD1.036, LD1.123', NULL, NULL, FALSE, 1172),
('Q670', 'Q670', 83, NULL, 'Tout accessoire, récipient ou matériel introduit en zone de classe A lors de préparations aseptiques est préalablement stérilisé (Pharmacopée ou méthode équivalente) et introduit selon un système de transfert validé empêchant l''introduction de contaminants.', 'LD1.133', NULL, 'LD1.133', NULL, NULL, FALSE, 1173),
('Q671', 'Q671', 83, NULL, 'L''intervalle de temps entre le nettoyage, le séchage et la stérilisation des accessoires/récipients/matériel, ainsi qu''entre la stérilisation et leur utilisation, est le plus court possible', 'LD1.135', NULL, 'LD1.135', NULL, NULL, FALSE, 1174),
('Q672', 'Q672', 83, NULL, 'Après leur nettoyage, les accessoires, récipients et matériel sont manipulés de façon à éviter toute recontamination', 'LD1.136', NULL, 'LD1.136', NULL, NULL, FALSE, 1175),
('Q673', 'Q673', 83, NULL, 'L''intervalle de temps entre le début de la préparation de la solution, sa filtration et sa stérilisation est le plus bref possible', 'LD1.137', NULL, 'LD1.137', NULL, NULL, FALSE, 1176),
('Q674', 'Q674', 83, NULL, 'Un essai de simulation (test de remplissage aseptique), le plus proche du procédé de préparation aseptique,  pour la validation des procédés de préparation aseptique est réalisé', 'LD1.138', NULL, 'LD1.138', NULL, NULL, FALSE, 1177),
('Q675', 'Q675', 83, NULL, 'Le test de remplissage aseptique est réalisé par un personnel qualifié', 'LD1.138', NULL, 'LD1.138', NULL, NULL, FALSE, 1178),
('Q676', 'Q676', 83, NULL, 'Le test de remplissage aseptique est réalisé lors de toute modification importante du procédé de préparation', 'LD1.138', NULL, 'LD1.138', NULL, NULL, FALSE, 1179),
('Q677', 'Q677', 83, NULL, 'Les test de remplissage aseptiques sont tracés', 'LD1.138', NULL, 'LD1.138', NULL, NULL, FALSE, 1180),
('Q678', 'Q678', 83, NULL, 'Les opérations de validation sont conçues pour n''entraîner aucun risque pour les préparations réellement destinées aux patients.', 'LD1.139', NULL, 'LD1.139', NULL, NULL, FALSE, 1181),
('Q679', 'Q679', 85, NULL, 'Les procédés de préparation et de stérilisation sont préalablement validés', 'LD1.140', NULL, 'LD1.140, LD1.141', NULL, NULL, FALSE, 1182),
('Q680', 'Q680', 85, NULL, 'La validation des procédés de préparation aseptique repose sur un essai de simulation (test de remplissage aseptique) étant au plus proche du procédé de préparation aseptique.', 'LD1.140', NULL, 'LD1.140', NULL, NULL, FALSE, 1183),
('Q681', 'Q681', 86, NULL, 'Pour les préparations magistrales dont la taille de lot ne permet pas de suivre les prescriptions de la Pharmacopée, le pharmacien en charge de la libération évalue le risque associé à la stérilité en tenant compte des paramètres critiques disponibles.', 'LD1.142', NULL, 'LD1.142', NULL, NULL, FALSE, 1184),
('Q682', 'Q682', 86, NULL, 'Un plan spécifique d''échantillonage microbiologique peut être mis en place en cas de réalisation de préparations selon un procédé identique', 'LD1.143', NULL, 'LD1.143', NULL, NULL, FALSE, 1185),
('Q683', 'Q683', 86, NULL, 'Les modes opératoires pour les préparations faisant intervenir plus de 2 substances actives permettent de mettre en place une organisation maîtrisant les risques d''erreur', 'LD1.144', NULL, 'LD1.144', NULL, NULL, FALSE, 1186),
('Q684', 'Q684', 86, NULL, 'La libération des préparations terminées tient compte des résultats de surveillance des ZAC', 'LD1.146', NULL, 'LD1.146', NULL, NULL, FALSE, 1187),
('Q685', 'Q685', 87, NULL, 'Le danger intrinsèque d''une substance manipulée est recherché dans des bases de données bibliographiques de référence (INRS, CRAT, CIRC...)', 'LD2.001', NULL, 'LD2.001', NULL, NULL, FALSE, 1188),
('Q686', 'Q686', 87, NULL, 'En l''absence de données disponibles, le danger intrinsèque est déterminé à l''aide des mentions de danger codifiées par le règlement CLP', 'LD2.002', NULL, 'LD2.002', NULL, NULL, FALSE, 1189),
('Q687', 'Q687', 87, NULL, 'Les fiches de données de securité des MPUP sont mises à disposition du personnel', 'LD2.003', NULL, 'LD2.003', NULL, NULL, FALSE, 1190),
('Q688', 'Q688', 87, NULL, 'Les mentions de danger CLP identifiées pour chaque substance sont correctement codifiées et exploitées (lettre H + code numérique)', 'LD2.004', NULL, 'LD2.004', NULL, NULL, FALSE, 1191),
('Q689', 'Q689', 87, NULL, 'En l''absence de mention de danger disponible, le RCP de la spécialité est étudié pour recueillir les informations utiles (effets pharmacologiques et indésirablesdose usuelle, toxicité aigüe, toxicité chronique, mutagénicité°', 'LD2.005', NULL, 'LD2.005', NULL, NULL, FALSE, 1192),
('Q690', 'Q690', 87, NULL, 'Un niveau d''exposition au danger est définit en collaboration avec la médecine du travail pour l''ensemble des les personnels', 'LD2.010', NULL, 'LD2.010', NULL, NULL, FALSE, 1193),
('Q691', 'Q691', 87, NULL, 'Le niveau d''exposition au danger est évalué en prenant en compte l''ensemble des éléments définis (nature du danger, caractéristiques physico-chimiques, quantité, fréquence, mesures de protection)', 'LD2.009', NULL, 'LD2.009, LD2.008', NULL, NULL, FALSE, 1194),
('Q692', 'Q692', 87, NULL, 'Le niveau d''exposition est réévaluée annuellement avec la médecine du travail', 'LD2.010', NULL, 'LD2.010', NULL, NULL, FALSE, 1195),
('Q693', 'Q693', 87, NULL, 'Les mesures de protection sont réévalués en fonction de l''évolution du niveau d''exposition', 'LD2.010', NULL, 'LD2.010', NULL, NULL, FALSE, 1196),
('Q694', 'Q694', 87, NULL, 'Le suivi biologique de l''exposition du personnel, s''il existe, est organisé et supervisé par la médecine du travail', 'LD2.011', NULL, 'LD2.011', NULL, NULL, FALSE, 1197),
('Q695', 'Q695', 87, NULL, 'Il existe une surveillance médicale adaptée et régulière', 'LD2.016', NULL, 'LD2.016', NULL, NULL, FALSE, 1198),
('Q696', 'Q696', 87, NULL, 'Il existe un suivi des accidents du travail par la médecine du travail', 'LD2.016', NULL, 'LD2.016', NULL, NULL, FALSE, 1199),
('Q697', 'Q697', 87, NULL, 'Il existe un suivi des pathologies professionnelles par la médecine du travail', 'LD2.016', NULL, 'LD2.016', NULL, NULL, FALSE, 1200);
INSERT INTO questions (id, code, section_id, parent_question_id, question, ref, ref_text, refs, depends_on_question_id, depends_on_value, is_part, sort_order) VALUES
('Q698', 'Q698', 87, NULL, 'La médecine du travail applique les mesures prévues par le droit du travail relatif à l''exposition des femmes enceintes ou allaitantes aux substances dangereuses', 'LD2.017', NULL, 'LD2.017', NULL, NULL, FALSE, 1201),
('Q699', 'Q699', 87, NULL, 'Un kit de décontamination chimique est disponible sur place', 'LD2.018', NULL, 'LD2.018', NULL, NULL, FALSE, 1202),
('Q700', 'Q700', 87, NULL, 'Un kit de décontamination biologique est disponible sur place', 'LD2.018', NULL, 'LD2.018', NULL, NULL, FALSE, 1203),
('Q701', 'Q701', 87, NULL, 'Une trousse d’urgence établie après avis du médecin du travail est disponible sur place', 'LD2.018', NULL, 'LD2.018', NULL, NULL, FALSE, 1204),
('Q702', 'Q702', 87, NULL, 'La trousse d’urgence a une date de péremption vérifiée et une localisation affichée connue de tous', 'LD2.018', NULL, 'LD2.018', NULL, NULL, FALSE, 1205),
('Q703', 'Q703', 87, NULL, 'Les 2 dispositifs d''urgence (kit chimique, kit biologique) ont une date de péremption vérifiée et une localisation affichée connue de tous', 'LD2.018', NULL, 'LD2.018', NULL, NULL, FALSE, 1206),
('Q704', 'Q704', 87, NULL, 'Une douche oculaire ou un dispositif de rince-oeil est disponible sur place', 'LD2.045', NULL, 'LD2.045', NULL, NULL, FALSE, 1207),
('Q705', 'Q705', 87, NULL, 'Le fonctionnement de la douche oculaire/rince-œil est testé périodiquement (et non simplement installé), avec date du dernier test', 'LD2.045', NULL, 'LD2.045', NULL, NULL, FALSE, 1208),
('Q706', 'Q706', 87, NULL, 'La déclaration des affections nécessitant une éviction du personnel de la zone de préparation est organisée par l''établissement est connue et appliquée par le PRP', '2.26', NULL, '2.26, LD1.110', NULL, NULL, FALSE, 1209),
('Q707', 'Q707', 88, NULL, 'Les interventions du personnel extérieur au service, et notamment celles des services d’entretien et de maintenance, sont programmées et enregistrées.', 'LD2.058', NULL, 'LD2.058', NULL, NULL, FALSE, 1210),
('Q708', 'Q708', 88, NULL, 'Pour la reconstitution des MTI de thérapie génique, dans le cadre des essais cliniques, le pharmacien désigné est informé par le promoteur des préconisations applicables', 'LD2.020', NULL, 'LD2.020', NULL, NULL, FALSE, 1211),
('Q709', 'Q709', 88, NULL, 'Selon les produits et la nature des opérations, les matériels et dispositions mis en œuvre sont adaptés aux risques encourus (contamination croisée, biocontamination, exposition du personnel)', 'LD2.030', NULL, 'LD2.030', NULL, NULL, FALSE, 1212),
('Q710', 'Q710', 90, NULL, 'Les mouvements d''entrée et de sortie des MPUP, articles de conditionnement, produits, matériel et personnel se font sans remettre en cause l''efficacité du dispositif de protection', 'LD2.044', NULL, 'LD2.044', NULL, NULL, FALSE, 1213),
('Q711', 'Q711', 92, NULL, 'La stratégie libératoire des préparations à risque est identique à celle du chapitre 6 : chaque lot fait l''objet d''une libération pharmaceutique sur la base des informations du dossier de lot', 'LD2.049', NULL, 'LD2.049', NULL, NULL, FALSE, 1214),
('Q712', 'Q712', 92, NULL, 'La circulaire DHOS/E4/DGS/SD.7B/DPPR no 2006-58 du 13 février 2006 est appliquée pour l’élimination des déchets toxiques', 'LD2.052', NULL, 'LD2.052', NULL, NULL, FALSE, 1215),
('Q713', 'Q713', 92, NULL, 'Les déchets CMR sont identifiés selon la circulaire circulaire DHOS/E4/DGS/SD.7B/DPPR no 2006-58 du 13 février 2006 (DASRI dilués/DTQD concentrés)', 'LD2.053', NULL, 'LD2.053', NULL, NULL, FALSE, 1216),
('Q714', 'Q714', 92, NULL, 'Pour la reconstitution des MTI et la mise sous forme appropriée des MTI-PP composés en tout ou partie d’OGM, les mesures de décontamination préconisées par le fabricant sont mises en place.', 'LD2.054', NULL, 'LD2.054', NULL, NULL, FALSE, 1217),
('Q715', 'Q715', 95, NULL, 'Une évaluation de la faisabilité technique de la préparation est réalisée au préalable, sur la base des informations actualisées transmises par le promoteur (avec possibilité de refus par le pharmacien) (cf. points 1.13 et 1.16 des chapitres généraux des présentes bonnes pratiques)', 'LD3.01', NULL, 'LD3.01', NULL, NULL, FALSE, 1218),
('Q716', 'Q716', 95, NULL, 'Le pharmacien s''assure que le promoteur veille à la réalisation des préparations conformément aux BPP et au dossier de préparation pharmaceutique de la RIPH', 'LD3.02', NULL, 'LD3.02', NULL, NULL, FALSE, 1219),
('Q717', 'Q717', 96, NULL, 'Le personnel collaborant  est qualifié et reçoit une formation spécifique complémentaire relative à la LD3', 'LD3.03', NULL, 'LD3.03', NULL, NULL, FALSE, 1220),
('Q718', 'Q718', 96, NULL, 'Le personnel collaborant est informé des dispositions particulières de chaque RIPH (éléments du protocole, mise en insu…)', 'LD3.04', NULL, 'LD3.04', NULL, NULL, FALSE, 1221),
('Q719', 'Q719', 97, NULL, 'Les produits et préparations liés à la RIPH sont  stockés dans une zone identifiée et dédiée', 'LD3.05', NULL, 'LD3.05', NULL, NULL, FALSE, 1222),
('Q720', 'Q720', 97, NULL, 'Un emplacement spécifique par RIPH, par dosage et par conditionnement permettant d''éviter tout risque de confusion existe', 'LD3.06', NULL, 'LD3.06', NULL, NULL, FALSE, 1223),
('Q721', 'Q721', 98, NULL, 'Lorsque le matériel est mis à disposition par le promoteur, sa mise en service et sa maintenance sont assurées par ce dernier', 'LD3.07', NULL, 'LD3.07', NULL, NULL, FALSE, 1224),
('Q722', 'Q722', 100, NULL, 'Le dossier de préparation pharmaceutique comprend ou fait référence aux documents requis (points 4.30 à 4.35 des chapitres généraux)', 'LD3.08', NULL, 'LD3.08', NULL, NULL, FALSE, 1225),
('Q723', 'Q723', 100, NULL, 'Le dossier de préparation pharmaceutique comprend ou fait référence aux éléments spécifiques suivants', 'LD3.08', NULL, 'LD3.08', NULL, NULL, TRUE, 1226),
('Q723.01', 'Q723.01', 100, NULL, 'les procédures de mise en insu au moment du conditionnement le cas échéant', 'LD3.08', NULL, 'LD3.08', NULL, NULL, FALSE, 1227),
('Q723.02', 'Q723.02', 100, NULL, 'les autorisations et les amendements de la recherche concernée', 'LD3.08', NULL, 'LD3.08', NULL, NULL, FALSE, 1228),
('Q723.03', 'Q723.03', 100, NULL, 'les versions successives du protocole de la RIPH concernée', 'LD3.08', NULL, 'LD3.08', NULL, NULL, FALSE, 1229),
('Q723.04', 'Q723.04', 100, NULL, 'les codes de randomisation, le cas échéant.', 'LD3.08', NULL, 'LD3.08', NULL, NULL, FALSE, 1230),
('Q724', 'Q724', 100, NULL, 'Les spécifications des préparations terminées comportent  les éléments requis au point 4.40 des chapitres généraux des BPP', 'LD3.09', NULL, 'LD3.09', NULL, NULL, FALSE, 1231),
('Q725', 'Q725', 101, NULL, 'Les documents relatifs à chaque lot de préparations sont conservés 5 ans après la fin de la recherche (y compris en cas d''arrêt anticipé)', 'LD3.10', NULL, 'LD3.10', NULL, NULL, FALSE, 1232),
('Q726', 'Q726', 102, NULL, 'Le pharmacien s''assure, en cas de changement pouvant impacter la préparation,  que le promoteur lui a fourni les données prouvant l''absence d''altération significative de la qualité', 'LD3.11', NULL, 'LD3.11', NULL, NULL, FALSE, 1233),
('Q727', 'Q727', 102, NULL, 'Une date limite d''utilisation adéquate est  définie et justifiée lorsque le produit a été reconditionné dans un conditionnement différent', 'LD3.12', NULL, 'LD3.12', NULL, NULL, FALSE, 1234),
('Q728', 'Q728', 103, NULL, 'Des systèmes garantissent une manipulation adaptée des préparations mises en insu, avec possibilité d''identification de la préparation et de son lot initial si nécessaire', 'LD3.13', NULL, 'LD3.13', NULL, NULL, FALSE, 1235),
('Q729', 'Q729', 103, NULL, 'La libération des préparations mises en insu s''accompagne d''une vérification de la similitude d''aspect et des autres caractéristiques requises', 'LD3.14', NULL, 'LD3.14', NULL, NULL, FALSE, 1236),
('Q730', 'Q730', 103, NULL, 'Un système d''identification rapide de la préparation en cas d''urgence nécessitant une levée de l''insu est  prévu avec le promoteur', 'LD3.15', NULL, 'LD3.15', NULL, NULL, FALSE, 1237),
('Q731', 'Q731', 103, NULL, 'Des procédures décrivent l''obtention, la sécurisation, la diffusion, l''utilisation et la conservation du code de randomisation et du système de levée d''insu, avec conservation des enregistrements correspondants', 'LD3.16', NULL, 'LD3.16', NULL, NULL, FALSE, 1238),
('Q732', 'Q732', 104, NULL, 'Les préparations sont conditionnées individuellement pour chaque personne se prêtant à la RIPH, selon les modalités suivantes', 'LD3.17', NULL, 'LD3.17', NULL, NULL, TRUE, 1239),
('Q732.01', 'Q732.01', 104, NULL, '• le nombre d''unités à conditionner est spécifié avant le début des opérations de conditionnement', 'LD3.17', NULL, 'LD3.17', NULL, NULL, FALSE, 1240),
('Q732.02', 'Q732.02', 104, NULL, '• le nombre tient  compte des unités nécessaires aux contrôles qualité et, si applicable, des échantillons à conserver', 'LD3.17', NULL, 'LD3.17', NULL, NULL, FALSE, 1241),
('Q732.03', 'Q732.03', 104, NULL, '• un bilan comparatif est établi pour vérifier que les bonnes quantités d''unités ont été utilisées à chaque étape', 'LD3.17', NULL, 'LD3.17', NULL, NULL, FALSE, 1242),
('Q733', 'Q733', 105, NULL, 'L''étiquetage des préparations rendues nécessaires par les RIPH répondaux textes en vigueur', 'LD3.18', NULL, 'LD3.18', NULL, NULL, FALSE, 1243),
('Q734', 'Q734', 106, NULL, 'Les préparations restent  sous la responsabilité du promoteur jusqu''à la libération du lot par le pharmacien (feu vert technique)', 'LD3.19', NULL, 'LD3.19', NULL, NULL, FALSE, 1244),
('Q735', 'Q735', 106, NULL, 'Le pharmacien dispose d''une information écrite (y compris électronique) du promoteur attestant que la RIPH est dûment autorisée avant délivrance (feu vert réglementaire)', 'LD3.20', NULL, 'LD3.20', NULL, NULL, FALSE, 1245),
('Q736', 'Q736', 106, NULL, 'Les étapes de libération sont tracées et la documentation correspondante conservée', 'LD3.21', NULL, 'LD3.21', NULL, NULL, TRUE, 1246),
('Q736.01', 'Q736.01', 106, NULL, '• les étapes de libération (feu vert technique et feu vert réglementaire) sont  consignées dans le dossier de lot de la préparation', 'LD3.21', NULL, 'LD3.21', NULL, NULL, FALSE, 1247),
('Q736.02', 'Q736.02', 106, NULL, '• la documentation correspondante est conservée dans les dossiers de la recherche par le promoteur', 'LD3.21', NULL, 'LD3.21', NULL, NULL, FALSE, 1248),
('Q737', 'Q737', 106, NULL, 'En cas d''opérations limitées au conditionnement/étiquetage, sous surveillance du pharmacien pharmacien responsable, le promoteur veille à ce que les opérations soient convenablement documentées et réalisées conformément aux bonnes pratiques en vigueur.', 'LD3.22', NULL, 'LD3.22', NULL, NULL, FALSE, 1249),
('Q738', 'Q738', 107, NULL, 'Des échantillons de chaque lot conditionné et de chaque période de recherche (y compris produits mis en insu) sont conservés au moins deux ans après la fin notifiée de la RIPH', 'LD3.23', NULL, 'LD3.23', NULL, NULL, FALSE, 1250),
('Q739', 'Q739', 108, NULL, 'Les opérations de réclamations, rappels, retours et destruction des préparations sont effectuées selon des procédures écrites définies par le promoteur', 'LD3.24', NULL, 'LD3.24', NULL, NULL, FALSE, 1251),
('Q740', 'Q740', 108, NULL, 'Des procédures écrites de rappel des préparations, définies conjointement par le promoteur et le pharmacien responsable des préparations, précisant les modalités de déclenchement, d''exécution et de consignation (traçabilité) de ces opérations de rappel existent', 'LD3.25', NULL, 'LD3.25', NULL, NULL, FALSE, 1252),
('Q741', 'Q741', 108, NULL, 'L''investigateur ainsi que toute personne dûment mandatée par le promoteur sont informés et ont-il connaissance de leurs obligations respectives dans le cadre de cette procédure de rappel', 'LD3.25', NULL, 'LD3.25', NULL, NULL, FALSE, 1253),
('Q742', 'Q742', 108, NULL, 'Les médicaments expérimentaux non utilisés sont retournés et/ou détruits dans des conditions définies et spécifiées par le promoteur', 'LD3.26', NULL, 'LD3.26', NULL, NULL, FALSE, 1254),
('Q743', 'Q743', 108, NULL, 'La destruction des médicaments expérimentaux non utilisés respecte les modalités suivantes :', 'LD3.27', NULL, 'LD3.27', NULL, NULL, TRUE, 1255),
('Q743.01', 'Q743.01', 108, NULL, '• elle est réalisée par lieu de recherche ou par période de recherche, après réconciliation entre produits expédiés, utilisés et retournés', 'LD3.27', NULL, 'LD3.27', NULL, NULL, FALSE, 1256),
('Q743.02', 'Q743.02', 108, NULL, '• les écarts constatés entre les quantités sont étudiés et motivés de façon satisfaisante', 'LD3.27', NULL, 'LD3.27', NULL, NULL, FALSE, 1257),
('Q743.03', 'Q743.03', 108, NULL, '• un bilan comparatif est établi et accepté par le promoteur avant destruction', 'LD3.27', NULL, 'LD3.27', NULL, NULL, FALSE, 1258),
('Q743.04', 'Q743.04', 108, NULL, '• les opérations de destruction sont enregistrées pour être comptabilisées', 'LD3.27', NULL, 'LD3.27', NULL, NULL, FALSE, 1259),
('Q743.05', 'Q743.05', 108, NULL, '• les dossiers correspondants sont conservés par le promoteur', 'LD3.27', NULL, 'LD3.27', NULL, NULL, FALSE, 1260),
('Q744', 'Q744', 108, NULL, 'Un certificat ou attestation de destruction daté est remis au promoteur, comportant les éléments suivants :', 'LD3.28', NULL, 'LD3.28', NULL, NULL, FALSE, 1261),
('Q744.01', 'Q744.01', 108, NULL, '• la traçabilité des lots et/ou des numéros de traitement et/ou des numéros de personnes incluses dans la RIPH', 'LD3.28', NULL, 'LD3.28', NULL, NULL, FALSE, 1262);
UPDATE questions q SET ref_text = t.texte FROM ref_texts t WHERE t.ref = q.ref;
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q001', depends_on_value = 'oui' WHERE id = 'Q002';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q001', depends_on_value = 'oui' WHERE id = 'Q003';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q001', depends_on_value = 'oui' WHERE id = 'Q004';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q001', depends_on_value = 'oui' WHERE id = 'Q005';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q001', depends_on_value = 'oui' WHERE id = 'Q007';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q009', depends_on_value = 'oui' WHERE id = 'Q010';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q009', depends_on_value = 'oui' WHERE id = 'Q011';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q013', depends_on_value = 'oui' WHERE id = 'Q014';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q013', depends_on_value = 'oui' WHERE id = 'Q018';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q013', depends_on_value = 'oui' WHERE id = 'Q019';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q021', depends_on_value = 'oui' WHERE id = 'Q022';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q021', depends_on_value = 'oui' WHERE id = 'Q025';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q030', depends_on_value = 'oui' WHERE id = 'Q031';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q035', depends_on_value = 'oui' WHERE id = 'Q036';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q035', depends_on_value = 'oui' WHERE id = 'Q037';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q042';
UPDATE questions SET parent_question_id = 'Q042', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q042.01';
UPDATE questions SET parent_question_id = 'Q042', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q042.02';
UPDATE questions SET parent_question_id = 'Q042', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q042.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q043';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q044';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q044', depends_on_value = 'oui' WHERE id = 'Q045';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q046';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q048';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q048', depends_on_value = 'oui' WHERE id = 'Q049';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q048', depends_on_value = 'oui' WHERE id = 'Q050';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q048', depends_on_value = 'oui' WHERE id = 'Q051';
UPDATE questions SET parent_question_id = 'Q051', depends_on_question_id = 'Q048', depends_on_value = 'oui' WHERE id = 'Q051.01';
UPDATE questions SET parent_question_id = 'Q051', depends_on_question_id = 'Q048', depends_on_value = 'oui' WHERE id = 'Q051.02';
UPDATE questions SET parent_question_id = 'Q051', depends_on_question_id = 'Q048', depends_on_value = 'oui' WHERE id = 'Q051.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q048', depends_on_value = 'oui' WHERE id = 'Q052';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q053';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q054';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q055';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q056';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q057', depends_on_value = 'oui' WHERE id = 'Q058';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q059';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q060';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q061';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q062';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q063';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q064';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q065';
UPDATE questions SET parent_question_id = 'Q065', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q065.01';
UPDATE questions SET parent_question_id = 'Q065', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q065.02';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q066';
UPDATE questions SET parent_question_id = 'Q066', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q066.01';
UPDATE questions SET parent_question_id = 'Q066', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q066.02';
UPDATE questions SET parent_question_id = 'Q066', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q066.03';
UPDATE questions SET parent_question_id = 'Q066', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q066.04';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q067';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q068';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q069';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q070';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q071';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q072';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q072', depends_on_value = 'oui' WHERE id = 'Q073';
UPDATE questions SET parent_question_id = 'Q073', depends_on_question_id = 'Q072', depends_on_value = 'oui' WHERE id = 'Q073.01';
UPDATE questions SET parent_question_id = 'Q073', depends_on_question_id = 'Q072', depends_on_value = 'oui' WHERE id = 'Q073.02';
UPDATE questions SET parent_question_id = 'Q073', depends_on_question_id = 'Q072', depends_on_value = 'oui' WHERE id = 'Q073.03';
UPDATE questions SET parent_question_id = 'Q073', depends_on_question_id = 'Q072', depends_on_value = 'oui' WHERE id = 'Q073.04';
UPDATE questions SET parent_question_id = 'Q073', depends_on_question_id = 'Q072', depends_on_value = 'oui' WHERE id = 'Q073.05';
UPDATE questions SET parent_question_id = 'Q073', depends_on_question_id = 'Q072', depends_on_value = 'oui' WHERE id = 'Q073.06';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q072', depends_on_value = 'oui' WHERE id = 'Q074';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q075';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q076';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q077';
UPDATE questions SET parent_question_id = 'Q077', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q077.01';
UPDATE questions SET parent_question_id = 'Q077', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q077.02';
UPDATE questions SET parent_question_id = 'Q077', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q077.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078';
UPDATE questions SET parent_question_id = 'Q078', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078.01';
UPDATE questions SET parent_question_id = 'Q078', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078.02';
UPDATE questions SET parent_question_id = 'Q078', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078.03';
UPDATE questions SET parent_question_id = 'Q078', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078.04';
UPDATE questions SET parent_question_id = 'Q078', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078.05';
UPDATE questions SET parent_question_id = 'Q078', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078.06';
UPDATE questions SET parent_question_id = 'Q078', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078.07';
UPDATE questions SET parent_question_id = 'Q078', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078.08';
UPDATE questions SET parent_question_id = 'Q078', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078.09';
UPDATE questions SET parent_question_id = 'Q078', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078.10';
UPDATE questions SET parent_question_id = 'Q078', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078.11';
UPDATE questions SET parent_question_id = 'Q078', depends_on_question_id = 'Q076', depends_on_value = 'oui' WHERE id = 'Q078.12';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q079';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q079', depends_on_value = 'oui' WHERE id = 'Q080';
UPDATE questions SET parent_question_id = 'Q080', depends_on_question_id = 'Q079', depends_on_value = 'oui' WHERE id = 'Q080.01';
UPDATE questions SET parent_question_id = 'Q080', depends_on_question_id = 'Q079', depends_on_value = 'oui' WHERE id = 'Q080.02';
UPDATE questions SET parent_question_id = 'Q080', depends_on_question_id = 'Q079', depends_on_value = 'oui' WHERE id = 'Q080.03';
UPDATE questions SET parent_question_id = 'Q080', depends_on_question_id = 'Q079', depends_on_value = 'oui' WHERE id = 'Q080.04';
UPDATE questions SET parent_question_id = 'Q080', depends_on_question_id = 'Q079', depends_on_value = 'oui' WHERE id = 'Q080.05';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q081';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q082';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q082', depends_on_value = 'oui' WHERE id = 'Q083';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q082', depends_on_value = 'oui' WHERE id = 'Q084';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q085';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q085', depends_on_value = 'oui' WHERE id = 'Q086';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q087';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q088';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q088', depends_on_value = 'oui' WHERE id = 'Q089';
UPDATE questions SET parent_question_id = 'Q089', depends_on_question_id = 'Q088', depends_on_value = 'oui' WHERE id = 'Q089.01';
UPDATE questions SET parent_question_id = 'Q089', depends_on_question_id = 'Q088', depends_on_value = 'oui' WHERE id = 'Q089.02';
UPDATE questions SET parent_question_id = 'Q089', depends_on_question_id = 'Q088', depends_on_value = 'oui' WHERE id = 'Q089.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q090';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q091';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q092';
UPDATE questions SET parent_question_id = 'Q092', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q092.01';
UPDATE questions SET parent_question_id = 'Q092', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q092.02';
UPDATE questions SET parent_question_id = 'Q092', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q092.03';
UPDATE questions SET parent_question_id = 'Q092', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q092.04';
UPDATE questions SET parent_question_id = 'Q092', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q092.05';
UPDATE questions SET parent_question_id = 'Q092', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q092.06';
UPDATE questions SET parent_question_id = 'Q092', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q092.07';
UPDATE questions SET parent_question_id = 'Q092', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q092.08';
UPDATE questions SET parent_question_id = 'Q092', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q092.09';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093';
UPDATE questions SET parent_question_id = 'Q093', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.01';
UPDATE questions SET parent_question_id = 'Q093', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.02';
UPDATE questions SET parent_question_id = 'Q093.02', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.02.01';
UPDATE questions SET parent_question_id = 'Q093.02', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.02.02';
UPDATE questions SET parent_question_id = 'Q093.02', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.02.03';
UPDATE questions SET parent_question_id = 'Q093', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.03';
UPDATE questions SET parent_question_id = 'Q093', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.04';
UPDATE questions SET parent_question_id = 'Q093', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.05';
UPDATE questions SET parent_question_id = 'Q093', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.06';
UPDATE questions SET parent_question_id = 'Q093', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.07';
UPDATE questions SET parent_question_id = 'Q093', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.08';
UPDATE questions SET parent_question_id = 'Q093', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.09';
UPDATE questions SET parent_question_id = 'Q093.09', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.09.01';
UPDATE questions SET parent_question_id = 'Q093.09', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.09.02';
UPDATE questions SET parent_question_id = 'Q093', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.10';
UPDATE questions SET parent_question_id = 'Q093', depends_on_question_id = 'Q091', depends_on_value = 'oui' WHERE id = 'Q093.11';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q094';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q094', depends_on_value = 'oui' WHERE id = 'Q095';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q094', depends_on_value = 'oui' WHERE id = 'Q096';
UPDATE questions SET parent_question_id = 'Q096', depends_on_question_id = 'Q094', depends_on_value = 'oui' WHERE id = 'Q096.01';
UPDATE questions SET parent_question_id = 'Q096', depends_on_question_id = 'Q094', depends_on_value = 'oui' WHERE id = 'Q096.02';
UPDATE questions SET parent_question_id = 'Q096', depends_on_question_id = 'Q094', depends_on_value = 'oui' WHERE id = 'Q096.03';
UPDATE questions SET parent_question_id = 'Q096', depends_on_question_id = 'Q094', depends_on_value = 'oui' WHERE id = 'Q096.04';
UPDATE questions SET parent_question_id = 'Q096', depends_on_question_id = 'Q094', depends_on_value = 'oui' WHERE id = 'Q096.05';
UPDATE questions SET parent_question_id = 'Q096', depends_on_question_id = 'Q094', depends_on_value = 'oui' WHERE id = 'Q096.06';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q097';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q098';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q098', depends_on_value = 'oui' WHERE id = 'Q099';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q100';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q100', depends_on_value = 'oui' WHERE id = 'Q101';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q100', depends_on_value = 'oui' WHERE id = 'Q102';
UPDATE questions SET parent_question_id = 'Q102', depends_on_question_id = 'Q100', depends_on_value = 'oui' WHERE id = 'Q102.01';
UPDATE questions SET parent_question_id = 'Q102', depends_on_question_id = 'Q100', depends_on_value = 'oui' WHERE id = 'Q102.02';
UPDATE questions SET parent_question_id = 'Q102', depends_on_question_id = 'Q100', depends_on_value = 'oui' WHERE id = 'Q102.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q103';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q104';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q105';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q106';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q106', depends_on_value = 'oui' WHERE id = 'Q107';
UPDATE questions SET parent_question_id = 'Q107', depends_on_question_id = 'Q106', depends_on_value = 'oui' WHERE id = 'Q107.01';
UPDATE questions SET parent_question_id = 'Q107', depends_on_question_id = 'Q106', depends_on_value = 'oui' WHERE id = 'Q107.02';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q106', depends_on_value = 'oui' WHERE id = 'Q108';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q109';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q109', depends_on_value = 'oui' WHERE id = 'Q110';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q109', depends_on_value = 'oui' WHERE id = 'Q111';
UPDATE questions SET parent_question_id = 'Q111', depends_on_question_id = 'Q109', depends_on_value = 'oui' WHERE id = 'Q111.01';
UPDATE questions SET parent_question_id = 'Q111', depends_on_question_id = 'Q109', depends_on_value = 'oui' WHERE id = 'Q111.02';
UPDATE questions SET parent_question_id = 'Q111', depends_on_question_id = 'Q109', depends_on_value = 'oui' WHERE id = 'Q111.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q112';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q112', depends_on_value = 'oui' WHERE id = 'Q113';
UPDATE questions SET parent_question_id = 'Q113', depends_on_question_id = 'Q112', depends_on_value = 'oui' WHERE id = 'Q113.01';
UPDATE questions SET parent_question_id = 'Q113', depends_on_question_id = 'Q112', depends_on_value = 'oui' WHERE id = 'Q113.02';
UPDATE questions SET parent_question_id = 'Q113', depends_on_question_id = 'Q112', depends_on_value = 'oui' WHERE id = 'Q113.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q109', depends_on_value = 'oui' WHERE id = 'Q114';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q115';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q115', depends_on_value = 'oui' WHERE id = 'Q116';
UPDATE questions SET parent_question_id = 'Q116', depends_on_question_id = 'Q115', depends_on_value = 'oui' WHERE id = 'Q116.01';
UPDATE questions SET parent_question_id = 'Q116', depends_on_question_id = 'Q115', depends_on_value = 'oui' WHERE id = 'Q116.02';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q115', depends_on_value = 'oui' WHERE id = 'Q117';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q118';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q119';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q120';
UPDATE questions SET parent_question_id = 'Q120', depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q120.01';
UPDATE questions SET parent_question_id = 'Q120', depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q120.02';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q121';
UPDATE questions SET parent_question_id = 'Q121', depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q121.01';
UPDATE questions SET parent_question_id = 'Q121', depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q121.02';
UPDATE questions SET parent_question_id = 'Q121', depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q121.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q121.03', depends_on_value = 'oui' WHERE id = 'Q122';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q123';
UPDATE questions SET parent_question_id = 'Q123', depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q123.01';
UPDATE questions SET parent_question_id = 'Q123', depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q123.02';
UPDATE questions SET parent_question_id = 'Q123', depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q123.03';
UPDATE questions SET parent_question_id = 'Q123', depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q123.04';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q123', depends_on_value = 'oui' WHERE id = 'Q124';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q123', depends_on_value = 'oui' WHERE id = 'Q125';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q119', depends_on_value = 'oui' WHERE id = 'Q126';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q127';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q127', depends_on_value = 'oui' WHERE id = 'Q128';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q129';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q129', depends_on_value = 'oui' WHERE id = 'Q130';
UPDATE questions SET parent_question_id = 'Q130', depends_on_question_id = 'Q129', depends_on_value = 'oui' WHERE id = 'Q130.01';
UPDATE questions SET parent_question_id = 'Q130', depends_on_question_id = 'Q129', depends_on_value = 'oui' WHERE id = 'Q130.02';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q129', depends_on_value = 'oui' WHERE id = 'Q131';
UPDATE questions SET parent_question_id = 'Q131', depends_on_question_id = 'Q129', depends_on_value = 'oui' WHERE id = 'Q131.01';
UPDATE questions SET parent_question_id = 'Q131', depends_on_question_id = 'Q129', depends_on_value = 'oui' WHERE id = 'Q131.02';
UPDATE questions SET parent_question_id = 'Q131', depends_on_question_id = 'Q129', depends_on_value = 'oui' WHERE id = 'Q131.03';
UPDATE questions SET parent_question_id = 'Q131', depends_on_question_id = 'Q129', depends_on_value = 'oui' WHERE id = 'Q131.04';
UPDATE questions SET parent_question_id = 'Q131', depends_on_question_id = 'Q129', depends_on_value = 'oui' WHERE id = 'Q131.05';
UPDATE questions SET parent_question_id = 'Q131', depends_on_question_id = 'Q129', depends_on_value = 'oui' WHERE id = 'Q131.06';
UPDATE questions SET parent_question_id = 'Q131', depends_on_question_id = 'Q129', depends_on_value = 'oui' WHERE id = 'Q131.07';
UPDATE questions SET parent_question_id = 'Q131', depends_on_question_id = 'Q129', depends_on_value = 'oui' WHERE id = 'Q131.08';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q132';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q132', depends_on_value = 'oui' WHERE id = 'Q133';
UPDATE questions SET parent_question_id = 'Q133', depends_on_question_id = 'Q132', depends_on_value = 'oui' WHERE id = 'Q133.01';
UPDATE questions SET parent_question_id = 'Q133', depends_on_question_id = 'Q132', depends_on_value = 'oui' WHERE id = 'Q133.02';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q132', depends_on_value = 'oui' WHERE id = 'Q134';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q132', depends_on_value = 'oui' WHERE id = 'Q135';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q136';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q137';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q138';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q139';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q140';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q140', depends_on_value = 'oui' WHERE id = 'Q141';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q142';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q143';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q144';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q145';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q140', depends_on_value = 'oui' WHERE id = 'Q146';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q140', depends_on_value = 'oui' WHERE id = 'Q147';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q143', depends_on_value = 'oui' WHERE id = 'Q148';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q143', depends_on_value = 'oui' WHERE id = 'Q149';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q150';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q150', depends_on_value = 'oui' WHERE id = 'Q151';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q152';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q153';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q154';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q154', depends_on_value = 'oui' WHERE id = 'Q155';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q154', depends_on_value = 'oui' WHERE id = 'Q156';
UPDATE questions SET parent_question_id = 'Q156', depends_on_question_id = 'Q154', depends_on_value = 'oui' WHERE id = 'Q156.01';
UPDATE questions SET parent_question_id = 'Q156', depends_on_question_id = 'Q154', depends_on_value = 'oui' WHERE id = 'Q156.02';
UPDATE questions SET parent_question_id = 'Q156', depends_on_question_id = 'Q154', depends_on_value = 'oui' WHERE id = 'Q156.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q154', depends_on_value = 'oui' WHERE id = 'Q157';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q154', depends_on_value = 'oui' WHERE id = 'Q158';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q159';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q159', depends_on_value = 'oui' WHERE id = 'Q160';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q159', depends_on_value = 'oui' WHERE id = 'Q161';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q159', depends_on_value = 'oui' WHERE id = 'Q162';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q163';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q164';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q165';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q166';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q167';
UPDATE questions SET parent_question_id = 'Q167', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q167.01';
UPDATE questions SET parent_question_id = 'Q167', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q167.02';
UPDATE questions SET parent_question_id = 'Q167', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q167.03';
UPDATE questions SET parent_question_id = 'Q167', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q167.04';
UPDATE questions SET parent_question_id = 'Q167', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q167.05';
UPDATE questions SET parent_question_id = 'Q167', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q167.06';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q167', depends_on_value = 'oui' WHERE id = 'Q168';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q167', depends_on_value = 'oui' WHERE id = 'Q169';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q167', depends_on_value = 'oui' WHERE id = 'Q170';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q167', depends_on_value = 'oui' WHERE id = 'Q171';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q167', depends_on_value = 'oui' WHERE id = 'Q172';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q173';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q174';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q175';
UPDATE questions SET parent_question_id = 'Q175', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q175.01';
UPDATE questions SET parent_question_id = 'Q175', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q175.02';
UPDATE questions SET parent_question_id = 'Q175', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q175.03';
UPDATE questions SET parent_question_id = 'Q175', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q175.04';
UPDATE questions SET parent_question_id = 'Q175', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q175.05';
UPDATE questions SET parent_question_id = 'Q175', depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q175.06';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q176';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q177';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q176', depends_on_value = 'oui' WHERE id = 'Q178';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q179';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q179', depends_on_value = 'oui' WHERE id = 'Q180';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q181';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q181', depends_on_value = 'oui' WHERE id = 'Q182';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q184';
UPDATE questions SET parent_question_id = 'Q184', depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q184.01';
UPDATE questions SET parent_question_id = 'Q184', depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q184.02';
UPDATE questions SET parent_question_id = 'Q184', depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q184.03';
UPDATE questions SET parent_question_id = 'Q184', depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q184.04';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q185';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q186';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q187';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q188';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q189';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q190';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q191';
UPDATE questions SET parent_question_id = 'Q191', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q191.01';
UPDATE questions SET parent_question_id = 'Q191', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q191.02';
UPDATE questions SET parent_question_id = 'Q191', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q191.03';
UPDATE questions SET parent_question_id = 'Q191', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q191.04';
UPDATE questions SET parent_question_id = 'Q191', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q191.05';
UPDATE questions SET parent_question_id = 'Q191', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q191.06';
UPDATE questions SET parent_question_id = 'Q191', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q191.07';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q192';
UPDATE questions SET parent_question_id = 'Q192', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q192.01';
UPDATE questions SET parent_question_id = 'Q192', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q192.02';
UPDATE questions SET parent_question_id = 'Q192', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q192.03';
UPDATE questions SET parent_question_id = 'Q192', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q192.04';
UPDATE questions SET parent_question_id = 'Q192', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q192.05';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q193';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q194';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q195';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q196';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197';
UPDATE questions SET parent_question_id = 'Q197', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.01';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.02';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.03';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.04';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.05';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.06';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.07';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.08';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.09';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.10';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.11';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.12';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.13';
UPDATE questions SET parent_question_id = 'Q197.01', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.01.14';
UPDATE questions SET parent_question_id = 'Q197', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.02';
UPDATE questions SET parent_question_id = 'Q197.02', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.02.01';
UPDATE questions SET parent_question_id = 'Q197.02', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.02.02';
UPDATE questions SET parent_question_id = 'Q197.02', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.02.03';
UPDATE questions SET parent_question_id = 'Q197.02', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.02.04';
UPDATE questions SET parent_question_id = 'Q197.02', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.02.05';
UPDATE questions SET parent_question_id = 'Q197', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.03';
UPDATE questions SET parent_question_id = 'Q197.03', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.03.01';
UPDATE questions SET parent_question_id = 'Q197.03', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.03.02';
UPDATE questions SET parent_question_id = 'Q197.03', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.03.03';
UPDATE questions SET parent_question_id = 'Q197.03', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.03.04';
UPDATE questions SET parent_question_id = 'Q197.03', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.03.05';
UPDATE questions SET parent_question_id = 'Q197.03', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.03.06';
UPDATE questions SET parent_question_id = 'Q197.03', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.03.07';
UPDATE questions SET parent_question_id = 'Q197', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.04';
UPDATE questions SET parent_question_id = 'Q197.04', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.04.01';
UPDATE questions SET parent_question_id = 'Q197.04', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.04.02';
UPDATE questions SET parent_question_id = 'Q197.04', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.04.03';
UPDATE questions SET parent_question_id = 'Q197.04', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.04.04';
UPDATE questions SET parent_question_id = 'Q197.04', depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q197.04.05';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q198';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q190', depends_on_value = 'oui' WHERE id = 'Q199';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q200';
UPDATE questions SET parent_question_id = 'Q200', depends_on_question_id = 'Q200', depends_on_value = 'oui' WHERE id = 'Q200.01';
UPDATE questions SET parent_question_id = 'Q200', depends_on_question_id = 'Q200', depends_on_value = 'oui' WHERE id = 'Q200.02';
UPDATE questions SET parent_question_id = 'Q200', depends_on_question_id = 'Q200', depends_on_value = 'oui' WHERE id = 'Q200.03';
UPDATE questions SET parent_question_id = 'Q200', depends_on_question_id = 'Q200', depends_on_value = 'oui' WHERE id = 'Q200.04';
UPDATE questions SET parent_question_id = 'Q200', depends_on_question_id = 'Q200', depends_on_value = 'oui' WHERE id = 'Q200.05';
UPDATE questions SET parent_question_id = 'Q200', depends_on_question_id = 'Q200', depends_on_value = 'oui' WHERE id = 'Q200.06';
UPDATE questions SET parent_question_id = 'Q200', depends_on_question_id = 'Q200', depends_on_value = 'oui' WHERE id = 'Q200.07';
UPDATE questions SET parent_question_id = 'Q200', depends_on_question_id = 'Q200', depends_on_value = 'oui' WHERE id = 'Q200.08';
UPDATE questions SET parent_question_id = 'Q200', depends_on_question_id = 'Q200', depends_on_value = 'oui' WHERE id = 'Q200.09';
UPDATE questions SET parent_question_id = 'Q200', depends_on_question_id = 'Q200', depends_on_value = 'oui' WHERE id = 'Q200.10';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q200', depends_on_value = 'oui' WHERE id = 'Q201';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q200', depends_on_value = 'oui' WHERE id = 'Q202';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q203';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q204';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q204', depends_on_value = 'oui' WHERE id = 'Q205';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q206';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q207';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q208';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q209';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q209', depends_on_value = 'oui' WHERE id = 'Q210';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q211';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q212';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q213';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q006', depends_on_value = 'oui' WHERE id = 'Q214-A';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q214-A', depends_on_value = 'oui' WHERE id = 'Q214';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q214-A', depends_on_value = 'oui' WHERE id = 'Q215';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q214-A', depends_on_value = 'oui' WHERE id = 'Q216';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q214-A', depends_on_value = 'oui' WHERE id = 'Q217';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q214-A', depends_on_value = 'oui' WHERE id = 'Q218';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q214-A', depends_on_value = 'oui' WHERE id = 'Q219';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q222';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q223';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q224';
UPDATE questions SET parent_question_id = 'Q224', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q224.01';
UPDATE questions SET parent_question_id = 'Q224', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q224.02';
UPDATE questions SET parent_question_id = 'Q224', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q224.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q225';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q226';
UPDATE questions SET parent_question_id = 'Q226', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q226.01';
UPDATE questions SET parent_question_id = 'Q226', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q226.02';
UPDATE questions SET parent_question_id = 'Q226', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q226.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q227';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q228';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q229';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q230';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q231';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q232';
UPDATE questions SET parent_question_id = 'Q232', depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q232.01';
UPDATE questions SET parent_question_id = 'Q232', depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q232.02';
UPDATE questions SET parent_question_id = 'Q232', depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q232.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q233';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q234';
UPDATE questions SET parent_question_id = 'Q234', depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q234.01';
UPDATE questions SET parent_question_id = 'Q234', depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q234.02';
UPDATE questions SET parent_question_id = 'Q234', depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q234.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q228', depends_on_value = 'oui' WHERE id = 'Q235';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q236', depends_on_value = 'oui' WHERE id = 'Q237';
UPDATE questions SET parent_question_id = 'Q237', depends_on_question_id = 'Q236', depends_on_value = 'oui' WHERE id = 'Q237.01';
UPDATE questions SET parent_question_id = 'Q237', depends_on_question_id = 'Q236', depends_on_value = 'oui' WHERE id = 'Q237.02';
UPDATE questions SET parent_question_id = 'Q237', depends_on_question_id = 'Q236', depends_on_value = 'oui' WHERE id = 'Q237.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q236', depends_on_value = 'oui' WHERE id = 'Q238';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q244';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245';
UPDATE questions SET parent_question_id = 'Q245', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.01';
UPDATE questions SET parent_question_id = 'Q245.01', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.01.01';
UPDATE questions SET parent_question_id = 'Q245.01', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.01.02';
UPDATE questions SET parent_question_id = 'Q245.01', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.01.03';
UPDATE questions SET parent_question_id = 'Q245.01', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.01.04';
UPDATE questions SET parent_question_id = 'Q245.01', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.01.05';
UPDATE questions SET parent_question_id = 'Q245.01', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.01.06';
UPDATE questions SET parent_question_id = 'Q245.01', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.01.07';
UPDATE questions SET parent_question_id = 'Q245.01', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.01.08';
UPDATE questions SET parent_question_id = 'Q245.01', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.01.09';
UPDATE questions SET parent_question_id = 'Q245.01', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.01.10';
UPDATE questions SET parent_question_id = 'Q245', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.02';
UPDATE questions SET parent_question_id = 'Q245.02', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.02.01';
UPDATE questions SET parent_question_id = 'Q245.02', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.02.02';
UPDATE questions SET parent_question_id = 'Q245.02', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.02.03';
UPDATE questions SET parent_question_id = 'Q245.02', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.02.04';
UPDATE questions SET parent_question_id = 'Q245.02', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.02.05';
UPDATE questions SET parent_question_id = 'Q245', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.03';
UPDATE questions SET parent_question_id = 'Q245.03', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.03.01';
UPDATE questions SET parent_question_id = 'Q245.03', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.03.02';
UPDATE questions SET parent_question_id = 'Q245.03', depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q245.03.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q246';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q247';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q248';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q249';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q221', depends_on_value = 'oui' WHERE id = 'Q250';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q250', depends_on_value = 'oui' WHERE id = 'Q251';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q253';
UPDATE questions SET parent_question_id = 'Q253', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q253.01';
UPDATE questions SET parent_question_id = 'Q253', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q253.02';
UPDATE questions SET parent_question_id = 'Q253', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q253.03';
UPDATE questions SET parent_question_id = 'Q253', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q253.04';
UPDATE questions SET parent_question_id = 'Q253', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q253.05';
UPDATE questions SET parent_question_id = 'Q253', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q253.06';
UPDATE questions SET parent_question_id = 'Q253', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q253.07';
UPDATE questions SET parent_question_id = 'Q253', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q253.08';
UPDATE questions SET parent_question_id = 'Q253', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q253.09';
UPDATE questions SET parent_question_id = 'Q253', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q253.10';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q254';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q255';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q256';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q257';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q258';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q259';
UPDATE questions SET parent_question_id = 'Q259', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q259.01';
UPDATE questions SET parent_question_id = 'Q259', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q259.02';
UPDATE questions SET parent_question_id = 'Q259', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q259.03';
UPDATE questions SET parent_question_id = 'Q259', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q259.04';
UPDATE questions SET parent_question_id = 'Q259', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q259.05';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q260';
UPDATE questions SET parent_question_id = 'Q260', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q260.01';
UPDATE questions SET parent_question_id = 'Q260', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q260.02';
UPDATE questions SET parent_question_id = 'Q260', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q260.03';
UPDATE questions SET parent_question_id = 'Q260', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q260.04';
UPDATE questions SET parent_question_id = 'Q260', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q260.05';
UPDATE questions SET parent_question_id = 'Q260', depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q260.06';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q261';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q262';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q263';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q136', depends_on_value = 'oui' WHERE id = 'Q264';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q106', depends_on_value = 'oui' WHERE id = 'Q265';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q267';
UPDATE questions SET parent_question_id = 'Q267', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q267.01';
UPDATE questions SET parent_question_id = 'Q267', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q267.02';
UPDATE questions SET parent_question_id = 'Q267', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q267.03';
UPDATE questions SET parent_question_id = 'Q267', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q267.04';
UPDATE questions SET parent_question_id = 'Q267', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q267.05';
UPDATE questions SET parent_question_id = 'Q267', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q267.06';
UPDATE questions SET parent_question_id = 'Q267', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q267.07';
UPDATE questions SET parent_question_id = 'Q267', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q267.08';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q140', depends_on_value = 'oui' WHERE id = 'Q268';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q269';
UPDATE questions SET parent_question_id = 'Q269', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q269.01';
UPDATE questions SET parent_question_id = 'Q269', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q269.02';
UPDATE questions SET parent_question_id = 'Q269', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q269.03';
UPDATE questions SET parent_question_id = 'Q269', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q269.04';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q270';
UPDATE questions SET parent_question_id = 'Q270', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q270.01';
UPDATE questions SET parent_question_id = 'Q270', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q270.02';
UPDATE questions SET parent_question_id = 'Q270', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q270.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q271';
UPDATE questions SET parent_question_id = 'Q271', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q271.01';
UPDATE questions SET parent_question_id = 'Q271', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q271.02';
UPDATE questions SET parent_question_id = 'Q271', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q271.03';
UPDATE questions SET parent_question_id = 'Q271', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q271.04';
UPDATE questions SET parent_question_id = 'Q271', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q271.05';
UPDATE questions SET parent_question_id = 'Q271', depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q271.06';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q272';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q138', depends_on_value = 'oui' WHERE id = 'Q273';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q140', depends_on_value = 'oui' WHERE id = 'Q274';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q143', depends_on_value = 'oui' WHERE id = 'Q275';
UPDATE questions SET parent_question_id = 'Q275', depends_on_question_id = 'Q143', depends_on_value = 'oui' WHERE id = 'Q275.01';
UPDATE questions SET parent_question_id = 'Q275', depends_on_question_id = 'Q143', depends_on_value = 'oui' WHERE id = 'Q275.02';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q143', depends_on_value = 'oui' WHERE id = 'Q276';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q143', depends_on_value = 'oui' WHERE id = 'Q277';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q285', depends_on_value = 'oui' WHERE id = 'Q286';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q288', depends_on_value = 'oui' WHERE id = 'Q289';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q288', depends_on_value = 'oui' WHERE id = 'Q290';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q288', depends_on_value = 'oui' WHERE id = 'Q291';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q293', depends_on_value = 'oui' WHERE id = 'Q294';
UPDATE questions SET parent_question_id = 'Q296', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q296.01';
UPDATE questions SET parent_question_id = 'Q296', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q296.02';
UPDATE questions SET parent_question_id = 'Q296', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q296.03';
UPDATE questions SET parent_question_id = 'Q296', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q296.04';
UPDATE questions SET parent_question_id = 'Q297', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q297.01';
UPDATE questions SET parent_question_id = 'Q297', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q297.02';
UPDATE questions SET parent_question_id = 'Q297', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q297.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q299', depends_on_value = 'oui' WHERE id = 'Q300';
UPDATE questions SET parent_question_id = 'Q301', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q301.01';
UPDATE questions SET parent_question_id = 'Q301', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q301.02';
UPDATE questions SET parent_question_id = 'Q301', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q301.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q301', depends_on_value = 'oui' WHERE id = 'Q302';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q307', depends_on_value = 'oui' WHERE id = 'Q308';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q131.01', depends_on_value = 'oui' WHERE id = 'Q309';
UPDATE questions SET parent_question_id = 'Q311', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q311.01';
UPDATE questions SET parent_question_id = 'Q311', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q311.02';
UPDATE questions SET parent_question_id = 'Q311', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q311.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q326', depends_on_value = 'oui' WHERE id = 'Q327';
UPDATE questions SET parent_question_id = 'Q328', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q328.01';
UPDATE questions SET parent_question_id = 'Q328', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q328.02';
UPDATE questions SET parent_question_id = 'Q328', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q328.03';
UPDATE questions SET parent_question_id = 'Q328', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q328.04';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q328', depends_on_value = 'oui' WHERE id = 'Q329';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q332', depends_on_value = 'oui' WHERE id = 'Q333';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q299', depends_on_value = 'oui' WHERE id = 'Q347';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q352', depends_on_value = 'oui' WHERE id = 'Q353';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q352', depends_on_value = 'oui' WHERE id = 'Q354';
UPDATE questions SET parent_question_id = 'Q358', depends_on_question_id = 'Q358', depends_on_value = 'oui' WHERE id = 'Q358.01';
UPDATE questions SET parent_question_id = 'Q358', depends_on_question_id = 'Q358', depends_on_value = 'oui' WHERE id = 'Q358.02';
UPDATE questions SET parent_question_id = 'Q358', depends_on_question_id = 'Q358', depends_on_value = 'oui' WHERE id = 'Q358.03';
UPDATE questions SET parent_question_id = 'Q358', depends_on_question_id = 'Q358', depends_on_value = 'oui' WHERE id = 'Q358.04';
UPDATE questions SET parent_question_id = 'Q358', depends_on_question_id = 'Q358', depends_on_value = 'oui' WHERE id = 'Q358.05';
UPDATE questions SET parent_question_id = 'Q358', depends_on_question_id = 'Q358', depends_on_value = 'oui' WHERE id = 'Q358.06';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q358.02', depends_on_value = 'oui' WHERE id = 'Q359';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q358.02', depends_on_value = 'oui' WHERE id = 'Q360';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q366', depends_on_value = 'oui' WHERE id = 'Q367';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q358.02', depends_on_value = 'oui' WHERE id = 'Q370';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q111.03', depends_on_value = 'oui' WHERE id = 'Q402';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q111.03', depends_on_value = 'oui' WHERE id = 'Q403';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q111.03', depends_on_value = 'oui' WHERE id = 'Q404';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q111.03', depends_on_value = 'oui' WHERE id = 'Q405';
UPDATE questions SET parent_question_id = 'Q405', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q405.01';
UPDATE questions SET parent_question_id = 'Q405', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q405.02';
UPDATE questions SET parent_question_id = 'Q405', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q405.03';
UPDATE questions SET parent_question_id = 'Q405', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q405.04';
UPDATE questions SET parent_question_id = 'Q407', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q407.01';
UPDATE questions SET parent_question_id = 'Q407', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q407.02';
UPDATE questions SET parent_question_id = 'Q407', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q407.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q420', depends_on_value = 'oui' WHERE id = 'Q421';
UPDATE questions SET parent_question_id = 'Q444', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q444.01';
UPDATE questions SET parent_question_id = 'Q444', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q444.02';
UPDATE questions SET parent_question_id = 'Q444', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q444.03';
UPDATE questions SET parent_question_id = 'Q444', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q444.04';
UPDATE questions SET parent_question_id = 'Q444', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q444.05';
UPDATE questions SET parent_question_id = 'Q460', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q460.01';
UPDATE questions SET parent_question_id = 'Q460', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q460.02';
UPDATE questions SET parent_question_id = 'Q460', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q460.03';
UPDATE questions SET parent_question_id = 'Q462', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.01';
UPDATE questions SET parent_question_id = 'Q462', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.02';
UPDATE questions SET parent_question_id = 'Q462', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.03';
UPDATE questions SET parent_question_id = 'Q462', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.04';
UPDATE questions SET parent_question_id = 'Q462', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.05';
UPDATE questions SET parent_question_id = 'Q462', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.06';
UPDATE questions SET parent_question_id = 'Q462.06', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.06.01';
UPDATE questions SET parent_question_id = 'Q462.06', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.06.02';
UPDATE questions SET parent_question_id = 'Q462.06', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.06.03';
UPDATE questions SET parent_question_id = 'Q462.06', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.06.04';
UPDATE questions SET parent_question_id = 'Q462.06', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.06.05';
UPDATE questions SET parent_question_id = 'Q462', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.07';
UPDATE questions SET parent_question_id = 'Q462', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.08';
UPDATE questions SET parent_question_id = 'Q462', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q462.09';
UPDATE questions SET parent_question_id = 'Q491', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q491.01';
UPDATE questions SET parent_question_id = 'Q491', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q491.02';
UPDATE questions SET parent_question_id = 'Q491', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q491.03';
UPDATE questions SET parent_question_id = 'Q491', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q491.04';
UPDATE questions SET parent_question_id = 'Q492', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q492.01';
UPDATE questions SET parent_question_id = 'Q492', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q492.02';
UPDATE questions SET parent_question_id = 'Q492', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q492.03';
UPDATE questions SET parent_question_id = 'Q493', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q493.01';
UPDATE questions SET parent_question_id = 'Q493', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q493.02';
UPDATE questions SET parent_question_id = 'Q493', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q493.03';
UPDATE questions SET parent_question_id = 'Q493', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q493.04';
UPDATE questions SET parent_question_id = 'Q493', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q493.05';
UPDATE questions SET parent_question_id = 'Q497', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q497.01';
UPDATE questions SET parent_question_id = 'Q497', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q497.02';
UPDATE questions SET parent_question_id = 'Q497', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q497.03';
UPDATE questions SET parent_question_id = 'Q497', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q497.04';
UPDATE questions SET parent_question_id = 'Q497', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q497.05';
UPDATE questions SET parent_question_id = 'Q497', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q497.06';
UPDATE questions SET parent_question_id = 'Q497', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q497.07';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q508', depends_on_value = 'oui' WHERE id = 'Q512';
UPDATE questions SET parent_question_id = 'Q513', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q513.01';
UPDATE questions SET parent_question_id = 'Q513', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q513.02';
UPDATE questions SET parent_question_id = 'Q513', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q513.03';
UPDATE questions SET parent_question_id = 'Q513', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q513.04';
UPDATE questions SET parent_question_id = 'Q513', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q513.05';
UPDATE questions SET parent_question_id = 'Q529', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q529.01';
UPDATE questions SET parent_question_id = 'Q529', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q529.02';
UPDATE questions SET parent_question_id = 'Q529', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q529.03';
UPDATE questions SET parent_question_id = 'Q529', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q529.04';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q529', depends_on_value = 'oui' WHERE id = 'Q530';
UPDATE questions SET parent_question_id = 'Q537', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q537.01';
UPDATE questions SET parent_question_id = 'Q537', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q537.02';
UPDATE questions SET parent_question_id = 'Q537', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q537.03';
UPDATE questions SET parent_question_id = 'Q537', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q537.04';
UPDATE questions SET parent_question_id = 'Q546', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q546.01';
UPDATE questions SET parent_question_id = 'Q546', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q546.02';
UPDATE questions SET parent_question_id = 'Q546', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q546.03';
UPDATE questions SET parent_question_id = 'Q546', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q546.04';
UPDATE questions SET parent_question_id = 'Q547', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q547.01';
UPDATE questions SET parent_question_id = 'Q547', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q547.02';
UPDATE questions SET parent_question_id = 'Q547', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q547.03';
UPDATE questions SET parent_question_id = 'Q547', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q547.04';
UPDATE questions SET parent_question_id = 'Q547', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q547.05';
UPDATE questions SET parent_question_id = 'Q547', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q547.06';
UPDATE questions SET parent_question_id = 'Q547', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q547.07';
UPDATE questions SET parent_question_id = 'Q548', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q548.01';
UPDATE questions SET parent_question_id = 'Q548', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q548.02';
UPDATE questions SET parent_question_id = 'Q548', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q548.03';
UPDATE questions SET parent_question_id = 'Q548', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q548.04';
UPDATE questions SET parent_question_id = 'Q548', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q548.05';
UPDATE questions SET parent_question_id = 'Q548', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q548.06';
UPDATE questions SET parent_question_id = 'Q548', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q548.07';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q549';
UPDATE questions SET parent_question_id = 'Q549', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.01';
UPDATE questions SET parent_question_id = 'Q549', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.02';
UPDATE questions SET parent_question_id = 'Q549.02', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.02.01';
UPDATE questions SET parent_question_id = 'Q549.02', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.02.02';
UPDATE questions SET parent_question_id = 'Q549.02', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.02.03';
UPDATE questions SET parent_question_id = 'Q549.02', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.02.04';
UPDATE questions SET parent_question_id = 'Q549.02', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.02.05';
UPDATE questions SET parent_question_id = 'Q549', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.03';
UPDATE questions SET parent_question_id = 'Q549.03', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.03.01';
UPDATE questions SET parent_question_id = 'Q549.03', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.03.02';
UPDATE questions SET parent_question_id = 'Q549.03', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.03.03';
UPDATE questions SET parent_question_id = 'Q549', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.04';
UPDATE questions SET parent_question_id = 'Q549', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q549.05';
UPDATE questions SET parent_question_id = 'Q550', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q550.01';
UPDATE questions SET parent_question_id = 'Q550', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q550.02';
UPDATE questions SET parent_question_id = 'Q550', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q550.03';
UPDATE questions SET parent_question_id = 'Q550', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q550.04';
UPDATE questions SET parent_question_id = 'Q550', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q550.05';
UPDATE questions SET parent_question_id = 'Q550', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q550.06';
UPDATE questions SET parent_question_id = 'Q550', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q550.07';
UPDATE questions SET parent_question_id = 'Q550', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q550.08';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q552';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q068', depends_on_value = 'oui' WHERE id = 'Q553';
UPDATE questions SET parent_question_id = 'Q557', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q557.01';
UPDATE questions SET parent_question_id = 'Q557', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q557.02';
UPDATE questions SET parent_question_id = 'Q557', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q557.03';
UPDATE questions SET parent_question_id = 'Q557', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q557.04';
UPDATE questions SET parent_question_id = 'Q557', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q557.05';
UPDATE questions SET parent_question_id = 'Q560', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.01';
UPDATE questions SET parent_question_id = 'Q560', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.02';
UPDATE questions SET parent_question_id = 'Q560.02', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.02.01';
UPDATE questions SET parent_question_id = 'Q560.02', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.02.02';
UPDATE questions SET parent_question_id = 'Q560.02', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.02.03';
UPDATE questions SET parent_question_id = 'Q560.02', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.02.04';
UPDATE questions SET parent_question_id = 'Q560', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.03';
UPDATE questions SET parent_question_id = 'Q560', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.04';
UPDATE questions SET parent_question_id = 'Q560', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.05';
UPDATE questions SET parent_question_id = 'Q560', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.06';
UPDATE questions SET parent_question_id = 'Q560.06', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.06.01';
UPDATE questions SET parent_question_id = 'Q560.06', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.06.02';
UPDATE questions SET parent_question_id = 'Q560', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.07';
UPDATE questions SET parent_question_id = 'Q560', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.08';
UPDATE questions SET parent_question_id = 'Q560', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.09';
UPDATE questions SET parent_question_id = 'Q560.09', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.09.01';
UPDATE questions SET parent_question_id = 'Q560.09', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q560.09.02';
UPDATE questions SET parent_question_id = 'Q580', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q580.01';
UPDATE questions SET parent_question_id = 'Q580.01', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q580.01.01';
UPDATE questions SET parent_question_id = 'Q580.01', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q580.01.02';
UPDATE questions SET parent_question_id = 'Q580', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q580.02';
UPDATE questions SET parent_question_id = 'Q580.02', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q580.02.01';
UPDATE questions SET parent_question_id = 'Q580.02', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q580.02.02';
UPDATE questions SET parent_question_id = 'Q580', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q580.03';
UPDATE questions SET parent_question_id = 'Q580.03', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q580.03.01';
UPDATE questions SET parent_question_id = 'Q580.03', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q580.03.02';
UPDATE questions SET parent_question_id = 'Q580', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q580.04';
UPDATE questions SET parent_question_id = 'Q580.04', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q580.04.01';
UPDATE questions SET parent_question_id = 'Q580.04', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q580.04.02';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q582';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q583';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q584';
UPDATE questions SET parent_question_id = 'Q584', depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q584.01';
UPDATE questions SET parent_question_id = 'Q584', depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q584.02';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q585';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q586';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q587';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q588';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q589';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q590';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q591';
UPDATE questions SET parent_question_id = 'Q592', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q592.01';
UPDATE questions SET parent_question_id = 'Q592', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q592.02';
UPDATE questions SET parent_question_id = 'Q592', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q592.03';
UPDATE questions SET parent_question_id = 'Q592', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q592.04';
UPDATE questions SET parent_question_id = 'Q596', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q596.01';
UPDATE questions SET parent_question_id = 'Q596', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q596.02';
UPDATE questions SET parent_question_id = 'Q596', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q596.03';
UPDATE questions SET parent_question_id = 'Q596', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q596.04';
UPDATE questions SET parent_question_id = 'Q598', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q598.01';
UPDATE questions SET parent_question_id = 'Q598', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q598.02';
UPDATE questions SET parent_question_id = 'Q598', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q598.03';
UPDATE questions SET parent_question_id = 'Q598', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q598.04';
UPDATE questions SET parent_question_id = 'Q598', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q598.05';
UPDATE questions SET parent_question_id = 'Q598', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q598.06';
UPDATE questions SET parent_question_id = 'Q598', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q598.07';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q599';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q601';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q602';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q604';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q605';
UPDATE questions SET parent_question_id = 'Q606', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q606.01';
UPDATE questions SET parent_question_id = 'Q606', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q606.02';
UPDATE questions SET parent_question_id = 'Q606', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q606.03';
UPDATE questions SET parent_question_id = 'Q607', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q607.01';
UPDATE questions SET parent_question_id = 'Q607', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q607.02';
UPDATE questions SET parent_question_id = 'Q607', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q607.03';
UPDATE questions SET parent_question_id = 'Q607', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q607.04';
UPDATE questions SET parent_question_id = 'Q607', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q607.05';
UPDATE questions SET parent_question_id = 'Q607', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q607.06';
UPDATE questions SET parent_question_id = 'Q607', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q607.07';
UPDATE questions SET parent_question_id = 'Q607', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q607.08';
UPDATE questions SET parent_question_id = 'Q607', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q607.09';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q609';
UPDATE questions SET parent_question_id = 'Q609', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q609.01';
UPDATE questions SET parent_question_id = 'Q609', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q609.02';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q610';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q612';
UPDATE questions SET parent_question_id = 'Q612', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q612.01';
UPDATE questions SET parent_question_id = 'Q612', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q612.02';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q613';
UPDATE questions SET parent_question_id = 'Q614', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q614.01';
UPDATE questions SET parent_question_id = 'Q614', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q614.02';
UPDATE questions SET parent_question_id = 'Q614', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q614.03';
UPDATE questions SET parent_question_id = 'Q614', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q614.04';
UPDATE questions SET parent_question_id = 'Q614', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q614.05';
UPDATE questions SET parent_question_id = 'Q614', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q614.06';
UPDATE questions SET parent_question_id = 'Q614', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q614.07';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q616';
UPDATE questions SET parent_question_id = 'Q616', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q616.01';
UPDATE questions SET parent_question_id = 'Q616', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q616.02';
UPDATE questions SET parent_question_id = 'Q616', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q616.03';
UPDATE questions SET parent_question_id = 'Q616', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q616.04';
UPDATE questions SET parent_question_id = 'Q616', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q616.05';
UPDATE questions SET parent_question_id = 'Q616', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q616.06';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q618';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q619';
UPDATE questions SET parent_question_id = 'Q619', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q619.01';
UPDATE questions SET parent_question_id = 'Q619', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q619.02';
UPDATE questions SET parent_question_id = 'Q619', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q619.03';
UPDATE questions SET parent_question_id = 'Q619', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q619.04';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q580', depends_on_value = 'oui' WHERE id = 'Q620';
UPDATE questions SET parent_question_id = 'Q620', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q620.01';
UPDATE questions SET parent_question_id = 'Q620', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q620.02';
UPDATE questions SET parent_question_id = 'Q620', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q620.03';
UPDATE questions SET parent_question_id = 'Q620', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q620.04';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q621', depends_on_value = 'oui' WHERE id = 'Q622';
UPDATE questions SET parent_question_id = 'Q622', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q622.01';
UPDATE questions SET parent_question_id = 'Q622', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q622.02';
UPDATE questions SET parent_question_id = 'Q622', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q622.03';
UPDATE questions SET parent_question_id = 'Q622', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q622.04';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q622', depends_on_value = 'oui' WHERE id = 'Q623';
UPDATE questions SET parent_question_id = 'Q623', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q623.01';
UPDATE questions SET parent_question_id = 'Q623', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q623.02';
UPDATE questions SET parent_question_id = 'Q623', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q623.03';
UPDATE questions SET parent_question_id = 'Q623', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q623.04';
UPDATE questions SET parent_question_id = 'Q623.04', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q623.04.01';
UPDATE questions SET parent_question_id = 'Q623.04', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q623.04.02';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q625', depends_on_value = 'oui' WHERE id = 'Q626';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q625', depends_on_value = 'oui' WHERE id = 'Q627';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q629', depends_on_value = 'oui' WHERE id = 'Q630';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q632', depends_on_value = 'oui' WHERE id = 'Q633';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q634', depends_on_value = 'oui' WHERE id = 'Q635';
UPDATE questions SET parent_question_id = 'Q638', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q638.01';
UPDATE questions SET parent_question_id = 'Q638', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q638.02';
UPDATE questions SET parent_question_id = 'Q638', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q638.03';
UPDATE questions SET parent_question_id = 'Q640', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q640.01';
UPDATE questions SET parent_question_id = 'Q640', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q640.02';
UPDATE questions SET parent_question_id = 'Q640', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q640.03';
UPDATE questions SET parent_question_id = 'Q640', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q640.04';
UPDATE questions SET parent_question_id = 'Q640', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q640.05';
UPDATE questions SET parent_question_id = 'Q640', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q640.06';
UPDATE questions SET parent_question_id = 'Q659', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q659.01';
UPDATE questions SET parent_question_id = 'Q659', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q659.02';
UPDATE questions SET parent_question_id = 'Q659', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q659.03';
UPDATE questions SET parent_question_id = 'Q659', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q659.04';
UPDATE questions SET parent_question_id = 'Q660', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q660.01';
UPDATE questions SET parent_question_id = 'Q660', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q660.02';
UPDATE questions SET parent_question_id = 'Q664', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q664.01';
UPDATE questions SET parent_question_id = 'Q664', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q664.02';
UPDATE questions SET parent_question_id = 'Q664', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q664.03';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q675', depends_on_value = 'oui' WHERE id = 'Q677';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q690', depends_on_value = 'oui' WHERE id = 'Q691';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q690', depends_on_value = 'oui' WHERE id = 'Q692';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q692', depends_on_value = 'oui' WHERE id = 'Q693';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q701', depends_on_value = 'oui' WHERE id = 'Q702';
UPDATE questions SET parent_question_id = NULL, depends_on_question_id = 'Q704', depends_on_value = 'oui' WHERE id = 'Q705';
UPDATE questions SET parent_question_id = 'Q723', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q723.01';
UPDATE questions SET parent_question_id = 'Q723', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q723.02';
UPDATE questions SET parent_question_id = 'Q723', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q723.03';
UPDATE questions SET parent_question_id = 'Q723', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q723.04';
UPDATE questions SET parent_question_id = 'Q732', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q732.01';
UPDATE questions SET parent_question_id = 'Q732', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q732.02';
UPDATE questions SET parent_question_id = 'Q732', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q732.03';
UPDATE questions SET parent_question_id = 'Q736', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q736.01';
UPDATE questions SET parent_question_id = 'Q736', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q736.02';
UPDATE questions SET parent_question_id = 'Q743', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q743.01';
UPDATE questions SET parent_question_id = 'Q743', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q743.02';
UPDATE questions SET parent_question_id = 'Q743', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q743.03';
UPDATE questions SET parent_question_id = 'Q743', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q743.04';
UPDATE questions SET parent_question_id = 'Q743', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q743.05';
UPDATE questions SET parent_question_id = 'Q744', depends_on_question_id = NULL, depends_on_value = NULL WHERE id = 'Q744.01';

ALTER TABLE responses ADD CONSTRAINT responses_question_id_fkey FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE;
INSERT INTO referentiel_info (id, version) VALUES (1, '2026-10-07') ON CONFLICT (id) DO UPDATE SET version = EXCLUDED.version, imported_at = now();
