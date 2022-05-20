from django.urls import path
from rate_comment import views

urlpatterns = [
    path('',  views.index, name="Commentindex"),
    path('api/<int:pk>', views.CommentRating.as_view(), name='api'),
    path('get/', views.CommentRating.getCommentVoteApi, name='getCommentVoteApi'),
    path('post/', views.CommentRating.postCommentVoteApi, name='postCommentVoteApi')
]