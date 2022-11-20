from user_profile import views
from rest_framework.authtoken.views import obtain_auth_token 
from django.urls import path

urlpatterns = [
    path('upload_profile_picture', views.upload_profile_picture, name='upload_profile_picture'),
    path('delete_profile_picture', views.delete_profile_picture, name='delete_profile_picture'),
]
