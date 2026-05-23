import jwt
import os

from functools import wraps
from bson import ObjectId
from django.conf import settings
from dotenv import load_dotenv

from rest_framework.response import Response
from rest_framework import status

from services.mongo_service import db

load_dotenv()

SECRET_KEY = os.getenv("JWT_SECRET_KEY") or os.getenv("SECRET_KEY") or settings.SECRET_KEY

users_collection = db["users"]


def jwt_required(view_func):

    @wraps(view_func)
    def wrapper(request, *args, **kwargs):

        auth_header = request.headers.get("Authorization")
        
        #print("Auth Header:", auth_header)

        if not auth_header:
            return Response(
                {"error": "Authorization header missing"},
                status=status.HTTP_401_UNAUTHORIZED
            )

        try:
            token = auth_header.split(" ")[1]
            
            #print("Extracted Token:", token)

            payload = jwt.decode(
                token,
                SECRET_KEY,
                algorithms=["HS256"]
            )

            user_id = payload["user_id"]
            
            #print("Decoded User ID:", user_id)

            user = users_collection.find_one({
                "_id": ObjectId(user_id)
            })

            if not user:
                return Response(
                    {"error": "User not found"},
                    status=status.HTTP_401_UNAUTHORIZED
                )

            request.user = user

        except jwt.ExpiredSignatureError:
            return Response(
                {"error": "Token expired"},
                status=status.HTTP_401_UNAUTHORIZED
            )

        except jwt.InvalidTokenError:
            return Response(
                {"error": "Invalid token"},
                status=status.HTTP_401_UNAUTHORIZED
            )

        return view_func(request, *args, **kwargs)

    return wrapper