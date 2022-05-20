from django.urls import path, include
from . import views

urlpatterns = [
    path('', views.indexRateArticle, name='index1'),
    path('api/<int:pk>',views.articleVotes.as_view(), name='api'),
    path('get/', views.articleVotes.getVoteApis, name="getVoteApis"),
    path('post/', views.articleVotes.postVoteApis, name="postVoteApis"),
]
