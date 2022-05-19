from .views import *
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('', articleIndex, name="article_index"),
    path('get/', getArticles, name="article_get"),
    path('create/', createArticle, name="article_create"),
    path('api/',  getpost, name='getpost'),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)