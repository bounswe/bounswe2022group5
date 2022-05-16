from django.urls import path, include
from .views import *

urlpatterns = [
    path('api/<int:id>',commentList.as_view(), name="base"),
    path('', commentInfoIndex, name="comment-info-index"),
    path('SearchResult', requestGetter, name="requestGetter"),
    path('UpdatedResult', requestPoster, name="requestPoster"),
]