from rest_framework.decorators import api_view, authentication_classes
from rest_framework.response import Response
from services.mongo_service import db
from rest_framework import status



@api_view(["GET"])
def test_db(request):
    collections = db.list_collection_names()

    return Response({
        "message": "MongoDB connected",
        "collections": collections
    })
    
from .services import (
    register_user,
    login_user
)    

from .middleware import jwt_required

@api_view(["POST"])
def register(request):
    username = request.data.get("username")
    email = request.data.get("email")
    password = request.data.get("password")
    
    # Validate input fields
    if not username or not email or not password:
        return Response(
            {"error": "All fields are required"},
            status=status.HTTP_400_BAD_REQUEST
        )
        
        
    # Call the service function to register the user
    result = register_user(username, email, password)
    
    if "error" in result:
        return Response(
            result,
            status=status.HTTP_400_BAD_REQUEST
        )    
        
    return Response(
        result,
        status=status.HTTP_201_CREATED
    )        
    
    
@api_view(["POST"])
def login(request):
    email = request.data.get("email")
    password = request.data.get("password")
    
    if not email or not password:
        return Response(
            {"error": "Email and password are required"},
            status=status.HTTP_400_BAD_REQUEST
        )
        
    result = login_user(email, password)
    
    if "error" in result:
        return Response(
            result,
            status=status.HTTP_401_UNAUTHORIZED
        ) 
           
    return Response(
        result,
        status=status.HTTP_200_OK
    )    
    
    
@api_view(["GET"])
@authentication_classes([])
@jwt_required
def current_user(request):
    user = request.user

    return Response({
        "user_id": str(user["_id"]),
        "username": user["username"],
        "email": user["email"]
    })    