"""Envoi des identifiants par e-mail (SMTP), optionnel.

Configuration par variables d'environnement (CapRover → App Configs) :
  SMTP_HOST, SMTP_PORT (587 par défaut), SMTP_USER, SMTP_PASSWORD,
  SMTP_FROM (adresse d'expédition, défaut : SMTP_USER),
  SMTP_SECURITY : starttls (défaut, port 587) | ssl (port 465) | none
  APP_URL : adresse publique de l'outil citée dans les messages (défaut : déduite de la requête).
Sans SMTP_HOST, l'envoi est désactivé : l'expert copie le message et l'envoie lui-même.
"""
import os
import smtplib
import ssl
from email.message import EmailMessage
from email.utils import formataddr, make_msgid

from fastapi import Request

SUBJECT = "Vos identifiants — Auto-évaluation BPP (SFPO)"


def smtp_configured() -> bool:
    return bool(os.environ.get("SMTP_HOST"))


def app_url(request: Request) -> str:
    url = os.environ.get("APP_URL")
    if url:
        return url.rstrip("/")
    proto = request.headers.get("x-forwarded-proto", request.url.scheme)
    host = request.headers.get("x-forwarded-host") or request.headers.get("host") or request.url.netloc
    return f"{proto}://{host}"


def credentials_message(*, nom: str, login: str, password: str, role: str, centre: str,
                        is_new: bool, url: str) -> str:
    is_expert = role == "expert"
    acces = "accès Expert / administrateur" if is_expert else "accès Membre"
    if is_expert:
        perimetre = ("Cet accès Expert / administrateur vous permet de consulter et d'expertiser les "
                     "questionnaires de tous les centres, et de gérer les centres et les comptes utilisateurs.")
    else:
        perimetre = ("Cet accès Membre vous permet de remplir le questionnaire d'auto-évaluation de votre centre"
                     + (f" ({centre})." if centre else "."))
    intro = (f"Un {acces} à l'outil d'auto-évaluation BPP de la SFPO a été créé pour vous.\n{perimetre}"
             if is_new else
             f"Le mot de passe de votre {acces} à l'outil d'auto-évaluation BPP de la SFPO a été réinitialisé.")
    return (
        f"Bonjour{' ' + nom if nom else ''},\n\n{intro}\n\n"
        f"Adresse : {url}\n"
        f"Type d'accès : {'Expert / administrateur' if is_expert else 'Membre'}\n"
        f"Identifiant : {login}\n"
        f"Mot de passe provisoire : {password}\n\n"
        "Vous devrez choisir un mot de passe personnel à la première connexion.\n\n"
        "Société Française de Pharmacie Oncologique"
    )


def send_mail(to: str, subject: str, body: str):
    """Envoie un e-mail texte ; lève une exception en cas d'échec (message lisible pour l'expert)."""
    host = os.environ["SMTP_HOST"]
    security = os.environ.get("SMTP_SECURITY", "starttls").lower()
    port = int(os.environ.get("SMTP_PORT", "465" if security == "ssl" else "587"))
    user = os.environ.get("SMTP_USER", "")
    password = os.environ.get("SMTP_PASSWORD", "")
    sender = os.environ.get("SMTP_FROM") or user

    msg = EmailMessage()
    msg["Subject"] = subject
    msg["From"] = formataddr(("SFPO — Auto-évaluation BPP", sender))
    msg["To"] = to
    msg["Message-ID"] = make_msgid(domain=sender.split("@")[-1] if "@" in sender else None)
    msg.set_content(body)

    context = ssl.create_default_context()
    if security == "ssl":
        server = smtplib.SMTP_SSL(host, port, timeout=15, context=context)
    else:
        server = smtplib.SMTP(host, port, timeout=15)
    try:
        if security == "starttls":
            server.starttls(context=context)
        if user:
            server.login(user, password)
        server.send_message(msg)
    finally:
        try:
            server.quit()
        except smtplib.SMTPException:
            pass


def try_send_credentials(to: str, body: str) -> dict:
    """Tente l'envoi ; ne lève jamais : renvoie {'email_sent': bool, 'email_error': str|None}."""
    if not to:
        return {"email_sent": False, "email_error": "Aucune adresse e-mail renseignée pour ce compte"}
    if not smtp_configured():
        return {"email_sent": False, "email_error": "Envoi d'e-mails non configuré sur le serveur"}
    try:
        send_mail(to, SUBJECT, body)
        return {"email_sent": True, "email_error": None}
    except Exception as exc:  # SMTP injoignable, authentification refusée, adresse rejetée...
        return {"email_sent": False, "email_error": f"Échec de l'envoi : {exc}"}
