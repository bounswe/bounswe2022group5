from .views import UserViewSet
from authentication import views
from rest_framework.authtoken.views import obtain_auth_token 
from django.urls import path, include

urlpatterns = [
    path("get-users",UserViewSet.as_view({'get': 'list'})), 
    path('healthcheck', views.HealthCheck.as_view(), name='health-check'),
    path('api-token-auth', obtain_auth_token, name='api_token_auth'),
]