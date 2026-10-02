# Auto-évaluation BPP — SFPO

Application web d'auto-évaluation aux Bonnes Pratiques de Préparation (BPP),
avec un backend **FastAPI** et une base **PostgreSQL**, prévue pour être
déployée sur une instance **CapRover**.

## Architecture

```
Navigateur  ──HTTP──▶  FastAPI (Docker, sur CapRover)  ──▶  PostgreSQL (sur CapRover)
             (static/index.html + /api/*)                   (app one-click "postgres")
```

Un seul conteneur CapRover sert à la fois :
- la page web statique (`static/index.html`) ;
- l'API REST (`/api/*`) ;
- les fichiers de preuve téléversés (`/uploads/*`, stockés dans un répertoire
  persistant CapRover).

## Arborescence

```
app/main.py         API FastAPI (questionnaire, réponses, upload de preuves)
app/auth.py         Authentification provisoire (login/mot de passe, sessions) — à remplacer par le SSO SFPO
app/admin.py        Espace expert (tableau de bord, centres, comptes)
app/mailer.py       Envoi des identifiants par e-mail (SMTP, optionnel)
app/db.py           Connexion PostgreSQL (pool psycopg2)
static/index.html    Page web (Auto-évaluation / Analyse & Expertise / Statistiques)
static/assets/       Logo SFPO
schema.sql           Schéma PostgreSQL + données de référence (chapitres/questions)
migrations/          Scripts SQL à appliquer sur une base déjà initialisée
Dockerfile           Image de l'application (utilisée par CapRover)
captain-definition   Fichier requis par CapRover pour builder le Dockerfile
requirements.txt     Dépendances Python
```

## 1. Créer la base PostgreSQL sur CapRover

Dans le dashboard CapRover : **Apps → One-Click Apps/Databases → PostgreSQL**.
Donnez-lui un nom d'app, par exemple `bpp-db`, choisissez un mot de passe.
CapRover crée un service interne joignable par les autres apps à l'adresse :

```
srv-captain--bpp-db
```

## 2. Charger le schéma (`schema.sql`)

Le service Postgres n'est pas exposé sur internet par défaut (normal, pour la
sécurité). Deux façons de lancer `schema.sql` dessus :

**Option A — via SSH sur le serveur CapRover (recommandé)**
```bash
# Sur le serveur, trouver le conteneur postgres
docker ps --filter name=srv-captain--bpp-db

# Copier le schéma dans le conteneur puis l'exécuter
docker cp schema.sql <container_id>:/schema.sql
docker exec -it <container_id> psql -U postgres -d postgres -f /schema.sql
```
(adaptez `-U` et `-d` aux valeurs choisies lors de la création de l'app one-click)

**Option B — depuis votre machine, en exposant temporairement le port**
Dans CapRover : app `bpp-db` → **HTTP Settings → Add a Port Mapping** (ex: hôte
`5432` → conteneur `5432`), puis :
```bash
psql "postgresql://postgres:<mot_de_passe>@<ip_serveur>:5432/postgres" -f schema.sql
```
Une fois terminé, **supprimez le port mapping** pour ne pas laisser la base
exposée publiquement.

## 3. Créer l'app backend sur CapRover

**Apps → Create New App**, nom par exemple `bpp-autoeval`.

Dans l'app créée :

- **App Configs → Environmental Variables**
  - `DATABASE_URL` = `postgresql://postgres:<mot_de_passe>@srv-captain--bpp-db:5432/postgres`
  - `ADMIN_LOGIN` = identifiant du compte expert initial (défaut : `expert`)
  - `ADMIN_PASSWORD` = son mot de passe initial. Utilisé **uniquement** si aucun compte n'existe
    encore ; le changement est imposé à la première connexion. S'il est absent, un mot de passe
    provisoire aléatoire est généré et affiché dans les logs de l'app.
  - **Envoi des identifiants par e-mail (optionnel)** — sans `SMTP_HOST`, l'expert copie
    le message et l'envoie lui-même :
    - `SMTP_HOST` (ex. `smtp.office365.com`, `ssl0.ovh.net`, `smtp-relay.brevo.com`)
    - `SMTP_PORT` (défaut `587`, ou `465` en SSL)
    - `SMTP_SECURITY` = `starttls` (défaut) | `ssl` | `none`
    - `SMTP_USER` / `SMTP_PASSWORD` : compte d'envoi
    - `SMTP_FROM` : adresse d'expédition (défaut : `SMTP_USER`)
    - `APP_URL` : adresse publique de l'outil citée dans les e-mails (défaut : déduite
      de la requête, ex. `https://bpp.sfpo.com`)
  - (`UPLOAD_DIR` est déjà fixé à `/app/uploads` dans le Dockerfile, inutile de le redéfinir sauf besoin spécifique)

- **App Configs → Persistent Directories** (important — sans ça, les preuves
  téléversées sont perdues à chaque redéploiement)
  - Chemin dans le conteneur : `/app/uploads`
  - Label : `uploads`

