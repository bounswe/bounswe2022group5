from .views import *
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('api', poster, name='poster'),
    path('', index, name='post_index'),
    path('get', get, name='post_get'),
    path('create', create, name='post_create'),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)