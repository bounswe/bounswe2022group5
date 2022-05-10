from django.urls import path, include
from .views import (
    CommentApiView
)

urlpatterns = [
    path('api/<int:post_id>/', CommentApiView.as_view()),
]