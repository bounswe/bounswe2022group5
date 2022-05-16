from rest_framework.views import APIView
from rest_framework.renderers import TemplateHTMLRenderer
from rest_framework.response import Response
from rest_framework import status
from rest_framework import permissions
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import BasePermission, IsAuthenticated, SAFE_METHODS
from post.models import Post
from .serializers import CommentSerializer
import requests
from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
import os
from dotenv import load_dotenv
from .forms import *

# Important Note: There should be a valid rapid api key stored
# in an environment variable in .env file to get weather info.
load_dotenv()

class ReadOnly(BasePermission):
    def has_permission(self, request, view):
        return request.method in SAFE_METHODS

class CommentApiView(APIView):
    
    # This API is read-only, which means everyone can parform a GET, but
    # only authenticated users can perform a POST:
    permission_classes = [IsAuthenticated|ReadOnly]

    def get_post_object(self, post_id):
        try:
            return Post.objects.get(id=post_id)
        except Post.DoesNotExist:
            return None

    def get_comments(self, post_instance):
        return post_instance.comment_set.all()


    # 1. Get all comments:
    def get(self, request, post_id, *args, **kwargs):

        post_instance = self.get_post_object(post_id)
        if not post_instance:
            return Response(
                {"res": f"There is no post with id {post_id}"},
                status=status.HTTP_400_BAD_REQUEST
            )
        comments = self.get_comments(post_instance)
        serializer = CommentSerializer(comments, many=True)

        return Response(serializer.data, status=status.HTTP_200_OK)

    # 2. Create a new comment:
    def post(self, request, post_id, *args, **kwargs):

        post_instance = self.get_post_object(post_id)
        if not post_instance:
            return Response(
                {"res": f"There is no post with id {post_id}"}, 
                status=status.HTTP_400_BAD_REQUEST
            )

        city_name = request.data.get('city_name')
        url = "https://weatherapi-com.p.rapidapi.com/current.json"

        querystring = {"q":city_name}

        headers = {
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
            "X-RapidAPI-Key": os.getenv("X_RAPIDAPI_KEY")
        }

        response = requests.request("GET", url, headers=headers, params=querystring)

        weather = response.json()["current"]["condition"]["text"]
        city_name = response.json()["location"]["name"]

        data = {
            'body': request.data.get('body'), 
            'city_name': city_name, 
            'post': post_id,
            'weather': weather,
            'user': request.user.id,
            'nof_upvotes': 0,
            'nof_downvotes': 0
        }
        serializer = CommentSerializer(data=data)
        
        if serializer.is_valid():

            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# Views for Frontend:
def index(request):
    success = request.GET.get("success")
    getForm = commentGetForm()
    postForm = commentPostForm()
    return render(request, "comment.html", {
        "getForm":getForm, 
        "postForm":postForm, 
        "success":success,
        })

@api_view(['GET', 'POST'])
def getComments(request):
    a = CommentApiView()
    post_id = request.GET["post_id"]
    comments_raw = a.get(request=request, post_id=post_id).data
    comments = [] # body, user, city, weather
    for raw_comment in comments_raw:
        comment = [raw_comment["body"], raw_comment["user"], 
            raw_comment["city_name"], raw_comment["weather"],
            raw_comment["nof_upvotes"], raw_comment["nof_downvotes"]]
        comments.append(comment)
    return render(request, "listComments.html", {
        "comments":comments, 
        "post_id":post_id,
        })

@api_view(['GET', 'POST'])
@permission_classes([IsAuthenticated])
def postComment(request):
    a = CommentApiView()
    post_id = request.POST.get("post_id")
    a.post(request=request,post_id=post_id)
    getForm = commentGetForm()
    postForm = commentPostForm()
    return render(request, "comment.html", {
        "getForm":getForm, 
        "postForm":postForm, 
        "success":True
        })
        