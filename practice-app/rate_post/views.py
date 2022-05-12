from django.shortcuts import render
# Create your views here.
from post.models import Post
from rest_framework import generics,status
from rest_framework.response import Response
from rest_framework.views import APIView 
from .serializers import * 
import requests
import datetime
import json
class postVote(APIView):

    def get(self, *args, **kwargs):
        if("post_id" not in self.kwargs):
            return Response(data={"message" : f"Post id null!"}, status = status.HTTP_404_NOT_FOUND)
        id=self.kwargs["post_id"]
        
        try:
            queryset = Post.objects.get(id=id)
            serializedObject = ratePostSerializer(queryset)
            return Response(data=serializedObject.data,status=status.HTTP_200_OK)
        except:
            return Response(data={"message" : f"There is no such post with id: {id}"}, status = status.HTTP_404_NOT_FOUND)
            

    def post(self, request, *args, **kwargs):
        if("post_id" not in self.kwargs):
            return Response(data={"message" : f"Post id null!"}, status = status.HTTP_404_NOT_FOUND)
        id=self.kwargs["post_id"]

        queryset = Post.objects.filter(id=id)
        if(queryset):
            data = json.loads(request.body)
            vote = data["vote"]
            if(vote != 1 and vote != -1):
                return Response(data={"message" : f"You must send 1 for upvote, -1 for downvote."}, status = status.HTTP_406_NOT_ACCEPTABLE)
            
            timestamp = datetime.datetime.now()

            post = Post.objects.get(id=id)
            if(vote == 1):
                post.nof_upvotes += 1
            elif(vote == -1):
                post.nof_downvotes += 1

            post.save()

            serializedObject = ratePostSerializer(post)
            return Response(data=serializedObject.data,status=status.HTTP_200_OK)

        else:
            return Response(data={"message" : f"There is no such post with id: {id}"}, status = status.HTTP_404_NOT_FOUND)