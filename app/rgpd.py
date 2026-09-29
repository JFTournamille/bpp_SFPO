"""Mention d'information RGPD (art. 13) propre à l'outil d'auto-évaluation BPP.

Source unique du texte : l'interface l'affiche via /api/rgpd. Toute modification de fond
doit s'accompagner d'un changement de RGPD_VERSION, ce qui impose un nouvel acquittement
à chaque utilisateur lors de sa connexion suivante.
"""

RGPD_VERSION = "2026-09-29"

SFPO_POLICY_URL = "https://sfpo.com/politique-rgpd/"

# Coordonnées reprises de la politique RGPD de la SFPO (mise à jour du 10/04/2024).
SFPO_ADDRESS = "37, rue des Mathurins, 75008 Paris"
DPO_EMAIL = "dpo@sfpo.com"

# Durées de conservation (affichées dans la mention et appliquées par la purge de l'espace expert).
ACCOUNT_RETENTION_YEARS = 3      # compte : à compter de la dernière connexion
EVALUATION_RETENTION_YEARS = 5   # auto-évaluation : à compter de sa clôture

RGPD_TITLE = "Information sur le traitement de vos données personnelles"

# Texte HTML statique (aucune donnée utilisateur injectée).
RGPD_HTML = f"""
<p>L'outil d'auto-évaluation aux Bonnes Pratiques de Préparation (BPP) traite des données personnelles
vous concernant. La présente mention complète, pour ce qui est propre à l'outil, la
<a href="{SFPO_POLICY_URL}" target="_blank" rel="noopener">politique de protection des données de la SFPO</a>.</p>

<h4>Responsable du traitement</h4>
<p>Société Française de Pharmacie Oncologique (SFPO), association loi 1901, {SFPO_ADDRESS}.</p>

<h4>Finalités et bases légales</h4>
<ul>
  <li>gestion de votre compte utilisateur et sécurité de l'accès : exécution du contrat qui vous lie à la SFPO
      (article 6.1.b du RGPD) ;</li>
  <li>réalisation par votre établissement de son auto-évaluation au regard des BPP et suivi de son plan d'actions,
      accompagnement par les experts de la SFPO et études relatives à la pratique de la pharmacie oncologique,
      sur des données agrégées ne permettant pas d'identifier un établissement : intérêt légitime de la SFPO
      (article 6.1.f du RGPD).</li>
</ul>

<h4>Données traitées</h4>
<ul>
  <li>données d'identification : identifiant, nom, adresse e-mail, établissement de rattachement ;</li>
  <li>données de connexion : mot de passe (conservé sous forme chiffrée irréversible), date de dernière connexion,
      adresse IP dans les journaux techniques du serveur ;</li>
  <li>contenu de l'auto-évaluation : réponses, commentaires, références et fichiers justificatifs, plan d'actions ;</li>
  <li>date et version de l'acquittement de la présente mention.</li>
</ul>

<h4>Aucune donnée patient</h4>
<p><strong>L'outil n'est pas hébergé chez un Hébergeur de Données de Santé certifié.</strong>
Vous vous engagez à ne saisir et à ne téléverser aucune donnée permettant d'identifier, directement ou
indirectement, un patient (nom, date de naissance, numéro de dossier, étiquette de préparation, ordonnance…).
Tout document justificatif doit être anonymisé avant d'être joint.</p>

<h4>Destinataires</h4>
<ul>
  <li>les utilisateurs habilités de votre établissement ;</li>
  <li>les experts et administrateurs de l'outil habilités par la SFPO, dans la limite de leurs attributions.</li>
</ul>
<p>Les données de l'outil ne sont transmises à aucun partenaire académique ou commercial de la SFPO.
Les résultats individuels d'un établissement ne sont ni publiés ni communiqués à des tiers.
Les données ne font l'objet d'aucun transfert hors de l'Espace économique européen.</p>

<h4>Durée de conservation</h4>
<ul>
  <li>compte utilisateur : {ACCOUNT_RETENTION_YEARS} ans après la dernière connexion ;</li>
  <li>auto-évaluations : {EVALUATION_RETENTION_YEARS} ans après leur clôture, afin de permettre le suivi dans le temps, puis suppression
      ou anonymisation.</li>
</ul>

<h4>Vos droits</h4>
<p>Vous disposez d'un droit d'accès, de rectification, d'effacement, de limitation, d'opposition et de portabilité,
ainsi que du droit de définir des directives relatives au sort de vos données après votre décès.
L'outil ne prend aucune décision automatisée vous concernant.
Pour exercer vos droits, contactez le Délégué à la protection des données (DPO) par e-mail à
<a href="mailto:{DPO_EMAIL}">{DPO_EMAIL}</a> ou par courrier : SFPO, à l'attention du DPO, {SFPO_ADDRESS}.
Vous pouvez introduire une réclamation auprès de la CNIL, 3 place de Fontenoy, TSA 80715, 75334 Paris Cedex 07
(<a href="https://www.cnil.fr" target="_blank" rel="noopener">www.cnil.fr</a>).</p>

<h4>Cookies et stockage local</h4>
<p>L'outil utilise un cookie de session, indispensable à la connexion, et enregistre dans votre navigateur
des préférences d'affichage. Ces traceurs sont strictement nécessaires au service et ne sont pas soumis
à consentement (article 82 de la loi Informatique et Libertés).</p>
"""

RGPD_CHECKBOX_LABEL = (
    "J'ai pris connaissance de ces informations et je m'engage à ne saisir ni téléverser "
    "aucune donnée permettant d'identifier un patient."
)


def notice() -> dict:
    return {"version": RGPD_VERSION, "title": RGPD_TITLE, "html": RGPD_HTML,
            "checkbox": RGPD_CHECKBOX_LABEL, "policy_url": SFPO_POLICY_URL}
