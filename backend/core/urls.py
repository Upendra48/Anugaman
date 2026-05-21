"""
URL configuration for core project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/6.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from apps.authentication.views import test_db

# Swagger/OpenAPI schema view
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi

schema_view = get_schema_view(
    openapi.Info(
        title="Job Tracker API",
        default_version='v1',
        description="API documentation for the Job Tracker application",
    ),
    public=True,
    permission_classes=[permissions.AllowAny]
)





urlpatterns = [
    path('admin/', admin.site.urls),
    
    # API endpoints for authentication 
    path('api/auth/', include('apps.authentication.urls')),
    
    # API endpoints for boards
    path('api/boards/', include('apps.boards.urls')),
    
    # API endpoints for jobs
    path('api/jobs/', include('apps.jobs.urls')),
    
    # API endpoints for analytics
    path('api/analytics/', include('apps.analytics.urls')),
    
    # API endpoint for testing database connection
    path('test-db/', test_db),
    
    
    # Swagger/OpenAPI schema endpoints
    path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    path('redoc/', schema_view.with_ui('redoc', cache_timeout=0))
    
]
