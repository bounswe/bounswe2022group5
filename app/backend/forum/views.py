import os
from typing import Optional

from backend.models import CustomUser, Doctor, Member
from forum.models import PostImages, CommentImages
from datetime import datetime
from rest_framework.response import Response
from rest_framework import status
from forum.serializers import PostSerializer, CommentSerializer, UpdatePostSerializer, CreateCommentSerializer
from backend.pagination import ForumPagination
from forum.models import Post, Comment
from common.views import upload_to_s3, delete_from_s3
from rest_framework.pagination import PageNumberPagination
from django.shortcuts import get_object_or_404, render
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
import math
# Create your views here.

@api_view(['GET',])
@permission_classes([IsAuthenticated, AllowAny])
def get_all_posts(request):
    paginator = PageNumberPagination()
    paginator.page_size = request.GET.get('page_size', 10)
    paginator.page = request.GET.get('page', 1)
    post_objects = Post.objects.all().order_by('-date')[0:10]


    posts = []
    user = CustomUser.objects.get(id= request.user.id)

    for post in post_objects:
        serializer_post_data = PostSerializer(post).data
        if post.id in user.upvoted_posts:
            serializer_post_data['vote'] = 'upvote'
        elif post.id in user.downvoted_posts:
            serializer_post_data['vote'] = 'downvote'
        else:
            serializer_post_data['vote'] = None

        author = post.author
        if author.type == 1:
            try:
                doctor_data = Doctor.objects.get(user=author)
                author_data = {
                    'id': author.id,
                    'username': doctor_data.full_name,
                    'profile_photo': doctor_data.profile_picture,
                    'is_doctor': True
                }
            except:
                author_data = None

        elif author.type == 2:
            try:
                member_data = Member.objects.get(user=author)
                author_data = {
                    'id': author.id,
                    'username': member_data.member_username,
                    'profile_photo': f"https://api.multiavatar.com/{member_data.info.avatar}.svg?apikey={os.getenv('AVATAR')}",
                    'is_doctor': False
                }
            except:
                author_data = None
        serializer_post_data["author"] = author_data
        posts.append(serializer_post_data)

    result_page = paginator.paginate_queryset(posts, request)

    return paginator.get_paginated_response(result_page)


@api_view(['GET',])
@permission_classes([IsAuthenticated,AllowAny])
def get_posts_of_user(request, user_id):

    author = CustomUser.objects.get(id=user_id)

    paginator = PageNumberPagination()
    paginator.page_size = request.GET.get('page_size', 10)
    paginator.page = request.GET.get('page', 1)

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

    response_dict=[]
    for post in posts:
        post_dict = PostSerializer(post).data
        if post.id in request.user.upvoted_posts:
            post_dict['vote'] = 'upvote'
        elif post.id in request.user.downvoted_posts:
            post_dict['vote'] = 'downvote'
        else:
            post_dict['vote'] = None
        response_dict.append(post_dict)

    result_page = paginator.paginate_queryset(response_dict, request)



    return paginator.get_paginated_response(result_page)


def _get_comment_of_post(id, author, user):
    post = Post.objects.get(id=id)
    comments= []
    comments_queryset = Comment.objects.filter(post=post).order_by('date')
    for comment in comments_queryset:
        comment_images = CommentImages.objects.filter(comment=comment)
        image_urls = [image.image_url for image in comment_images]
        comment_serializer = CommentSerializer(comment)
        comment_result = comment_serializer.data
        if author.type == 1:
            doctor_data = Doctor.objects.get(user=author)
            author_data = {
                'id': author.id,
                'username': doctor_data.full_name,
                'profile_photo': doctor_data.profile_picture,
                'is_doctor': True
            }

        elif author.type == 2:
            member_data = Member.objects.get(user=author)
            author_data = {
                'id': author.id,
                'username': member_data.member_username,
                'profile_photo': f"https://api.multiavatar.com/{member_data.info.avatar}.svg?apikey={os.getenv('AVATAR')}",
                'is_doctor': False
            }

        comment_result['author'] = author_data

        if user:
            if comment.id in user.upvoted_comments:
                comment_result['vote'] = 'upvote'
            elif comment.id in user.downvoted_comments:
                comment_result['vote'] = 'downvote'
            else:
                comment_result['vote'] = None
        else:
            comment_result['vote'] = None
        comment_result["id"] = comment.id
        data = {
            'comment' : comment_result,
            'image_urls': image_urls

        }

        comments.append(data)

    return comments

