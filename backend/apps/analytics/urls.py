from django.urls import path
from .views import (
    dashboard_summary_view,
    status_distribution_view,
    recent_applications_view
)

urlpatterns = [
    
    path('summary/', dashboard_summary_view, name='dashboard-summary'),
    path('status-distribution/', status_distribution_view, name='status-distribution'),
    path('recent-applications/', recent_applications_view, name='recent-applications')
]