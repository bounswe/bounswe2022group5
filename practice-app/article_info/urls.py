from django.urls import path
from.views import ArticleInfo

urlpatterns = [
    path('api/<int:id>',ArticleInfo.as_view())
]