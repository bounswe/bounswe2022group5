from django.urls import path
from rate_comment import views

urlpatterns = [
    path('',  views.index, name="index"),
    path('api/<int:pk>', views.CommentRating.as_view()),
    path('get/', views.CommentRating.getVoteApi, name='getVoteApi'),
    path('post/', views.CommentRating.postVoteApi, name='postVoteApi')
]
