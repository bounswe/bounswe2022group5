from articles import views
from rest_framework.authtoken.views import obtain_auth_token 
from django.urls import path, include

urlpatterns = [
    path('all', views.get_all_articles, name='get_all_articles'),
    path('article', views.create_article, name='create article'),
    path('article/<int:id>', views.article, name='get article'),
    path('article/<int:id>/upvote', views.upvote_an_article, name='upvote an article'),
    path('article/<int:id>/downvote', views.downvote_an_article, name='downvote an article'),
]