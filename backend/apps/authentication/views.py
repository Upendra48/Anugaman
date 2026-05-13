from rest_framework.decorators import api_view
from rest_framework.response import Response
from services.mongo_service import db

@api_view(["GET"])
def test_db(request):
    collections = db.list_collection_names()

    return Response({
        "message": "MongoDB connected",
        "collections": collections
    })