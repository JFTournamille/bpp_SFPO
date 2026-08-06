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
app/db.py           Connexion PostgreSQL (pool psycopg2)
static/index.html    Page web (Auto-évaluation / Analyse & Expertise / Statistiques)
static/assets/       Logo SFPO
schema.sql           Schéma PostgreSQL + données de référence (chapitres/questions)
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

## Modèle de données

- `chapters` / `subchapters` / `questions` — référentiel BPP (généré depuis le
  fichier Excel fourni, 45 questions réparties sur 2 chapitres).
- `evaluations` — une campagne d'auto-évaluation (une seule aujourd'hui, id=1,
  créée automatiquement).
- `responses` — une ligne par question répondue (réponse, commentaire, preuve,
  criticité, risque maîtrisé, action corrective).

## Sécurité — à prévoir avant un usage en production élargi

Cette première version n'a **aucune authentification** : quiconque accède à
l'URL peut répondre au questionnaire. Pour un déploiement au-delà d'un usage
interne restreint, il faudra ajouter une couche d'authentification (ex: un
mot de passe partagé via un reverse-proxy, ou une vraie authentification
utilisateur) avant d'exposer l'app publiquement.
