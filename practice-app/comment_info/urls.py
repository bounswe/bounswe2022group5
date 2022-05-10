from django.urls import path, include
from .views import commentList
urlpatterns = [
    path('comment-info',commentList.as_view()),
]