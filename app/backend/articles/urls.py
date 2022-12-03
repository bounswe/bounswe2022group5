from articles import views
from rest_framework.authtoken.views import obtain_auth_token 
from django.urls import path, include

urlpatterns = [
    path('all', views.get_all_articles, name='get_all_articles'),
    path('article', views.create_article, name='create article'),
    path('article/<int:id>', views.article, name='get article'),
    path('article/user/<int:user_id>', views.get_articles_of_doctor, name='get articles of doctor'),
    path('article/<int:id>/upvote', views.upvote_article, name='upvote an article'),
    path('article/<int:id>/downvote', views.downvote_article, name='downvote an article'),
]