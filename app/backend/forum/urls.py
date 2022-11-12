from forum import views
from rest_framework.authtoken.views import obtain_auth_token 
from django.urls import path, include

urlpatterns = [
    path('posts', views.get_all_posts, name='get_all_posts'),
    path('post', views.create_post, name='create post'),
    path('post/<int:id>', views.get_post, name='get post'),
]