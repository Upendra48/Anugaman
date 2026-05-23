from django.urls import path

from .views import (
    user_boards,
    single_board,
    board_columns
)

urlpatterns = [
    path('', user_boards, name='user_boards'),
    path('<str:board_id>/', single_board, name='single_board'),
    path('<str:board_id>/columns/', board_columns, name='board_columns'),
]