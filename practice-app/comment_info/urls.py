from django.urls import path, include
from .views import commentList

urlpatterns = [
    path('api/<int:id>',commentList.as_view()),
    #r'^api/(?P<id>/$
]