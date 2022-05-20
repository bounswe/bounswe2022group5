from django.urls import path, include
from . import views

urlpatterns = [
    path('', views.index, name='index_post_info'),
    path('get/', views.getPost, name="getPost"),
    path('update/', views.postPost, name="postPost"),
    path('api/<int:pk>/', views.PostInfo.as_view(), name='api_post_info'),
]