from django.urls import path, include
from .views import (
    index,
    getComments,
    postComment,
    CommentApiView
)

urlpatterns = [
    path('', index, name="index"),
    path('list/', getComments, name="getComments"),
    path('create/', postComment, name="postComment"),
    path('api/<int:post_id>/', CommentApiView.as_view()),
]