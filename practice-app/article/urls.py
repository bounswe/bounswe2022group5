from .views import *
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('', index, name="index"),
    path('get/', get, name="get"),
    path('create/', create, name="create"),
    path('api/',  getpost, name='getpost'),
]