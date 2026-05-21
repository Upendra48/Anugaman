from rest_framework.decorators import api_view, authentication_classes
from rest_framework.response import Response
from rest_framework import status

from apps.authentication.middleware import jwt_required

from .services import(
    create_job,
    get_job,
    get_jobs,
    update_job,
    delete_job,
    move_job
)


# create job endpoint
@api_view(['POST'])
@authentication_classes([])
@jwt_required
def create_job_view(request):
    
    result = create_job(request.data, request.user['_id'])
    
    if 'error' in result:
        return Response(result, status=status.HTTP_400_BAD_REQUEST)
    
    return Response(result, status=status.HTTP_201_CREATED)


@api_view(['GET'])
@authentication_classes([])
@jwt_required
def get_job_view(request, job_id):
    
    job = get_job(job_id, request.user['_id'])
    
    if not job:
        return Response({'error': 'Job not found'}, status=status.HTTP_404_NOT_FOUND)
    
    return Response(job, status=status.HTTP_200_OK)


@api_view(['GET'])
@authentication_classes([])
@jwt_required
def get_jobs_view(request):
    page = int(
        request.query_params.get('page', 1)
    )
    
    limit = int(
        request.query_params.get('limit', 10)
    )
    
    search = request.query_params.get('search')
    
    status_filter = request.GET.get('status')
    
    data = get_jobs(
        request.user['_id'],
        page,
        limit,
        search,
        status_filter
    )
    
    return Response(data, status=status.HTTP_200_OK)


@api_view(['PUT'])
@authentication_classes([])
@jwt_required
def update_job_view(request, job_id):
    
    job = update_job(job_id, request.data, request.user['_id'])
    
    if not job:
        return Response({'error': 'Job not found'}, status=status.HTTP_404_NOT_FOUND)
    
    return Response(job, status=status.HTTP_200_OK)


@api_view(['DELETE'])
@authentication_classes([])
@jwt_required
def delete_job_view(request, job_id):
    
    deleted = delete_job(job_id, request.user['_id'])
    
    if not deleted:
        return Response({'error': 'Job not found'}, status=status.HTTP_404_NOT_FOUND)
    
    return Response({'message': 'Job deleted successfully'}, status=status.HTTP_200_OK)


@api_view(['PATCH'])
@authentication_classes([])
@jwt_required
def move_job_view(request, job_id):
    
    target_column_id = request.data.get('target_column_id')
    
    
    new_order = request.data.get('new_order')
    
    moved_job = move_job(
        job_id,
        target_column_id,
        new_order,
        request.user['_id']
    )
    
    if not moved_job:
        return Response({'error': 'Move failed'}, status=status.HTTP_400_BAD_REQUEST)
    
    return Response(moved_job, status=status.HTTP_200_OK)