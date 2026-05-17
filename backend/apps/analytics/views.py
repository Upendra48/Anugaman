from rest_framework.decorators import api_view, authentication_classes
from rest_framework.response import Response


from apps.authentication.middleware import jwt_required

from .services import (
    get_dashboard_summary,
    get_status_distribution,
    get_recent_applications
)

@api_view(['GET'])
@authentication_classes([])
@jwt_required
def dashboard_summary_view(request):
    
    data = get_dashboard_summary(request.user['_id'])
    
    return Response(data)

@api_view(['GET'])
@authentication_classes([])
@jwt_required
def status_distribution_view(request):
    
    data = get_status_distribution(request.user['_id'])
    
    return Response(data)



@api_view(['GET'])
@authentication_classes([])
@jwt_required
def recent_applications_view(request):
    
    data = get_recent_applications(request.user['_id'])
    
    return Response(data)