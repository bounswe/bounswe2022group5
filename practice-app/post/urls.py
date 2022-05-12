from .views import *
from django.urls import path
urlpatterns = [
    path('api', poster, name='poster'),
    path('', index, name='index'),
    path('get', get, name='get'),
    path('create', create, name='create'),
]