- **HTTP Settings**
  - Container HTTP Port : `80` (déjà la valeur par défaut attendue)
  - Activez HTTPS / Force HTTPS une fois un nom de domaine attaché.

## 4. Déployer le code

**Méthode simple — CapRover CLI** (depuis votre machine, à la racine du repo) :
```bash
npm install -g caprover      # si pas déjà installé
caprover login               # renseigne l'URL de votre dashboard + mot de passe
caprover deploy               # choisit l'app "bpp-autoeval", package et build l'image
```

**Alternative — déploiement depuis GitHub** : dans l'app CapRover, onglet
**Deployment → Method 3: Deploy from Github/Bitbucket/Gitlab**, renseignez
l'URL du dépôt (voir étape 5), la branche (`main`), et éventuellement un
webhook pour un déploiement automatique à chaque `git push`.

## 5. Pousser le code sur GitHub

```bash
cd /Users/MacBook_Pro_JFT/Desktop/BPP
git init
git add .
git commit -m "Initial commit — auto-évaluation BPP (FastAPI + Postgres)"
```

Créez ensuite un dépôt vide sur [github.com/new](https://github.com/new)
(ne cochez ni README ni .gitignore, le repo local en a déjà), puis :
```bash
git remote add origin git@github.com:<votre-compte>/<nom-du-repo>.git
git branch -M main
git push -u origin main
```

## Développement local (optionnel)

```bash
# Postgres local (ex: via Homebrew) puis :
psql -d votre_base -f schema.sql

pip install -r requirements.txt
export DATABASE_URL="postgresql:///votre_base"
uvicorn app.main:app --reload --port 8000
# → http://localhost:8000
```

## Mise à jour d'une base existante

`schema.sql` ne sert qu'à l'initialisation. Les évolutions de la base sont des
scripts `migrations/*.sql` **appliqués automatiquement au démarrage de
l'application** (ordre alphabétique, une seule fois chacun — suivi dans la table
`schema_migrations`). Un simple redéploiement suffit, aucun accès au serveur
n'est nécessaire. En cas d'échec, l'erreur apparaît dans les logs de l'app
CapRover et la migration est retentée au démarrage suivant.

Pour ajouter une évolution : créer `migrations/002_xxx.sql` (idéalement
idempotent), puis redéployer.

## Comptes, centres et questionnaires

En attendant le branchement du SSO SFPO, l'accès se fait par identifiant / mot
de passe :

