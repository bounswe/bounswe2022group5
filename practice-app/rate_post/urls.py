from django.urls import path, include
from . import views

urlpatterns = [
    path('', views.indexRatePost, name='index'),
    path('api/<int:pk>',views.postVote.as_view(), name='api'),
    path('get/', views.postVote.getVoteApi, name="getVoteApi"),
    path('post/', views.postVote.postVoteApi, name="postVoteApi"),
]
