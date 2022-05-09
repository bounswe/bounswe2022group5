from collections import UserList
from django.urls import path, include
from .views import  UserList, userDetail
urlpatterns = [
    path('userList',UserList.as_view()),
    path('userDetail',userDetail),
]