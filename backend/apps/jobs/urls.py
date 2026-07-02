from django.urls import path

from .views import(
    create_job_view,
    get_job_view,
    get_jobs_view,
    update_job_view,
    delete_job_view,
    move_job_view
)

urlpatterns = [
    path('', get_jobs_view, name='get_jobs'),
    path('create/', create_job_view, name='create_job'),
    path('<str:job_id>/', get_job_view, name='get_job'),
    path('<str:job_id>/update/', update_job_view, name='update_job'),
    path('<str:job_id>/delete/', delete_job_view, name='delete_job'),
    path('<str:job_id>/move/', move_job_view, name='move_job'),
]