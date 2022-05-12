from django.urls import path, include
from .views import postVote

urlpatterns = [
    path('api/<int:post_id>',postVote.as_view()),
]