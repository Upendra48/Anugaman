import datetime

from services.mongo_service import db

from .jwt_utils import (
    generate_access_token,
    generate_refresh_token,
)
from .utils import (
    hash_password,
    verify_password,
)

users_collection = db['users']
boards_collection = db['boards']
columns_collection = db['columns']


DEFAULT_COLUMNS = [
    'Wishlist',
    'Applied',
    'Interviewing',
    'Offer',
    'Rejected'
]

def create_default_board(user_id):

    board = {
        "user_id": str(user_id),
        "name": "Job Hunt",
        "created_at": datetime.datetime.utcnow()
    }

    board_result = boards_collection.insert_one(board)

    board_id = board_result.inserted_id

    columns = []

    for index, column_name in enumerate(DEFAULT_COLUMNS):

        columns.append({
            "board_id": str(board_id),
            "name": column_name,
            "order": index
        })

    columns_collection.insert_many(columns)
    
    
    
def register_user(username, email, password):

    existing_user = users_collection.find_one({
        "email": email
    })

    if existing_user:
        return {
            "error": "User already exists"
        }

    hashed_password = hash_password(password)

    user = {
        "username": username,
        "email": email,
        "password": hashed_password,
        "created_at": datetime.datetime.utcnow()
    }

    result = users_collection.insert_one(user)

    user_id = result.inserted_id

    create_default_board(user_id)

    return {
        "message": "User created successfully",
        "user_id": str(user_id)
    }    
    
    
def login_user(email, password):

    user = users_collection.find_one({
        "email": email
    })

    if not user:
        return {
            "error": "Invalid credentials"
        }

    is_valid = verify_password(
        password,
        user["password"]
    )

    if not is_valid:
        return {
            "error": "Invalid credentials"
        }

    access_token = generate_access_token(user["_id"])

    refresh_token = generate_refresh_token(user["_id"])

    return {
        "message": "Login successful",
        "access_token": access_token,
        "refresh_token": refresh_token,
        "user": {
            "id": str(user["_id"]),
            "username": user["username"],
            "email": user["email"]
        }
    }    