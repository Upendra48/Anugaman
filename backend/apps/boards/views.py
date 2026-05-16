from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from apps.authentication.middleware import jwt_required

from .services import (
    get_user_boards,
    get_board_by_id,
    get_board_columns
)

@api_view(['GET'])
@jwt_required
def user_boards(request):
    user = request.user
    boards = get_user_boards(user['_id'])
    
    return Response(boards, status=status.HTTP_200_OK)


@api_view(['GET'])
@jwt_required
def single_board(request, board_id):
    
    user = request.user
    board = get_board_by_id(board_id, user['_id'])
    
    if not board:
        return Response({'error': 'Board not found'}, status=status.HTTP_404_NOT_FOUND)
    
    return Response(board, status=status.HTTP_200_OK)

@api_view(['GET'])
@jwt_required
def board_columns(request, board_id):
    
    user = request.user
    
    columns = get_board_columns(board_id, user['_id'])
    
    if columns is None:
        return Response({'error': 'Board not found'}, status=status.HTTP_404_NOT_FOUND)
    
    return Response(columns, status=status.HTTP_200_OK)