
from django.urls import path, include
from .views import  UserList, allUsers, userDetail,userView, createUser
urlpatterns = [
    path('api',UserList.as_view(),name="api"),
    path('api/<str:username>',userDetail.as_view(),name='api/<str:username>'),
    path('',userView),
    path('allUsers',allUsers,name="allUsers"),
    path('createUser',createUser,name="createUser")
]