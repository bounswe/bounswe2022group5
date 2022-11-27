from backend.models import CustomUser
from forum.models import PostImages, CommentImages
from datetime import datetime
from rest_framework.response import Response
from rest_framework import status
from forum.serializers import PostSerializer, CommentSerializer
from backend.pagination import ForumPagination
from forum.models import Post, Comment
from common.views import upload_to_s3, delete_from_s3
from rest_framework.pagination import PageNumberPagination
from django.shortcuts import get_object_or_404, render
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated
import math
# Create your views here.

@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_all_posts(request):
    paginator = PageNumberPagination()
    paginator.page_size = request.GET.get('page_size', 10)
    paginator.page = request.GET.get('page_size', 1)
    post_objects = Post.objects.all()
    result_page = paginator.paginate_queryset(post_objects, request)
    serializer = PostSerializer(result_page, many=True)
    return paginator.get_paginated_response(serializer.data)


@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_posts_of_user(request, user_id):

    author = CustomUser.objects.get(id=user_id)

    paginator = PageNumberPagination()
    paginator.page_size = request.GET.get('page_size', 10)
    paginator.page = request.GET.get('page_size', 1)

    posts = Post.objects.filter(author=author)

    temp = request.GET.get('sort', 'desc')
    if temp == 'desc' or temp == 'asc':
        sort = temp
    else:
        sort = 'desc'

    if sort == 'asc':
        posts = posts.order_by('date')
    elif sort == 'desc':
        posts = posts.order_by('-date')

    result_page = paginator.paginate_queryset(posts, request)

    serializer = PostSerializer(result_page, many=True)

    return paginator.get_paginated_response(serializer.data)


def _get_comment_of_post(id):
    post = Post.objects.get(id=id)
    comments= []
    comments_queryset = Comment.objects.filter(post=post).order_by('date')
    for comment in comments_queryset:
        comment_images = CommentImages.objects.filter(comment=comment)
        image_urls = [image.image_url for image in comment_images]
        comment_serializer = CommentSerializer(comment)
        data = {
            'comment' : comment_serializer.data(),
            'image_urls': image_urls
        }
        comments.append(data)

    return comments



@api_view(['GET','DELETE', 'POST'])
@permission_classes([IsAuthenticated,])
def get_post(request,id):
    if (request.method == 'GET'):
        post = Post.objects.get(id = id)
        post_serializer = PostSerializer(post)
        comments = _get_comment_of_post(id)
        post_images = PostImages.objects.filter(post=post)
        image_urls = [image.image_url for image in post_images]
        response = {
            'post' :  post_serializer.data,
            'image_urls': image_urls,
            'comments': comments
        }
        return Response(response, status=200)


    if (request.method == 'DELETE'):
        try:
            post = Post.objects.get(id=id)
        except:
            return Response({'error': 'Post not found'}, status=400)

        post.delete()

        return Response(status=200)

    if (request.method == 'POST'):
        validate_post = PostSerializer(data=request.data)
        if validate_post.is_valid():
            try:
                post = Post.objects.get(id=id)
            except:
                return Response({'error': 'Post not found'}, status=400)
            data = request.data
            post.title = data['title']
            post.body = data['body']
            post.longitude = request.data['longitude']
            post.latitude = request.data['latitude']
            post.save()
            post_serializer = PostSerializer(post)

            return Response({'post': post_serializer.data}, status=200)
        else:
            data = validate_post.errors
            return Response(status=400, data={'error': f'Fields are missing'})

@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def create_post(request):
    title = request.data['title']
    author = request.user
    body = request.data['body']
    date = datetime.now()

    longitude = request.data['longitude']
    latitude = request.data['latitude']

    post = Post(title=title, author=author, body=body, date=date, longitude= longitude, latitude = latitude)
    post.save()

    data = {
        'title':title,
        'author': author,
        'body':body,
        'date':date,
        'longitude': longitude,
        'latitude': latitude
    }

    response_object = {}
    response_object['post'] = PostSerializer(data).data
    image_urls = []
    if len(request.FILES) > 0:
        count = 1
        for filename, file in request.FILES.items():
            image = file.read()
            photo_url = upload_to_s3(image, f'post/{post.id}/{count}.jpg')
            count = count + 1
            postImage = PostImages(image_url=photo_url, post=post)
            postImage.save()
            image_urls.append(photo_url)

    response_object['image_urls'] = image_urls

    return Response(response_object)

