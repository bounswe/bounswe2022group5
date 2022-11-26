from forum.models import PostImages
from datetime import datetime
from rest_framework.response import Response
from rest_framework import status
from forum.serializers import PostSerializer, CommentSerializer
from backend.pagination import ForumPagination
from forum.models import Post, Comment
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

    data = {
        'title':title,
        'author': author,
        'body':body,
        'date':date
    }

    response_object = {}
    response_object['post'] = PostSerializer(data).data

    if 'image_urls' in request.data and len(request.data['image_urls']) > 0:
        for image_url in request.data['image_urls']:
            url = PostImages(image_url=image_url, post=post)
            url.save()
        response_object['image_urls'] = request.data['image_urls']
    else:
        response_object['image_urls'] = []

    return Response(response_object)

@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def upvote_post(request, id):
        try:
            post = Post.objects.get(id=id)
        except:
            return Response({'error': 'Post not found'}, status=400)
        post.upvote += 1
        post.save()
        post_serializer = PostSerializer(post)

        return Response({'post': post_serializer.data}, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def downvote_post(request, id):
        try:
            post = Post.objects.get(id=id)
        except:
            return Response({'error': 'Post not found'}, status=400)
        post.downvote += 1
        post.save()
        post_serializer = PostSerializer(post)

        return Response({'post': post_serializer.data}, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def upvote_comment(request, id):
        try:
            comment = Comment.objects.get(id=id)
        except:
            return Response({'error': 'Comment not found'}, status=400)
        comment.upvote += 1
        comment.save()
        comment_serializer = CommentSerializer(comment)

        return Response({'comment': comment_serializer.data}, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def downvote_comment(request, id):
        try:
            comment = Comment.objects.get(id=id)
        except:
            return Response({'error': 'Comment not found'}, status=400)
        comment.downvote += 1
        comment.save()
        comment_serializer = CommentSerializer(comment)

        return Response({'comment': comment_serializer.data}, status=200)
