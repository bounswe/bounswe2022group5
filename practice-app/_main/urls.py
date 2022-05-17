
from django.urls import path, include
from .views import main,Login,Logout
from django.conf import settings
from django.conf.urls.static import static
urlpatterns = [
    path('',main,name="main"),
    path('login',Login,name="login"),
    path('logout',Logout,name="logout")
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)