@api_view(['GET',])
@permission_classes([AllowAny, IsAuthenticated])
def get_comments_of_user(request, user_id):

    author = CustomUser.objects.get(id=user_id)

    paginator = PageNumberPagination()
    paginator.page_size = request.GET.get('page_size', 10)
    paginator.page = request.GET.get('page', 1)

    comments = Comment.objects.filter(author=author)

    temp = request.GET.get('sort', 'desc')
    if temp == 'desc' or temp == 'asc':
        sort = temp
    else:
        sort = 'desc'

    if sort == 'asc':
        posts = comments.order_by('date')
    elif sort == 'desc':
        posts = comments.order_by('-date')

    response_dict = []
    for comment in comments:
        comment_dict = CommentSerializer(comment).data
        if comment.id in request.user.upvoted_posts:
            comment_dict['vote'] = 'upvote'
        elif comment.id in request.user.downvoted_posts:
            comment_dict['vote'] = 'downvote'
        else:
            comment_dict['vote'] = None
        response_dict.append(comment_dict)

    result_page = paginator.paginate_queryset(response_dict, request)



    return paginator.get_paginated_response(result_page)

@api_view(['GET','DELETE', 'POST'])
@permission_classes([IsAuthenticated,AllowAny])
def get_post(request,id):
    if (request.method == 'GET'):
        try:
            post = Post.objects.get(id = id)
        except:
            return Response({'error': 'Post not found'}, status=400)
        post_serializer = PostSerializer(post)
        response_dict = post_serializer.data
        author = post.author
        comments = _get_comment_of_post(id, author, request.user)
        post_images = PostImages.objects.filter(post=post)
        image_urls = [image.image_url for image in post_images]


        if author.type == 1:
            doctor_data = Doctor.objects.get(user=author)
            author_data = {
                'id': author.id,
                'username': doctor_data.full_name,
                'profile_photo': doctor_data.profile_picture,
                'is_doctor': True
            }
            response_dict['author'] = author_data
        elif author.type == 2:
            member_data = Member.objects.get(user=author)
            author_data = {
                'id': author.id,
                'username': member_data.member_username,
                'profile_photo': f"https://api.multiavatar.com/{member_data.info.avatar}.svg?apikey={os.getenv('AVATAR')}",
                'is_doctor': False
            }

            response_dict["author"] = author_data


        if post.id in request.user.upvoted_posts:
            response_dict['vote'] = 'upvote'
        elif post.id in request.user.downvoted_posts:
            response_dict['vote'] = 'downvote'
        else:
            response_dict['vote'] = None



        response = {
            'post' :  response_dict,
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
        validate_post = UpdatePostSerializer(data=request.data)
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

    if "longitude" in request.data:
        longitude = request.data['longitude']
    else:
        longitude = None
    if "latitude" in request.data:
        latitude = request.data['latitude']
    else:
        latitude = None

    post = Post(title=title, author=author, body=body, date=date, longitude= longitude, latitude = latitude)
    post.save()
    if author.type == 1:
        doctor_data = Doctor.objects.get(user=author)
        author_data = {
            'id': author.id,
            'username': doctor_data.full_name,
            'profile_photo': doctor_data.profile_picture,
            'is_doctor': True
        }


    elif author.type == 2:
        member_data = Member.objects.get(user=author)
        author_data = {
            'id': author.id,
            'username': member_data.member_username,
            'profile_photo': f"https://api.multiavatar.com/{member_data.info.avatar}.svg?apikey={os.getenv('AVATAR')}",
            'is_doctor': False
        }


    data = {
        'id' : post.id,
        'title':title,
        'author': author,
        'body':body,
        'date':date,
        'longitude': longitude,
        'latitude': latitude
    }

    response_object = {}
    response_object['post'] = PostSerializer(data).data
    response_object['post']['author'] = author_data
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
def create_comment(request, id):
    try:
        post = Post.objects.get(id=id)
    except:
        return Response({'error': 'Post not found'}, status=400)
    author = request.user
    body = request.data['body']
    date = datetime.now()

    if "longitude" in request.data:
        longitude = request.data['longitude']
    else:
        longitude = None

    if "latitude" in request.data:
        latitude = request.data['latitude']
    else:
        latitude = None


    comment = Comment(author=author, body=body, date=date, longitude=longitude, latitude=latitude, post=post)
    comment.save()

    data = {
        'author': author.id,
        'body': body,
        'date': date,
        'longitude': longitude,
        'latitude': latitude,
        'post': post.id
    }

    response_object = {}
    serializer = CreateCommentSerializer(data=data)
    if serializer.is_valid():
        response_object['comment'] = serializer.data
        image_urls = []
        if len(request.FILES) > 0:
            count = 1
            for filename, file in request.FILES.items():
                image = file.read()
                photo_url = upload_to_s3(image, f'comment/{comment.id}/{count}.jpg')
                count = count + 1
                commentImage = CommentImages(image_url=photo_url, comment=comment)
                commentImage.save()
                image_urls.append(photo_url)

        response_object['image_urls'] = image_urls
        if(Doctor.objects.filter(user=request.user).exists()):
            post.commented_by_doctor = True
            post.save()
        return Response(response_object)
    else:
        error = serializer.errors
        return Response(status=400, data={'error': f'Fields are missing'})
