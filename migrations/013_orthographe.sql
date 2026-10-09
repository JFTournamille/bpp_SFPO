-- Corrections d'orthographe, d'accord et de typographie des intitulés (relecture du 09/10/2026).
-- Reportées dans le fichier maître referentiel/referentiel_BPP_SFPO.xlsx (colonne « Intitulé »). Codes inchangés : réponses conservées.
UPDATE questions SET question = 'Ce système est contrôlé (auto-inspection, audits…)' WHERE id = 'Q004';
UPDATE questions SET question = 'Des indicateurs qualité sont identifiés et suivis' WHERE id = 'Q005';
UPDATE questions SET question = 'Le Système d''Assurance Qualité est basé sur les "Bonnes Pratiques de Préparation" publiées par l''ANSM en 2023 (documents qualité intégrant les BPP)' WHERE id = 'Q006';
UPDATE questions SET question = 'Des revues qualité sont organisées selon une périodicité définie après analyse des réclamations et des non-conformités' WHERE id = 'Q010';
UPDATE questions SET question = 'Les revues qualité sont documentées' WHERE id = 'Q011';
UPDATE questions SET question = 'Les revues qualité alimentent l''analyse globale de risque' WHERE id = 'Q012';
UPDATE questions SET question = 'L''analyse pharmaceutique et réglementaire pour chaque type de préparation (annexe I) est réalisée et en cas de refus un critère explicite est tracé pour justifier la non-réalisation' WHERE id = 'Q015';
UPDATE questions SET question = 'En cas d’impossibilité de réalisation de préparation, un contrat de sous-traitance est établi en amont, selon les modalités décrites par le présent texte.' WHERE id = 'Q016';
UPDATE questions SET question = 'Une analyse de risque est réalisée pour la conception et l’aménagement des locaux (matière première utilisée/procédé utilisé)' WHERE id = 'Q028';
UPDATE questions SET question = 'Une analyse de risque documentée justifie le choix d''une zone (plutôt que local dédié) pour les catégories 1-3 non stériles/non CMR' WHERE id = 'Q029';
UPDATE questions SET question = 'L''analyse de risque pour le choix des équipements et l''environnement se base sur les niveaux de risque produit et de la nature des manipulations' WHERE id = 'Q032';
UPDATE questions SET question = 'Une analyse des risques professionnels est réalisée par l''employeur' WHERE id = 'Q036';
UPDATE questions SET question = 'L''analyse des risques professionnels permet l''élaboration du Document Unique des Risques Professionnels (DUERP), accessible par l''ensemble du personnel' WHERE id = 'Q037';
UPDATE questions SET question = 'Une analyse de risque est réalisée, le cas échéant si un même équipement est partagé entre préparations biologiques et chimiques non CMR' WHERE id = 'Q039';
UPDATE questions SET question = 'et les données restent disponibles pendant toute la durée de conservation exigée par les documents' WHERE id = 'Q043.03';
UPDATE questions SET question = 'La procédure de gestion documentaire précise le circuit de validation des documents qui sont' WHERE id = 'Q052';
UPDATE questions SET question = 'Les procédures validées sont diffusées spécifiquement aux personnels concernés (logiciel de gestion documentaire, diffusion papier, réunion de service avec compte rendu…)' WHERE id = 'Q054';
UPDATE questions SET question = 'Les procédures applicables dans la ZAC sont communiquées et connues des personnes étrangères à la PUI autorisées par le PRP / gérant PUI  à entrer dans les zones de préparation, de contrôle et de stockage' WHERE id = 'Q057';
UPDATE questions SET question = 'Il existe un système de déclaration/documentation relative aux écarts qualité des produits' WHERE id = 'Q058';
UPDATE questions SET question = 'Le système de déclaration/documentation relative aux écarts de qualité des produits est utilisé en pratique (ex : nombre de déclarations sur les 12 derniers mois)' WHERE id = 'Q059';
UPDATE questions SET question = 'Les documents sont présentés de façon ordonnée (codification prévue dans la procédure de gestion documentaire)' WHERE id = 'Q063';
UPDATE questions SET question = 'Un dossier de préparation est réalisé pour chaque type de préparation ; il reprend la validité technico-réglementaire, et comprend : la préparation et son procédé, les spécifications, contrôles et éléments d''assurance qualité (annexe II parties 1, 2, 3)' WHERE id = 'Q070';
UPDATE questions SET question = 'effectuer les enregistrements au moment où chaque action est réalisée.' WHERE id = 'Q074.06';
UPDATE questions SET question = 'La(les) procédure(s) relative(s) aux opérations de préparation permet(tent) de maîtriser et limiter les risques de contamination microbiologique à chaque stade de la préparation' WHERE id = 'Q075';
UPDATE questions SET question = 'Il existe une procédure de réalisation pour chaque forme pharmaceutique (parentérale, entérale, topique, etc.)' WHERE id = 'Q076';
UPDATE questions SET question = 'le contrôle à réception (MPUP, articles de conditionnement, préparations sous-traitées, etc.)' WHERE id = 'Q079.01';
UPDATE questions SET question = 'le contrôle libératoire des préparations' WHERE id = 'Q079.04';
UPDATE questions SET question = 'le contrôle de la stabilité des préparations et l''absence d''interactions contenant/contenu (le cas échéant)' WHERE id = 'Q079.05';
UPDATE questions SET question = 'La (les) procédure(s) de libération pharmaceutique des préparations terminées prévoit une mise en quarantaine physique et informatique le cas échéant, immédiatement après leur préparation' WHERE id = 'Q087';
UPDATE questions SET question = 'qu''il existe un registre de réception et de contrôle des MPUP et des articles de conditionnement' WHERE id = 'Q093.02';
UPDATE questions SET question = 'qu''il existe un enregistrement de chaque réception des MPUP et des articles de conditionnement' WHERE id = 'Q093.03';
UPDATE questions SET question = 'qu''il existe un enregistrement de chaque contrôle des MPUP et des articles de conditionnement' WHERE id = 'Q093.04';
UPDATE questions SET question = 'La procédure d''échantillonnage des préparations précise la quantité minimale conservée pour réaliser au moins l’analyse complète décrite dans la procédure de contrôle. En cas d''exception, celle-ci est justifiée' WHERE id = 'Q096';
UPDATE questions SET question = 'précise les précautions de manipulation pour éviter la contamination du produit ou la détérioration de sa qualité' WHERE id = 'Q097.05';
UPDATE questions SET question = 'en cas de ZAC de classe A et B, l''entreposage est limité au strict minimum' WHERE id = 'Q103.01';
UPDATE questions SET question = 'les récipients et produits susceptibles de libérer des particules (cartons…) ne sont pas introduits en ZAC, dans la mesure du possible.' WHERE id = 'Q103.03';
UPDATE questions SET question = 'La procédure d''accès aux locaux prend en compte la limitation des effectifs dans les zones et la maitrise des déplacements du personnel (flux)' WHERE id = 'Q109';
UPDATE questions SET question = 'La (les) procédure(s) relative(s) aux opérations de qualification des locaux et des équipements détaille(nt)' WHERE id = 'Q112';
UPDATE questions SET question = 'leurs fréquences qui sont adaptées à l''activité réelle du site' WHERE id = 'Q112.03';
UPDATE questions SET question = 'Il existe une procédure de gestion des matériels défectueux au sein de l''ES : évacuation de la zone ou interdiction d''utilisation' WHERE id = 'Q119';
UPDATE questions SET question = 'précise le planning d''entretien des locaux et le circuit, en prenant en compte les risques de contamination. Ce planning est partagé avec le PRP qui en valide aussi le circuit' WHERE id = 'Q132.01';
UPDATE questions SET question = 'précise les conduites à tenir lorsque les conditions de propreté n’ont pas pu être maintenues lors d''opérations d’entretien de matériels effectué au sein de la ZAC' WHERE id = 'Q132.04';
UPDATE questions SET question = 'La procédure relative à la gestion des déchets prévoit leur durée maximale de stockage et le volume maximal selon la réglementation en vigueur' WHERE id = 'Q136';
UPDATE questions SET question = 'Il existe une procédure de formation initiale (avec habilitation) et continue du personnel' WHERE id = 'Q137';
UPDATE questions SET question = 'La procédure de formation initiale (avec habilitation) et continue du personnel précise les modalités de réhabilitation après une absence prolongée' WHERE id = 'Q138';
UPDATE questions SET question = 'Il existe des instructions précises sur la technique de lavage des mains dans la procédure relative à l''hygiène du personnel' WHERE id = 'Q142';
UPDATE questions SET question = 'La procédure sur la conduite à tenir en cas d''incident en cours de préparation (bris ou déversement accidentel)  précise les éléments devant être transmis au médecin du travail' WHERE id = 'Q152';
UPDATE questions SET question = 'Il existe une procédure sur la conduite à tenir en cas d’incident ou de défaillance d’un dispositif, d’un équipement etc.' WHERE id = 'Q153';
UPDATE questions SET question = 'des éléments permettant d''étayer les évènements survenus' WHERE id = 'Q157.01';
UPDATE questions SET question = 'La procédure de rappel des préparations prévoit que, lorsqu’un défaut susceptible de porter atteinte à la santé est constaté, il existe une chaine hiérarchique identifiée de déclaration (Pharmacien gérant, direction générale)' WHERE id = 'Q161';
UPDATE questions SET question = 'La procédure de rappel des préparations prévoit que les préparations rappelées sont mises en quarantaine' WHERE id = 'Q163';
UPDATE questions SET question = 'Chaque matériel, équipement et zone critique (ex : postes à flux d’air unidirectionnel, isolateurs, balances, dispositifs de traitement d''eau et d’air) est accompagné d''un "cahier de suivi" (gmao ou papier)  qui mentionne' WHERE id = 'Q168';
UPDATE questions SET question = 'Pour chaque opération, est portée mention de la date, du nom des personnes ayant effectué ces opérations et du nom de la société en cas d’intervention extérieure.' WHERE id = 'Q169';
UPDATE questions SET question = 'Le(s) certificat(s) de qualification des matériels, équipements et zone critique est (sont) conservé(s) pendant toute la durée de vie de l''équipement' WHERE id = 'Q172';
UPDATE questions SET question = 'Le secret professionnel fait l''objet d''une prise en compte spécifique (charte de confidentialité, règlement intérieur…)' WHERE id = 'Q182';
UPDATE questions SET question = 'La description des contrôles à réaliser en cours et en fin de préparation figure dans le dossier de préparation' WHERE id = 'Q189';
UPDATE questions SET question = 'Le dossier de lot contient ou fait référence aux enregistrements disponibles pour la traçabilité des opérations de dispensation' WHERE id = 'Q196';
UPDATE questions SET question = 'Le dossier de lot contient ou fait référence aux enregistrements disponibles pour la traçabilité des opérations d''expédition le cas échéant' WHERE id = 'Q197';
UPDATE questions SET question = 'Sont inscrits dans le dossier de lot :' WHERE id = 'Q198';
UPDATE questions SET question = 'Éléments à renseigner au moment de la préparation' WHERE id = 'Q198.01';
UPDATE questions SET question = '● Quantité(s) ou volume(s) à prélever' WHERE id = 'Q198.01.09';
UPDATE questions SET question = '● Quantité(s) ou volume(s) à retirer (le cas échéant)' WHERE id = 'Q198.01.10';
UPDATE questions SET question = '● Éventuels commentaires, écarts aux procédures ou défauts observés par rapport à la réalisation de la préparation' WHERE id = 'Q198.01.13';
UPDATE questions SET question = '● Étiquette' WHERE id = 'Q198.01.14';
UPDATE questions SET question = 'Éléments à renseigner au moment du conditionnement' WHERE id = 'Q198.02';
UPDATE questions SET question = '● Étiquetage de la préparation' WHERE id = 'Q198.02.03';
UPDATE questions SET question = '● Éventuels incidents et anomalies / Éventuelles anomalies au cours du conditionnement' WHERE id = 'Q198.02.04';
UPDATE questions SET question = 'Éléments à renseigner au moment des contrôles et de la libération pharmaceutique' WHERE id = 'Q198.03';
UPDATE questions SET question = '● Résultats datés et signés des éventuels contrôles sur la préparation terminée (physico-chimiques, pharmacotechniques, microbiologiques, autres) en cas de contrôles' WHERE id = 'Q198.03.03';
UPDATE questions SET question = 'Documents d''échantillonnage' WHERE id = 'Q198.04.05';
UPDATE questions SET question = 'Le dossier de lot mentionne l''acceptation ou le refus de la préparation' WHERE id = 'Q200';
UPDATE questions SET question = 'Identification de la personne ayant réalisé la préparation et s''il y a lieu le nom et l''adresse de la pharmacie sous-traitante' WHERE id = 'Q201.10';
UPDATE questions SET question = 'Il existe une liste qualitative et quantitative qui comprend les matériels, les équipements et les installations de préparation ou de contrôle considérés comme critiques, établie par le PRP' WHERE id = 'Q204';
UPDATE questions SET question = 'Les personnels disposent des qualifications réglementaires à l''exercice de leurs fonctions et celles-ci sont enregistrées (diplôme,…)' WHERE id = 'Q221';
UPDATE questions SET question = 'L''effectif en personnels dédiés aux approvisionnement, stockage est suffisant' WHERE id = 'Q243';
UPDATE questions SET question = 'Le PRP s’assure du respect des règles des Bonnes Pratiques de Préparation (BPP) et de la qualité des préparations réalisées par la réalisation régulière d''une auto-inspection relative à l''application des BPP' WHERE id = 'Q245';
UPDATE questions SET question = 'La procédure de formation initiale (avec habilitation) et continue, comprend un plan de formation, une formation spécifique :' WHERE id = 'Q254';
UPDATE questions SET question = 'à la réalisation des préparations stériles' WHERE id = 'Q254.01';
UPDATE questions SET question = 'au réapprovisionnement des zones' WHERE id = 'Q254.06';
UPDATE questions SET question = 'aux  procédures relatives à l''habillage, à l''hygiène et à la protection du personnel' WHERE id = 'Q254.10';
UPDATE questions SET question = 'Dans le cadre de l''habilitation spécifique à la réalisation des préparations stériles (formation initiale et continue) à destination des PPH et personnels pharmaceutiques, celle-ci  comprend un test de remplissage aseptique (éléments de preuve)' WHERE id = 'Q255';
UPDATE questions SET question = 'La procédure de formation initiale (avec habilitation) et continue, dans le cadre des procédures relatives à l''habillage, à l''hygiène et à la protection du personnel, prévoit une formation complémentaire spécifique qui porte sur' WHERE id = 'Q260';
UPDATE questions SET question = 'La procédure de formation initiale (avec habilitation) et continue, comprend une formation spécifique, pour les :' WHERE id = 'Q261';
UPDATE questions SET question = 'Étudiants en 5e AHU' WHERE id = 'Q261.03';
UPDATE questions SET question = 'Les éléments de preuve de la formation initiale sont enregistrés pour l''ensemble du personnel (pharmaciens, internes en pharmacie, étudiants en 5e AHU, PP(H), personnel affecté au nettoyage, personnel affecté à la manutention, aux approvisionnement, stockage)' WHERE id = 'Q262';
UPDATE questions SET question = 'Les plannings, par poste, sont établis en fonction du tableau de suivi des compétences.' WHERE id = 'Q265';
UPDATE questions SET question = 'La procédure d''accès aux locaux implique une formation spécifique à l''entrée dans les locaux de préparation, au personnel susceptible d''intervenir dans les locaux (biomédical, technique et hygiène des locaux, prestataire externe…) (éléments de preuve)' WHERE id = 'Q266';
UPDATE questions SET question = 'l''absence de maquillage (incluant le vernis à ongles)' WHERE id = 'Q268.07';
UPDATE questions SET question = 'la tenue portée est adaptée au procédé et au niveau de propreté de la zone' WHERE id = 'Q270.01';
UPDATE questions SET question = 'Classe C : Les cheveux et, le cas échéant, la barbe et la moustache sont couverts. Un masque couvrant le visage pour éviter l’émission de gouttelettes est utilisé si nécessaire. Des gants sont à porter. Ils sont stériles si besoin. Un vêtement constitué d’une veste et d’un pantalon ou d’une combinaison, serré aux poignets et muni d’un col montant, ainsi que de chaussures ou couvre-chaussures adaptés sont à porter. Le tissu ne libère pratiquement pas de fibres ou de particules' WHERE id = 'Q271.02';
UPDATE questions SET question = 'que l''utilisation de plusieurs paires de gants est préconisée' WHERE id = 'Q272.01';
UPDATE questions SET question = 'que des lunettes de protection/écrans faciaux sont disponibles en cas de "danger oculaire" caractérisé' WHERE id = 'Q272.05';
UPDATE questions SET question = 'Dans le cadre de la procédure qui décrit les règles d''hygiène, il est précisé qu''il est interdit notamment de manger, de boire, de mâcher ou de fumer, ainsi que de garder de la nourriture, des boissons, du tabac ou des effets personnels' WHERE id = 'Q275';
UPDATE questions SET question = 'des contrôles du risque de contamination microbiologique (prélèvement, lavage des mains, état des locaux…) et des contrôles sont réalisés conformément à ces procédures (éléments de preuve)' WHERE id = 'Q276.01';
UPDATE questions SET question = 'La procédure relative à la protection du personnel prend en compte les risques liés à l''entretien, les maintenances curatives et préventives des locaux et des équipements' WHERE id = 'Q277';
UPDATE questions SET question = 'L''efficacité du nettoyage (contaminations croisées) est démontrée par des résultats de contrôle (prélèvements de surface)' WHERE id = 'Q285';
UPDATE questions SET question = 'La distinction local/zone est appliquée de façon cohérente dans tous les documents qualité (procédures, plans), évitant toute ambiguïté' WHERE id = 'Q296';
UPDATE questions SET question = 'les préparations stériles (hors anticancéreux et CMR)' WHERE id = 'Q297.02';
UPDATE questions SET question = 'Le choix de la zone d''atmosphère contrôlée est adapté aux opérations réalisées et justifié au regard du niveau de risque défini dans les généralités.' WHERE id = 'Q298';
UPDATE questions SET question = 'risque azote' WHERE id = 'Q302.03';
UPDATE questions SET question = 'mise en œuvre d''opérations de nettoyage et de désinfection appropriées' WHERE id = 'Q312.03';
UPDATE questions SET question = 'Le rapport d''analyse annuel est conforme aux BPP, à savoir que le nombre maximal autorisé de particules par m3 (de taille égale ou supérieure à) des différentes classes est :
   * Au repos :
      Classe A : 3520 (0,5 μm) et 20 (5 μm)
      Classe B : 3520 (0,5 μm) et 29 (5 μm)
      Classe C : 352 000 (0,5 μm) et 2900 (5 μm)
      Classe D : 3 520 000 (0,5 μm) et 29 000 (5 μm)
   * En activité :
      Classe A : 3520 (0,5 μm) et 20 (5 μm)
      Classe B : 352 000 (0,5 μm) et 2900 (5 μm)
      Classe C : 3 520 000 (0,5 μm) et 29 000 (5 μm)
      Classe D : Non défini' WHERE id = 'Q315';
