from rest_framework.views import APIView
from rest_framework.renderers import TemplateHTMLRenderer
from rest_framework.response import Response
from rest_framework import status
from rest_framework import permissions
from rest_framework.decorators import api_view
from post.models import Post
from .serializers import CommentSerializer
import requests
from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect

class CommentApiView(APIView):
    
    permission_classes = [permissions.IsAuthenticated]

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
        try:

            url = "https://weatherapi-com.p.rapidapi.com/current.json"

            querystring = {"q":city_name}

            headers = {
                "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
                "X-RapidAPI-Key": "f258fa18e7msh6828d6e1336a89ap159e8ajsn6aab2bc173b1"
            }

            response = requests.request("GET", url, headers=headers, params=querystring)

            weather = response.json()["current"]["condition"]["text"]
            city_name = response.json()["location"]["name"]
        except:
            weather = request.data.get('weather')

        data = {
            'body': request.data.get('body'), 
            'city_name': city_name, 
            'post': post_id,
            'weather':weather,
            'user': request.user.id,
        }
        serializer = CommentSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)