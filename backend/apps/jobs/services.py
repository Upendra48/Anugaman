import datetime


from bson import ObjectId

from services.mongo_service import db

jobs_collection = db['jobs']
columns_collection = db['columns']
boards_collection = db['boards']


def validate_column_ownership(column_id, user_id):
    
    column = columns_collection.find_one(
        {
            '_id': ObjectId(column_id)
            
        }
    )
    
    if not column:
        return None
    
    board = boards_collection.find_one({
        '_id': ObjectId(column['board_id']),
        'user_id': str(user_id)
    })
    
    if not board:
        return None
    
    return column


def create_job(data, user_id):
    
    column = validate_column_ownership(data['column_id'], user_id)
    
    if not column:
        return None, 'Column not found or access denied'
    
    last_job = jobs_collection.find_one({
        'column_id': data['column_id']
    },
        sort=[('order', -1)]
    )  
    
    next_order = 100
    
    if last_job:
        next_order = last_job['order'] + 100
        
        
    job = {
        'title': data['title'],
        'company': data['company'],
        'location': data.get('location'),
        'salary': data.get('salary'),
        'description': data.get('description'),
        'status': column['name'].lower(),
        'column_id': data['column_id'],
        'board_id': column['board_id'],
        'user_id': str(user_id),
        'order': next_order,
        'created_at': datetime.datetime.utcnow(),
    } 
    
    result = jobs_collection.insert_one(job)
    job['_id'] = result.inserted_id 
    
    return format_job(job)


def format_job(job):
    return {
        '_id': str(job['_id']),
        'title': job['title'],
        'company': job['company'],
        'location': job.get('location'),
        'salary': job.get('salary'),
        'description': job.get('description'),
        'status': job['status'],
        'column_id': job['column_id'],
        'board_id': job['board_id'],
        'order': job['order'],
    }
    
    
def get_job(job_id, user_id):
    
    job = jobs_collection.find_one({
        '_id': ObjectId(job_id),
        'user_id': str(user_id)
    })
    
    if not job:
        return None
    
    return format_job(job)

def update_job(job_id, data, user_id):
    
    job = jobs_collection.find_one({
        '_id': ObjectId(job_id),
        'user_id': str(user_id)
    })
    
    if not job:
        return None, 'Job not found or access denied'
    
    update_data = {
        'title': data.get('title', job['title']),
        'company': data.get('company', job['company']),
        'location': data.get('location', job.get('location')),
        'salary': data.get('salary', job.get('salary')),
        'description': data.get('description', job.get('description')),
    }  
    
    jobs_collection.update_one(
        {'_id': ObjectId(job_id)},
        {'$set': update_data}
    )
    
    updated_job = jobs_collection.find_one(
        {
            '_id': ObjectId(job_id)
        }
    )
    
    return format_job(updated_job)


def delete_job(job_id, user_id):
    job = jobs_collection.find_one({
        '_id': ObjectId(job_id),
        'user_id': str(user_id)
    })
    
    if not job:
        return False, 'Job not found or access denied'
    
    jobs_collection.delete_one({'_id': ObjectId(job_id)})
    
    return True, 'Job deleted successfully'


# Move Job logic
def move_job(job_id, target_column_id, new_order, user_id):
    
    job = jobs_collection.find_one(
        {
            '_id': ObjectId(job_id),
            'user_id': str(user_id)
        }
    )    
    
    if not job:
        return None, 'Job not found or access denied'
    
    column = validate_column_ownership(target_column_id, user_id)
    
    if not column:
        return None, 'Target column not found or access denied'
    
    jobs_collection.update_one(
        {
            '_id': ObjectId(job_id)
        
        },
        {
            '$set': {
                'column_id': target_column_id,
                'status': column['name'].lower(),
                'order': new_order
            }
        }
    )
    
    updated_job = jobs_collection.find_one(
        {
            '_id': ObjectId(job_id)
        }
    )
    
    return format_job(updated_job)