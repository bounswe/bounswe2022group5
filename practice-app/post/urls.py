from .views import *
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('api', poster, name='poster'),
    path('', index, name='index'),
    path('get', get, name='get'),
    path('create', create, name='create'),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)