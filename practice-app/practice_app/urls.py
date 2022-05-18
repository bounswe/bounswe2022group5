"""practice_app URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from article import urls as article_urls
from article_info import urls as article_info_urls
from category import urls as category_urls
from category_info import urls as category_info_urls
from comment import urls as comment_urls
from comment_info import urls as comment_info_urls
from post import urls as post_urls
from post_info import urls as post_info_urls
from rate_article import urls as rate_article_urls
from rate_comment import urls as rate_comment_urls
from rate_post import urls as rate_post_urls
from user import urls as user_urls
from _main import urls as _main_urls
urlpatterns = [
    path('',include(_main_urls)),
    path('admin/', admin.site.urls),
    # path('article/', include(article_urls)),
    # path('article-info/', include(article_info_urls)),
    path('category/', include(category_urls)),
    # path('category-info/', include(category_info_urls)),
    path('comment/', include(comment_urls)),
    path('comment-info/', include(comment_info_urls)),
    path('post/', include(post_urls)),
    path('post-info/', include(post_info_urls)),
    # path('rate-article/', include(rate_article_urls)),
    path('rate-comment/', include(rate_comment_urls)),
    path('rate-post/', include(rate_post_urls)),
    path('user/', include(user_urls)),
]
