from django.urls import path
from.views import ArticleInfo
from . import views
urlpatterns = [
    path('', views.index, name="index_article_info"),
    path('get/', views.getArticle, name="getArticle"),
    path('update/', views.postArticle, name="postArticle"),
    path('api/<int:id>',ArticleInfo.as_view(), name="api_article_info")

]