import jwt
import datetime
import os

from django.conf import settings
from dotenv import load_dotenv

load_dotenv()

SECRET_KEY = os.getenv("JWT_SECRET_KEY") or os.getenv("SECRET_KEY") or settings.SECRET_KEY

def generate_access_token(user_id):
    payload = {
        'user_id': str(user_id),
        'type': 'access',
        'iat': datetime.datetime.utcnow(),
        'exp': datetime.datetime.utcnow() + datetime.timedelta(hours=1)
    }
    
    token = jwt.encode(
        payload, 
        SECRET_KEY, 
        algorithm='HS256'
    )
    
    return token

def generate_refresh_token(user_id):
    payload = {
        'user_id': str(user_id),
        'type': 'refresh',
        'iat': datetime.datetime.utcnow(),
        'exp': datetime.datetime.utcnow() + datetime.timedelta(days=7)
    }
    
    token = jwt.encode(
        payload, 
        SECRET_KEY, 
        algorithm='HS256'
    )
    
    return token