
from django.urls import path, include
from .views import  UserList, allUsers, userDetail,userView, createUser
from django.conf import settings
from django.conf.urls.static import static
urlpatterns = [
    path('api',UserList.as_view(),name="api"),
    path('api/<str:username>',userDetail.as_view(),name='detailView'),
    path('',userView, name = "userMain"),
    path('allUsers',allUsers,name="allUsers"),
    path('createUser',createUser,name="createUser")
]  + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)