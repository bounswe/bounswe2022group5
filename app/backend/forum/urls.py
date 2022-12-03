from forum import views
from rest_framework.authtoken.views import obtain_auth_token 
from django.urls import path, include

urlpatterns = [
    path('posts', views.get_all_posts, name='get_all_posts'),
    path('post', views.create_post, name='create post'),
    path('post/<int:id>', views.get_post, name='get post'),
    path('post/user/<int:user_id>', views.get_posts_of_user, name='get posts of user'),
    path('post/<int:id>/upvote', views.upvote_post, name='upvote a post'),
    path('post/<int:id>/downvote', views.downvote_post, name='downvote a post'),
    path('post/comment/<int:id>/upvote', views.upvote_comment, name='upvote a comment'),
    path('post/comment/<int:id>/downvote', views.downvote_comment, name='downvote a comment'),
    path('post/comment/<int:id>', views.get_comment, name='get comment'),
    path('post/<int:id>/comment', views.create_comment, name='create comment'),
]