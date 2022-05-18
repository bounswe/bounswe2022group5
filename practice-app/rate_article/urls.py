from django.urls import path, include
from . import views

urlpatterns = [
    path('', views.indexRateArticle, name='index'),
    path('api/<int:pk>',views.articleVotes.as_view()),
    path('get/', views.articleVotes.getVoteApis, name="getVoteApis"),
    path('post/', views.articleVotes.postVoteApis, name="postVoteApis"),
]
