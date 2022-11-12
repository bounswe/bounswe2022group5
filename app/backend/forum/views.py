from forum.models import PostImages
from datetime import datetime
from django.db import IntegrityError
from rest_framework.response import Response
from rest_framework import status
from forum.serializers import PostSerializer
from backend.pagination import ForumPagination
from forum.models import Post
from django.core.paginator import Paginator
from rest_framework.pagination import PageNumberPagination
from django.shortcuts import get_object_or_404, render
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
# Create your views here.

@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_all_posts(request):
    paginator = PageNumberPagination()
    paginator.page_size = 10
    post_objects = Post.objects.all()
    result_page = paginator.paginate_queryset(post_objects, request)
    serializer = PostSerializer(result_page, many=True)
    return paginator.get_paginated_response(serializer.data)

@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_post(request,id):
    post = Post.objects.get(id = id)
    post_serializer = PostSerializer(post)
    
    return Response(post_serializer.data, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def create_post(request):
    title = request.data['title']
    author = request.user
    body = request.data['body']
    date = datetime.now()

    post = Post(title=title, author=author, body=body, date=date)
    post.save()

    image_urls = request.data['image_urls']
    for image_url in image_urls:
        url = PostImages(image_url=image_url, post=post)
        url.save()
    data = {
        'title':title,
        'author': author,
        'body':body,
        'date':date
    }
    
    serialized_data = PostSerializer(data)
    print(serialized_data.data)
    return Response({'post':serialized_data.data, 'image_urls': image_urls})

    

