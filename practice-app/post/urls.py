from .views import *
from django.urls import path
urlpatterns = [
    path('api', post, name='post')
]