from user_profile import views
from rest_framework.authtoken.views import obtain_auth_token 
from django.urls import path

urlpatterns = [
    path('upload_profile_picture', views.upload_profile_picture, name='upload_profile_picture'),
    path('delete_profile_picture', views.delete_profile_picture, name='delete_profile_picture'),
    path('upvoted_articles/<int:user_id>', views.get_upvoted_articles, name='get_upvoted_articles'),
    path('upvoted_articles', views.get_upvoted_articles, name='get_upvoted_articles2'),
    path('upvoted_posts/<int:user_id>', views.get_upvoted_posts, name='get_upvoted_posts'),
    path('upvoted_posts', views.get_upvoted_posts, name='get_upvoted_posts2'),
]
