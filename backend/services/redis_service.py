import redis
import os
from dotenv import load_dotenv

from django.conf import settings

load_dotenv()

redis_client = redis.Redis(
    host=os.getenv("REDIS_HOST"),
    port=os.getenv("REDIS_PORT"),
    db =0,
    decode_responses=True
)