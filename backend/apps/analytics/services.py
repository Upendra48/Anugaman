import json

from bson import ObjectId

from services.mongo_service import db
from services.redis_service import redis_client

jobs_collection = db['jobs']

def get_dashboard_summary(user_id):
    
    cache_key = f'dashboard_summary:{user_id}'
    
    cached_data = redis_client.get(cache_key)
    if cached_data:
        return json.loads(cached_data)
    
    
    total_jobs = jobs_collection.count_documents(
        {'user_id': ObjectId(user_id)}
        )
    
    interviewing= jobs_collection.count_documents(
        {
            'user_id': ObjectId(user_id),
            'status': 'interviewing'
        }
    )
    
    offers = jobs_collection.count_documents(
        {
            'user_id': ObjectId(user_id),
            'status': 'offer'
        }
    )
    
    rejected = jobs_collection.count_documents({
        'user_id': ObjectId(user_id),
        'status': 'rejected'
    })
    
    summary = {
        'total_jobs': total_jobs,
        'interviewing': interviewing,
        'offers': offers,
        'rejected': rejected
    }
    
    redis_client.setex(
        cache_key,
        300,
        json.dumps(summary)
    )
    
    return summary

def get_status_distribution(user_id):
    
    
    pipeline = [
        {'$match': {'user_id': ObjectId(user_id)}},
        {'$group': {'_id': '$status', 'count': {'$sum': 1}}}
    ]
    
    results = list(
        jobs_collection.aggregate(pipeline)
    )
    
    formatted = []
    
    for item in results:
        formatted.append({
            'status': item['_id'],
            'count': item['count']
        })
    
    return formatted


def get_recent_applications(user_id):
    
    jobs = list(
        jobs_collection.find(
            {'user_id': ObjectId(user_id)}
        ).sort('created_at', -1).limit(5)
    )
    
    formatted = []
    
    for job in jobs:
        formatted.append({
            'id': str(job['_id']),
            'title': job['title'],
            'company': job['company'],
            'status': job['status'],
        })
        
    return formatted    