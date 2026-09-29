"""Authentification provisoire (login / mot de passe) en attendant le SSO SFPO.

Tout ce qui touche à l'identification est isolé ici : le jour où le SSO sera
branché, il suffira de remplacer la création de session (login) par le retour
du fournisseur d'identité ; le reste de l'application ne manipule que
`current_user` (id, rôle, centre).
"""
import hashlib
import hmac
import logging
import os
import secrets
import time
from typing import Optional

from fastapi import Depends, HTTPException, Request, Response

from app.db import execute, fetch_one

log = logging.getLogger("uvicorn.error")

SESSION_COOKIE = "bpp_session"
SESSION_DAYS = 7
PBKDF2_ITERATIONS = 260_000
MIN_PASSWORD_LENGTH = 10

# Anti force brute simple (mémoire du process) : 5 échecs -> blocage 15 min par login.
_MAX_FAILS = 5
_LOCK_SECONDS = 15 * 60
_fails: dict = {}


def hash_password(password: str) -> str:
    salt = secrets.token_hex(16)
    digest = hashlib.pbkdf2_hmac("sha256", password.encode(), salt.encode(), PBKDF2_ITERATIONS).hex()
    return f"pbkdf2_sha256${PBKDF2_ITERATIONS}${salt}${digest}"


def verify_password(password: str, stored: str) -> bool:
    try:
        algo, iterations, salt, digest = stored.split("$")
        if algo != "pbkdf2_sha256":
            return False
        test = hashlib.pbkdf2_hmac("sha256", password.encode(), salt.encode(), int(iterations)).hex()
        return hmac.compare_digest(test, digest)
    except ValueError:
        return False


def generate_password() -> str:
    """Mot de passe provisoire lisible (à transmettre au membre), sans caractères ambigus."""
    alphabet = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789"
    return "-".join("".join(secrets.choice(alphabet) for _ in range(4)) for _ in range(3))


def check_password_policy(password: str):
    if len(password) < MIN_PASSWORD_LENGTH:
        raise HTTPException(status_code=422, detail=f"Mot de passe trop court ({MIN_PASSWORD_LENGTH} caractères minimum)")


def ensure_bootstrap_expert():
    """Crée le compte expert initial si aucun compte n'existe encore.
    Identifiants fournis par ADMIN_LOGIN / ADMIN_PASSWORD (changement imposé à la 1re connexion)."""
    if fetch_one("SELECT 1 AS x FROM users LIMIT 1"):
        return
    login = os.environ.get("ADMIN_LOGIN", "expert").strip().lower()
    password = os.environ.get("ADMIN_PASSWORD")
    if not password:
        password = generate_password()
        log.warning("ADMIN_PASSWORD non défini : compte expert initial '%s' créé avec le mot de passe provisoire : %s",
                    login, password)
    execute(
        "INSERT INTO users (login, password_hash, role, nom, must_change_password) "
        "VALUES (%s, %s, 'expert', 'Expert SFPO', TRUE) ON CONFLICT (login) DO NOTHING",
        (login, hash_password(password)),
    )
    log.info("Compte expert initial créé : %s", login)


def _is_locked(login: str) -> bool:
    entry = _fails.get(login)
    return bool(entry and entry[0] >= _MAX_FAILS and time.time() - entry[1] < _LOCK_SECONDS)


def _register_fail(login: str):
    count, first = _fails.get(login, (0, time.time()))
    if time.time() - first > _LOCK_SECONDS:
        count, first = 0, time.time()
    _fails[login] = (count + 1, first)


def authenticate(login: str, password: str) -> dict:
    login = (login or "").strip().lower()
    if _is_locked(login):
        raise HTTPException(status_code=429, detail="Trop de tentatives, réessayez dans 15 minutes")
    user = fetch_one("SELECT id, password_hash, active FROM users WHERE login = %s", (login,))
    if not user or not user["active"] or not verify_password(password or "", user["password_hash"]):
        _register_fail(login)
        raise HTTPException(status_code=401, detail="Identifiant ou mot de passe incorrect")
    _fails.pop(login, None)
    return user


def open_session(response: Response, request: Request, user_id: int):
    token = secrets.token_urlsafe(32)
    execute("DELETE FROM sessions WHERE expires_at < now()")
    execute(
        "INSERT INTO sessions (token, user_id, expires_at) VALUES (%s, %s, now() + make_interval(days => %s))",
        (token, user_id, SESSION_DAYS),
    )
    execute("UPDATE users SET last_login_at = now() WHERE id = %s", (user_id,))
    secure = request.headers.get("x-forwarded-proto", request.url.scheme) == "https"
    response.set_cookie(SESSION_COOKIE, token, max_age=SESSION_DAYS * 86400, httponly=True,
                        samesite="lax", secure=secure, path="/")


def close_session(response: Response, request: Request):
    token = request.cookies.get(SESSION_COOKIE)
    if token:
        execute("DELETE FROM sessions WHERE token = %s", (token,))
    response.delete_cookie(SESSION_COOKIE, path="/")


def _user_from_request(request: Request) -> Optional[dict]:
    token = request.cookies.get(SESSION_COOKIE)
    if not token:
        return None
    return fetch_one(
        "SELECT u.id, u.login, u.role, u.nom, u.email, u.centre_id, u.must_change_password, c.libelle AS centre_libelle "
        "FROM sessions s JOIN users u ON u.id = s.user_id LEFT JOIN centres c ON c.id = u.centre_id "
        "WHERE s.token = %s AND s.expires_at > now() AND u.active",
        (token,),
    )


def current_user_any(request: Request) -> dict:
    """Utilisateur connecté, même s'il doit encore changer son mot de passe."""
    user = _user_from_request(request)
    if not user:
        raise HTTPException(status_code=401, detail="Non connecté")
    return user


def current_user(user: dict = Depends(current_user_any)) -> dict:
    if user["must_change_password"]:
        raise HTTPException(status_code=403, detail="Changement de mot de passe requis")
    return user


def require_expert(user: dict = Depends(current_user)) -> dict:
    if user["role"] != "expert":
        raise HTTPException(status_code=403, detail="Réservé aux experts")
    return user
