from .views import UserViewSet, login_user, logout_user, register_user, me
from authentication import views
from rest_framework.authtoken.views import obtain_auth_token 
from django.urls import path, include

urlpatterns = [
    path("get-users",UserViewSet.as_view({'get': 'list'})), 
    path('healthcheck', views.HealthCheck.as_view(), name='health-check'),
    path('register', register_user, name='register'),
    path('login', login_user, name='login'),
    path('logout', logout_user, name='logout'),
    path('me', me, name='me'),
]