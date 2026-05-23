from bson import ObjectId

from services.mongo_service import db

boards_collection = db['boards']
collections_collection = db['columns']
jobs_collection = db['jobs']

def get_user_boards(user_id):
    boards = list(
        boards_collection.find(
            {
                'user_id': str(user_id)
            }
        )
    )
    
    formatted_boards = []
    
    for board in boards:
        formatted_boards.append(
            {
                'id': str(board['_id']),
                'name': board['name'],
                'created_at': board['created_at'],
            }
        )
    
    return formatted_boards        

def get_board_by_id(board_id, user_id):
    board = boards_collection.find_one(
        {
            '_id': ObjectId(board_id),
            'user_id': str(user_id)
        }
    )
    
    if not board:
        return None
    
    formatted_board = {
        'id': str(board['_id']),
        'name': board['name'],
        'created_at': board['created_at'],
    }
    
    return formatted_board    

def get_board_columns(board_id, user_id):
    
    board = boards_collection.find_one(
        {
            '_id': ObjectId(board_id),
            'user_id': str(user_id)
        }
    )
    
    if not board:
        return None
    
    columns = list(
        collections_collection.find(
            {
                'board_id': str(board_id),
            }
        ).sort('order', 1)
    )
    
    formatted_columns = []
    
    for column in columns:
        formatted_columns.append(
            {
                'id': str(column['_id']),
                'name': column['name'],
                'order': column['order'],
            }
        )
    
    return formatted_columns