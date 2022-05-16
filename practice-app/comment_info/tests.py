from django.test import TestCase,Client
from django.urls import resolve,reverse
from .views import commentList,index,requestGetter,requestPoster
from comment.models import Comment
from post.models import Post
from category.models import Category
from django.contrib.auth.models import User