@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def upvote_post(request, id):
        try:
            post = Post.objects.get(id=id)
            user_info = CustomUser.objects.get(id = request.user.id)
        except:
            return Response({'error': 'Post not found'}, status=400)

        if id in user_info.upvoted_posts :
            post.upvote -= 1
            post.save()
            user_info.upvoted_posts.remove(id)
            user_info.save()
        elif id in user_info.downvoted_posts :
            post.downvote -= 1
            post.upvote += 1
            post.save()
            user_info.downvoted_posts.remove(id)
            user_info.upvoted_posts.append(id)
            user_info.save()
        else:
            post.upvote += 1
            post.save()
            user_info.upvoted_posts.append(id)
            user_info.save()

        post_serializer = PostSerializer(post)
        return Response({'post': post_serializer.data}, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def downvote_post(request, id):
        try:
            post = Post.objects.get(id=id)
            user_info = CustomUser.objects.get(id = request.user.id)
        except:
            return Response({'error': 'Post not found'}, status=400)
        if id in user_info.downvoted_posts :
            post.downvote -= 1
            post.save()
            user_info.downvoted_posts.remove(id)
            user_info.save()
        elif id in user_info.upvoted_posts :
            post.upvote -= 1
            post.downvote += 1
            post.save()
            user_info.upvoted_posts.remove(id)
            user_info.downvoted_posts.append(id)
            user_info.save()
        else:
            post.downvote += 1
            post.save()
            user_info.downvoted_posts.append(id)
            user_info.save()

        post_serializer = PostSerializer(post)
        return Response({'post': post_serializer.data}, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def upvote_comment(request, id):
    try:
        comment = Comment.objects.get(id=id)
        user_info = CustomUser.objects.get(id=request.user.id)
    except:
        return Response({'error': 'Comment not found'}, status=400)

    if id in user_info.upvoted_comments:
        comment.upvote -= 1
        comment.save()
        user_info.upvoted_comments.remove(id)
        user_info.save()
    elif id in user_info.downvoted_comments:
        comment.downvote -= 1
        comment.upvote += 1
        comment.save()
        user_info.downvoted_comments.remove(id)
        user_info.upvoted_comments.append(id)
        user_info.save()
    else:
        comment.upvote += 1
        comment.save()
        user_info.upvoted_comments.append(id)
        user_info.save()

    comment_serializer = CommentSerializer(comment)
    return Response({'comment': comment_serializer.data}, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def downvote_comment(request, id):
    try:
        comment = Comment.objects.get(id=id)
        user_info = CustomUser.objects.get(id=request.user.id)
    except:
        return Response({'error': 'Comment not found'}, status=400)

    if id in user_info.downvoted_comments:
        comment.downvote -= 1
        comment.save()
        user_info.downvoted_comments.remove(id)
        user_info.save()
    elif id in user_info.upvoted_comments:
        comment.upvote -= 1
        comment.downvote += 1
        comment.save()
        user_info.upvoted_comments.remove(id)
        user_info.downvoted_comments.append(id)
        user_info.save()
    else:
        comment.downvote += 1
        comment.save()
        user_info.downvoted_comments.append(id)
        user_info.save()

    comment_serializer = CommentSerializer(comment)
    return Response({'comment': comment_serializer.data}, status=200)


@api_view(['GET','DELETE', 'POST'])
@permission_classes([IsAuthenticated,])
def get_comment(request,id):
    if (request.method == 'GET'):
        comment = Comment.objects.get(id = id)
        comment_serializer = CommentSerializer(comment)

        return Response(comment_serializer.data, status=200)


    if (request.method == 'DELETE'):
        try:
            comment = Comment.objects.get(id=id)
        except:
            return Response({'error': 'Comment not found'}, status=400)

        comment.delete()

        return Response(status=200)

    if (request.method == 'POST'):
        validate_comment = CommentSerializer(data=request.data)
        if validate_comment.is_valid():
            try:
                comment = Comment.objects.get(id=id)
            except:
                return Response({'error': 'Comment not found'}, status=400)
            data = request.data
            comment.body = data['body']
            comment.longitude = request.data['longitude']
            comment.latitude = request.data['latitude']
            comment.save()
            comment_serializer = CommentSerializer(comment)

            return Response({'comment': comment_serializer.data}, status=200)
        else:
            data = validate_comment.errors
            return Response(status=400, data={'error': f'Fields are missing'})

@api_view(['POST', ])
@permission_classes([IsAuthenticated, ])
def create_comment(request):
    author = request.user
    body = request.data['body']
    date = datetime.now()

    longitude = request.data['longitude']
    latitude = request.data['latitude']

    comment = Comment(author=author, body=body, date=date, longitude=longitude, latitude=latitude)
    comment.save()

    data = {
        'author': author,
        'body': body,
        'date': date,
        'longitude': longitude,
        'latitude': latitude
    }

    response_object = {}
    response_object['post'] = CommentSerializer(data).data
    image_urls = []
    if len(request.FILES) > 0:
        count = 1
        for filename, file in request.FILES.items():
            print(file)
            image = file.read()
            photo_url = upload_to_s3(image, f'comment/{comment.id}/{count}.jpg')
            count = count + 1
            commentImage = CommentImages(image_url=photo_url, post=comment)
            commentImage.save()
            image_urls.append(photo_url)

    response_object['image_urls'] = image_urls

    return Response(response_object)
