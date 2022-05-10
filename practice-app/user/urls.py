
from django.urls import path, include
from .views import  UserList, userDetail
urlpatterns = [
    path('api',UserList.as_view()),
    path('api/<str:username>',userDetail.as_view()),
]