- **Expert** : administre l'outil. Au premier déploiement, un compte expert
  initial est créé (`ADMIN_LOGIN` / `ADMIN_PASSWORD`). Depuis l'onglet
  *Tableau de bord*, un expert :
  - suit tous les questionnaires (centre, statut en cours / terminé,
    progression, non-conformités restant à qualifier, dernière activité) ;
  - crée les comptes **membres** (et d'autres experts) et les rattache à un
    centre. Un mot de passe provisoire est généré ; le message d'identifiants
    (type d'accès, adresse, identifiant, mot de passe provisoire) est envoyé par
    e-mail si le SMTP est configuré, et affiché une seule fois pour copie dans
    tous les cas. La personne choisit son mot de passe à la première connexion. Un expert peut aussi régénérer un mot de
    passe ou désactiver un compte ;
  - gère le référentiel des **centres** (≈1 300 établissements importés depuis
    l'export SFPO, identifiants conservés) : recherche, ajout, modification ;
  - ouvre n'importe quel questionnaire, en **vue expert** (qualification des
    écarts) ou en **vue membre** (simulation de ce que voit le centre), avec
    bascule dans le bandeau du questionnaire ;
  - crée une nouvelle campagne pour un centre, rouvre un questionnaire terminé.
- **Membre** : voit uniquement le questionnaire de son centre (la dernière
  campagne, créée automatiquement à sa première connexion). Il le marque
  comme terminé une fois rempli, après quoi il ne peut plus le modifier.
  Criticité, risque maîtrisé et action corrective restent réservés aux experts
  (contrôlé côté serveur).

**Plusieurs membres sur un même questionnaire** : chaque réponse porte un
numéro de version et le nom de la dernière personne qui l'a modifiée (affiché
sous la question). Si deux personnes modifient la même question, la seconde
n'écrase pas la première : sa modification est refusée, la version enregistrée
est rechargée et un message l'invite à vérifier puis refaire sa saisie. Les
réponses saisies par les collègues apparaissent automatiquement (actualisation
toutes les 45 s et au retour sur l'onglet).

Le questionnaire qui existait avant cette évolution apparaît dans le tableau de
bord comme « Sans centre (historique) » : bouton *Rattacher* pour l'affecter à
un centre.

## Données personnelles (RGPD)

À la première connexion (après le choix du mot de passe), chaque utilisateur
doit lire la mention d'information RGPD propre à l'outil et cocher la case
d'acquittement, qui l'engage aussi à ne saisir aucune donnée patient. Tant que
ce n'est pas fait, l'API refuse tout accès au questionnaire (contrôle côté
serveur, pas seulement à l'écran).

- Le texte et sa version sont définis dans `app/rgpd.py` (source unique, servi
  par `/api/rgpd`). Il complète la politique RGPD générale de la SFPO, à
  laquelle il renvoie.
- L'acquittement est stocké sur le compte : `users.rgpd_version` et
  `users.rgpd_acknowledged_at`, visibles dans *Tableau de bord → Comptes*
  (colonne RGPD).
- **Modifier la mention** : éditer `RGPD_HTML` et changer `RGPD_VERSION` dans
  `app/rgpd.py`. Chaque utilisateur devra alors acquitter la nouvelle version à
  sa connexion suivante. Le dernier acquittement est porté par le compte ; la
  table `rgpd_acknowledgements` garde l'historique de toutes les versions
  acquittées (bouton *Historique RGPD* sur chaque compte).
- **Purge (durées de conservation)** : *Tableau de bord → Comptes → Purge RGPD*
  liste les comptes sans connexion depuis plus de 3 ans et les auto-évaluations
  clôturées depuis plus de 5 ans (durées définies dans `app/rgpd.py`, reprises
  dans la mention). La suppression, définitive (réponses et fichiers de preuve
  compris), n'a lieu qu'après confirmation par un expert ; le compte de l'expert
  qui lance la purge n'est jamais supprimé. À lancer périodiquement (ex. une
  fois par an).
- La mention reste consultable à tout moment via le lien *Données
  personnelles* en pied de page.

## Parcours de l'audit

L'onglet *Auto-évaluation* propose deux modes (bascule en haut de page), avec
le menu de navigation à gauche :
- **Par thématique** : sections de 1er niveau du référentiel Excel ;
- **Par chapitre BPP** : questions regroupées selon le chapitre de leur
  référence BPP principale (1 à 9, LD1, LD2, LD3), triées par article. Les
  sous-questions suivent leur question chapeau.

Les réponses sont communes aux deux modes. Le mode et la rubrique ouverte sont
mémorisés dans le navigateur.

## Modèle de données

- `sections` — référentiel BPP, arborescence à profondeur variable (chapitre >
  section > sous-section > ...), générée depuis le fichier Excel fourni
  (1263 questions réparties sur 12 chapitres).
- `questions` — une question par ligne du référentiel, avec :
  - `section_id` : la section à laquelle elle est directement attachée ;
  - `parent_question_id` : la question "chapeau" dont elle est une sous-question
    (imbrication déduite du code Excel, ex. `Q198` → `Q198.02` → `Q198.02.01`) ;
  - `depends_on_question_id` / `depends_on_value` : la question n'est affichée
    que si la question référencée a reçu la réponse indiquée (ex. n'afficher
    `Q022` que si `Q021` = "oui") ;
  - `ref` / `ref_text` : première réf. BPP citée et texte officiel affiché au
    survol ; `refs` : toutes les réf. BPP associées (une bulle par réf.).
- `centres` — établissements (référentiel SFPO).
- `users` — comptes expert / membre (mot de passe haché PBKDF2), centre de
  rattachement ; `sessions` — sessions de connexion (cookie HttpOnly, 7 jours).
- `evaluations` — une campagne d'auto-évaluation par centre (plusieurs
  possibles dans le temps), avec son statut (`en_cours` / `termine`).
- `responses` — une ligne par question répondue (réponse, commentaire, preuve,
  criticité, risque maîtrisé, action corrective), avec `version` et
  `updated_by` (dernier auteur). Une question conditionnelle est affichée par
  défaut et n'est masquée que si la question dont elle dépend reçoit une réponse
  contraire (« non » ou « NA » pour une condition « oui » ; « partiel » la laisse
  affichée). Les questions masquées ne comptent pas dans la progression ni les
  statistiques.
- `questions.is_part` — lignes « PART 1 » du fichier Excel : partie initiale
  commune à plusieurs questions (ex. Q042 « Le système documentaire mis en place
  … est », complétée par Q042.01, Q042.02…). Affichées comme intitulé, sans
  réponse, hors progression, analyse, exports et tableau de bord expert
  (`migrations/007_questions_part.sql`).

## Sécurité

- Toutes les routes de l'API et les preuves téléversées exigent une session.
  Un membre n'accède qu'aux questionnaires de son centre.
- Mots de passe hachés (PBKDF2-SHA256), 10 caractères minimum, changement
  imposé pour tout mot de passe provisoire ; blocage 15 min après 5 échecs sur
  un même identifiant.
- Activez **HTTPS / Force HTTPS** dans CapRover : le cookie de session est alors
  marqué `Secure`.
- Authentification provisoire : le jour du SSO SFPO, seul `app/auth.py` (et
  l'écran de connexion) est à remplacer ; les rôles et rattachements aux
  centres restent gérés dans l'application.