UPDATE questions SET question = 'La classification des ZAC est distincte de la surveillance microbiologique, et les deux états « au repos » et « en activité » sont caractérisés séparément. Le rapport d''analyse annuel est conforme aux BPP, à savoir que le nombre maximal autorisé de particules par m3 (de taille égale ou supérieure à) des différentes classes est :
   * Au repos :
      Classe A : 3520 (0,5 μm) et 20 (5 μm)
      Classe B : 3520 (0,5 μm) et 29 (5 μm)
      Classe C : 352 000 (0,5 μm) et 2900 (5 μm)
      Classe D : 3 520 000 (0,5 μm) et 29 000 (5 μm)
   * En activité :
      Classe A : 3520 (0,5 μm) et 20 (5 μm)
      Classe B : 352 000 (0,5 μm) et 2900 (5 μm)
      Classe C : 3 520 000 (0,5 μm) et 29 000 (5 μm)
      Classe D : Non défini' WHERE id = 'Q317';
UPDATE questions SET question = 'L''entrée et la sortie de la ZAC se font par des sas' WHERE id = 'Q324';
UPDATE questions SET question = 'À chaque début de session de production, le différentiel de pression est vérifié' WHERE id = 'Q338';
UPDATE questions SET question = 'Le taux de brassage horaire d’air est connu et adapté à la taille de chaque local ainsi qu’aux équipements et effectifs qui y sont présents' WHERE id = 'Q341';
UPDATE questions SET question = 'Le taux de renouvellement d''air est adapté et justifié au regard de l''utilisation de chaque ZAC selon  la norme EN 14644' WHERE id = 'Q343';
UPDATE questions SET question = 'En cas de préparation en zone en dépression, la conception des locaux et des équipements permet de s''assurer de la qualité microbiologique de la préparation réalisée.' WHERE id = 'Q345';
UPDATE questions SET question = 'La préparation des formes orales classées CMR est réalisée dans des locaux et équipements adaptés et dédiés.' WHERE id = 'Q347';
UPDATE questions SET question = 'À défaut, un même équipement est utilisé pour la réalisation des préparations de substances biologiques et chimiques non CMR sous réserve d''une analyse de risque' WHERE id = 'Q352';
UPDATE questions SET question = 'stockage des préparations en attente de libération' WHERE id = 'Q359.04';
UPDATE questions SET question = 'Le stock de MPUP et articles de conditionnement est le plus limité possible dans les locaux de préparation' WHERE id = 'Q360';
UPDATE questions SET question = 'Les locaux intègrent un local/zone d''élimination des déchets' WHERE id = 'Q367';
UPDATE questions SET question = 'Les zones de stockage médicaments et décartonnage ont un gradient de pression négatif.' WHERE id = 'Q371';
UPDATE questions SET question = 'En cas de préparations portant un risque pour le personnel ou l''environnement, l''air extrait est rejeté hors du bâtiment' WHERE id = 'Q380';
UPDATE questions SET question = 'En cas de préparations portant un risque pour le personnel ou l''environnement, l''alimentation en air filtré est maintenue tout le temps de la préparation' WHERE id = 'Q381';
UPDATE questions SET question = 'En cas de manipulation à risque de dispersion d''OGM, celles-ci ont lieu dans un PSM type II ou un isolateur' WHERE id = 'Q383';
UPDATE questions SET question = 'La décongélation de médicaments OGM de classe de confinement > C1 ou C1, si les contenants nécessitent d’être ouverts, est réalisée dans un PSM type II ou un isolateur' WHERE id = 'Q384';
UPDATE questions SET question = 'Le gradient de pression (positif ou négatif) est qualifié selon les recommandations du fabricant' WHERE id = 'Q389';
UPDATE questions SET question = 'Le procédé de stérilisation de contact des surfaces à l''intérieur de l''isolateur est validé avec des charges représentatives de l''activité à l''aide des indicateurs biologiques mentionnés au chapitre 5.1.2 de la Pharmacopée Européenne' WHERE id = 'Q394';
UPDATE questions SET question = 'Les préparations réalisées selon un procédé en système ouvert et utilisant une ou plusieurs MPUP pulvérulentes sont préférentiellement réalisées dans un isolateur en pression négative par rapport à l''environnement' WHERE id = 'Q396';
UPDATE questions SET question = 'Le versionning des logiciels métier est testé et il existe un cahier de test.' WHERE id = 'Q400';
UPDATE questions SET question = 'La maintenance préventive régulière, planifiée et procédurée, validée par le PRP, est réalisée sans affecter le fonctionnement des ZAC' WHERE id = 'Q413';
UPDATE questions SET question = 'Le câblage des appareils dans la ZAC est compatible avec le bionettoyage' WHERE id = 'Q419';
UPDATE questions SET question = 'Il existe des enregistrements relatifs aux opérations de nettoyage et désinfection (des locaux ou des zones, équipements, appareils)' WHERE id = 'Q421';
UPDATE questions SET question = 'Pour chaque opération est portée mention de la date, de l''opérateur et/ou  du nom de la société en cas d’intervention extérieure.' WHERE id = 'Q422';
UPDATE questions SET question = 'La solution désinfectante ainsi que son système de dispersion ou diffusion est validée par le PRP (efficacité, spectre d''action, absence de résidu).' WHERE id = 'Q423';
UPDATE questions SET question = 'L''analyse régulière des résultats des prélèvements microbiologiques des ZAC est effective' WHERE id = 'Q425';
UPDATE questions SET question = 'Les méthodes d’échantillonnage utilisées en activité n’interfèrent pas avec la protection des zones.' WHERE id = 'Q428';
UPDATE questions SET question = 'stockage préparation en attente de contrôle' WHERE id = 'Q445.02';
UPDATE questions SET question = 'stockage préparation en attente de libération' WHERE id = 'Q445.03';
UPDATE questions SET question = 'Les procédés de préparation sont validés et peuvent faire appel à des contrôles d''environnement adaptés' WHERE id = 'Q447';
UPDATE questions SET question = 'Lorsqu''un matériel non stérile est utilisé pour une préparation stérile, un procédé de stérilisation adapté est appliqué' WHERE id = 'Q458';
UPDATE questions SET question = 'Dénomination (DCI ou nom commercial)' WHERE id = 'Q463.01';
UPDATE questions SET question = 'L''identification des contenants est apposée dès la fin du remplissage/fermeture des récipients (ou selon une méthode garantissant une sécurité équivalente), afin d''éviter toute confusion (par exemple : préparation en cours, préparation en attente de contrôle).' WHERE id = 'Q471';
UPDATE questions SET question = 'Les opérations de conditionnement sont respectées et enregistrées dans le dossier de préparation' WHERE id = 'Q473';
UPDATE questions SET question = 'Le transport est sécurisé (contenants étanches, maintien de la t°…) et conforme à la réglementation en vigueur' WHERE id = 'Q479';
UPDATE questions SET question = 'La réattribution des préparations fait l''objet d''un réétiquetage' WHERE id = 'Q487';
UPDATE questions SET question = 'Le réétiquetage d''une préparation réattribuée fait l''objet d''un contrôle et est enregistré dans le dossier de lot' WHERE id = 'Q488';
UPDATE questions SET question = 'l''échantillonnage (MPUP, articles de conditionnement, poche mère sur certains robots, préparations terminées)' WHERE id = 'Q493.01';
UPDATE questions SET question = 'réception des MPUP, articles de conditionnement, préparations sous-traitées,…' WHERE id = 'Q494.01';
UPDATE questions SET question = 'contrôles libératoires' WHERE id = 'Q494.04';
UPDATE questions SET question = 'contrôle de stabilité des préparations et d''absence d''interactions contenant/contenu (le cas échéant)' WHERE id = 'Q494.05';
UPDATE questions SET question = 'En cas de non-conformité par rapport aux spécifications requises des réclamations et analyses sont effectuées pour prendre des mesures correctives adaptées (le cas échéant)' WHERE id = 'Q499';
UPDATE questions SET question = 'La pharmacie dispose d''accès à la dernière version de : Pharmacopée européenne (référentiel officiel) et/ou Pharmacopée Française, dont le Formulaire National (référentiel officiel) et/ou Pharmacopées des autres états membres de l''UE et/ou Pharmacopées d''états hors UE et ou en l''absence de référentiel disponible : méthodes internes et/ou méthodes fournisseurs et/ou méthodes décrites dans la littérature' WHERE id = 'Q500';
UPDATE questions SET question = 'Les contrôles analytiques se font à l''aide d''étalons de référence' WHERE id = 'Q509';
UPDATE questions SET question = 'Les enregistrements concernant l''étalonnage, la qualification et la maintenance des équipements de contrôle sont accessibles' WHERE id = 'Q518';
UPDATE questions SET question = 'La décision d''acceptation des MPUP et des articles de conditionnement est faite par un pharmacien et enregistrée sur le registre manuscrit ou informatisé d''entrée des MPUP' WHERE id = 'Q522';
UPDATE questions SET question = 'L''absence d''obligation d''échantillothèque pour les MPUP de 2ème catégorie est correctement appliquée.' WHERE id = 'Q536';
UPDATE questions SET question = 'Le cas échéant, des contrôles physico-chimiques, des études toxicologiques ou microbiennes sont mis en œuvre en l''absence de référentiel disponible' WHERE id = 'Q540';
UPDATE questions SET question = 'Le contrôle des préparations pharmaceutiques terminées comprend le' WHERE id = 'Q548';
UPDATE questions SET question = 'classification de la préparation au regard de l’Annexe III ou d’une analyse de risque formalisée' WHERE id = 'Q551.04';
UPDATE questions SET question = 'type d''opération pharmaceutique nécessaire à la réalisation de la préparation' WHERE id = 'Q551.05';
UPDATE questions SET question = 'nombre d''unités préparées' WHERE id = 'Q551.06';
UPDATE questions SET question = 'type d''opération de contrôle réalisé (destructif ou non)' WHERE id = 'Q551.07';
UPDATE questions SET question = 'Les récipients contenant les échantillons sont clairement identifiés et mentionnent de façon apparente, au minimum :' WHERE id = 'Q558';
UPDATE questions SET question = 'date de l''échantillonnage' WHERE id = 'Q558.02';
UPDATE questions SET question = 'les double-contrôles réalisés pendant la préparation ou les résultats des contrôles (pesée, dosage, contrôle vidéo)' WHERE id = 'Q561.04';
UPDATE questions SET question = 'Le choix des contrôles est fonction des caractéristiques de la préparation et de son utilisation' WHERE id = 'Q563';
UPDATE questions SET question = 'Pour chaque procédure d''échantillonnage il est précisé explicitement le type d''échantillonnage retenu (simple ou multiple) et le nombre d''unités prélevées.' WHERE id = 'Q567';
UPDATE questions SET question = 'Un contrôle de stabilité est mis en œuvre pour toute préparation réalisée à l''avance et destinée à une conservation prolongée, en cohérence avec sa forme pharmaceutique.' WHERE id = 'Q570';
UPDATE questions SET question = 'La date de péremption de la préparation terminée est déterminée indépendamment de celle de la spécialité utilisée comme MPUP.' WHERE id = 'Q573';
UPDATE questions SET question = 'Il existe un contrat écrit entre le donneur d''ordre et le sous-traitant (que l''on sous-traite ou que l''on soit le sous-traitant) spécifiant' WHERE id = 'Q581';
UPDATE questions SET question = 'Il existe un contrat unique global (dans la mesure du possible) ou de contrats réunis consultables ensemble' WHERE id = 'Q582';
UPDATE questions SET question = 'Pour chaque sous-traitance, le contrat est écrit et définit précisément les responsabilités des processus mis en place (comme l''étiquetage, les contrôles des MPUP, DM, préparations terminées, les conditions de conservation et de transport, la gestion du rappel des lots et des non-conformités, la durée dudit contrat et les modalités de reconduction)' WHERE id = 'Q588';
UPDATE questions SET question = 'Le donneur d''ordre vérifie que le sous-traitant dispose' WHERE id = 'Q593';
UPDATE questions SET question = '* de l''autorisation de réalisation des préparations hospitalières délivrée par l''ARS' WHERE id = 'Q593.02';
UPDATE questions SET question = '* de l''autorisation de reconstitution de spécialités pharmaceutiques, y compris celles concernant les médicaments de thérapie innovante délivrée par l''ARS' WHERE id = 'Q593.03';
UPDATE questions SET question = '* Autorisation de réalisation des préparations hospitalières délivrée par l''ARS' WHERE id = 'Q599.04';
UPDATE questions SET question = 'Le sous-traitant réalise les activités comme stipulé par le contrat' WHERE id = 'Q600';
UPDATE questions SET question = 'Le refus par le sous-traitant de la réalisation d''une préparation doit être motivé (le cas échéant)' WHERE id = 'Q606';
UPDATE questions SET question = 'Le contrat de sous-traitance précise les responsabilités du donneur d''ordre et du sous-traitant en matière de contrôle' WHERE id = 'Q613';
UPDATE questions SET question = '* les résultats qualitatifs avec leurs spécifications' WHERE id = 'Q615.01';
UPDATE questions SET question = '* les résultats quantitatifs avec leurs spécifications' WHERE id = 'Q615.02';
UPDATE questions SET question = '* Une mention de conformité ou de non-conformité de la préparation' WHERE id = 'Q615.05';
UPDATE questions SET question = 'En cas de sous-traitance des contrôles, le pharmacien responsable des  préparations tient compte des résultats fournis par le sous-traitant pour la réalisation des préparations' WHERE id = 'Q616';
UPDATE questions SET question = 'Toute activité externalisée, couverte par le guide des BPP, est définie de manière appropriée, convenue et contrôlée afin d’éviter tout malentendu susceptible de conduire à un travail ou une préparation de qualité insuffisante et fait l''objet d''un contrat écrit entre le donneur d’ordre et le sous-traitant en vue de fixer clairement les obligations de chaque partie.' WHERE id = 'Q622';
UPDATE questions SET question = 'Il existe un système de traitement des réclamations (CREX, autre)' WHERE id = 'Q626';
UPDATE questions SET question = 'Ce traitement analyse causes et défauts (CREX, autre)' WHERE id = 'Q627';
UPDATE questions SET question = 'Ce traitement conduit à la mise en place de mesures correctives le cas échéant' WHERE id = 'Q628';
UPDATE questions SET question = 'À l''issue du CREX ou autre, un plan d''action est mis en place par le PRP' WHERE id = 'Q630';
UPDATE questions SET question = 'Les actions issues du CREX ou autre présentent des délais de mise en œuvre' WHERE id = 'Q631';
UPDATE questions SET question = 'Un bilan de rappel établit la balance entre le nombre d''unités rappelées et le nombre d''unités retournées' WHERE id = 'Q634';
UPDATE questions SET question = 'l''identité de la personne ayant réalisé l''auto-inspection' WHERE id = 'Q639.01';
UPDATE questions SET question = 'Des audits des pratiques sont réalisés régulièrement et enregistrés. Ils peuvent concerner' WHERE id = 'Q641';
UPDATE questions SET question = 'la vérification de l''adéquation de l''habillage (charlotte, gants, cache-barbe…) correspond à la classe de ZAC concernée, pour chaque opérateur présent' WHERE id = 'Q641.03';
UPDATE questions SET question = 'la vérification de l''absence de montres-bracelets, maquillage (incluant le vernis à ongles), bijoux et autres objets personnels tels que les  téléphones portables' WHERE id = 'Q641.04';
UPDATE questions SET question = 'Le choix du procédé de préparation stérile (stérilisation terminale, filtration stérilisante ou préparation aseptique) est identifié et documenté le cas échéant' WHERE id = 'Q643';
UPDATE questions SET question = 'Les MPUP utilisées sont principalement des spécialités pharmaceutiques stériles autorisées en France' WHERE id = 'Q663';
UPDATE questions SET question = 'les reliquats de MPUP sont stériles et reconstitués de manière stérile' WHERE id = 'Q665.01';
UPDATE questions SET question = 'si la stabilité dans le temps est documentée (durée précisée)' WHERE id = 'Q665.02';
UPDATE questions SET question = 'Les tests de remplissage aseptique sont tracés' WHERE id = 'Q678';
UPDATE questions SET question = 'Un plan spécifique d''échantillonnage microbiologique peut être mis en place en cas de réalisation de préparations selon un procédé identique' WHERE id = 'Q683';
UPDATE questions SET question = 'Les fiches de données de sécurité des MPUP sont mises à disposition du personnel' WHERE id = 'Q688';
UPDATE questions SET question = 'En l''absence de mention de danger disponible, le RCP de la spécialité est étudié pour recueillir les informations utiles (effets pharmacologiques et indésirables, dose usuelle, toxicité aigüe, toxicité chronique, mutagénicité)' WHERE id = 'Q690';
UPDATE questions SET question = 'Un niveau d''exposition au danger est défini en collaboration avec la médecine du travail pour l''ensemble des personnels' WHERE id = 'Q691';
UPDATE questions SET question = 'Le niveau d''exposition est réévalué annuellement avec la médecine du travail' WHERE id = 'Q693';
UPDATE questions SET question = 'Les mesures de protection sont réévaluées en fonction de l''évolution du niveau d''exposition' WHERE id = 'Q694';
UPDATE questions SET question = 'La circulaire DHOS/E4/DGS/SD.7B/DPPR n° 2006-58 du 13 février 2006 est appliquée pour l’élimination des déchets toxiques' WHERE id = 'Q713';
UPDATE questions SET question = 'Les déchets CMR sont identifiés selon la circulaire DHOS/E4/DGS/SD.7B/DPPR n° 2006-58 du 13 février 2006 (DASRI dilués/DTQD concentrés)' WHERE id = 'Q714';
UPDATE questions SET question = 'L''étiquetage des préparations rendues nécessaires par les RIPH répond aux textes en vigueur' WHERE id = 'Q734';
UPDATE questions SET question = 'En cas d''opérations limitées au conditionnement/étiquetage, sous surveillance du pharmacien responsable, le promoteur veille à ce que les opérations soient convenablement documentées et réalisées conformément aux bonnes pratiques en vigueur.' WHERE id = 'Q738';
UPDATE questions SET question = 'L''investigateur ainsi que toute personne dûment mandatée par le promoteur sont informés et ont connaissance de leurs obligations respectives dans le cadre de cette procédure de rappel' WHERE id = 'Q742';
