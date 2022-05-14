from django.urls import path, include
from .views import (
    CategoryView,
    getCategories,
    postCategory,
    index,
)

urlpatterns = [
    path('', index, name="index"),
    path('list/', getCategories, name="getCategories"),
    path('create/', postCategory, name="postCategory"),
    path('api/', CategoryView.as_view()),
]