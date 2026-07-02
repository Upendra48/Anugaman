from .base import *

DEBUG = False

ALLOWED_HOSTS = ['*']  # later change to specific host in production

STATIC_ROOT = BASE_DIR / 'staticfiles'
STATIC_URL = '/static/'

SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
USE_X_FORWARDED_HOST = True