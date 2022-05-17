from django.shortcuts import render
# Create your views here.
from post.models import Post
from django.http import HttpResponse, HttpResponseRedirect
from rest_framework import generics,status
from rest_framework.response import Response
from rest_framework.views import APIView 
from .serializers import * 
from rest_framework import permissions
from rest_framework.decorators import api_view
import requests
import datetime
import json
from .forms import *

def indexRatePost(request):
    getForm = postGetForm()
    postForm = postPostForm()
    return render(request, "forms_rate_post.html", {"getForm":getForm, "postForm":postForm})

class postVote(APIView):
    
    # permission_classes = [permissions.IsAuthenticated]

    model = Post
    context_object_name = 'post'

    def get_object(self, pk):
        try:
            return Post.objects.get(pk=pk)

        except:
            return None

    def get(self, request, pk, *args, **kwargs):
        post = self.get_object(pk)

        if not post:
            return Response(
                {"message": "Object with post id does not exists"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        serializer = ratePostSerializer(post)
        return Response(serializer.data, status=status.HTTP_200_OK)
        
        # if("post_id" not in self.kwargs):
        #     return Response(data={"message" : f"Post id null!"}, status = status.HTTP_404_NOT_FOUND)
        # id=self.kwargs["post_id"]
        
        # try:
        #     queryset = Post.objects.get(id=id)
        #     serializedObject = ratePostSerializer(queryset)
        #     return Response(data=serializedObject.data,status=status.HTTP_200_OK)
        # except:
        #     return Response(data={"message" : f"There is no such post with id: {id}"}, status = status.HTTP_404_NOT_FOUND)
            

    def post(self, request, pk, *args, **kwargs):
        post = Post.objects.get(pk=pk)
        # print(type(post))
        if not post:
            return Response(
                {"message": "Object with post id does not exists"},
                status=status.HTTP_400_BAD_REQUEST
            )
        
    #     if("post_id" not in self.kwargs):
    #         return Response(data={"message" : f"Post id null!"}, status = status.HTTP_404_NOT_FOUND)
    #     id=self.kwargs["post_id"]

        queryset = Post.objects.filter(pk=pk)
        # print(queryset)
        if(queryset):
            data = request.data
            vote = data["vote"]
            # print(vote)
            # if(vote != 1 and vote != -1):
            #     return Response(data={"message" : f"You must send 1 for upvote, -1 for downvote."}, status = status.HTTP_406_NOT_ACCEPTABLE)
            
            timestamp = datetime.datetime.now()

            # post = Post.objects.get(pk=pk)
            # print(type(post))
            # print("-------------")
            # print(post.nof_upvotes)
            # print(post.nof_downvotes)
            # print("-------------")

            if(vote == "1"):
                post.nof_upvotes += 1
            elif(vote == "-1"):
                post.nof_downvotes += 1

            # print(post.nof_upvotes)
            # print(post.nof_downvotes)
            # print(post)
            # post.timestamp = timestamp
            post.save()

            serializedObject = ratePostSerializer(post)
            return Response(data=serializedObject.data,status=status.HTTP_200_OK)

        else:
            return Response(data={"message" : f"There is no such post with this id"}, status = status.HTTP_404_NOT_FOUND)

    @api_view(['GET', 'POST'])
    def getVoteApi(request):
        view = postVote()
        post_id = request.GET["post_id"]
        d = view.get(request=request, pk=post_id).data
        post = []
        # posts = []
        for data in d:
            post.append(d[data])
        # posts.append(post)
        return render(request, "view_rate_post.html", {"post":post})

    @api_view(['GET', 'POST'])
    def postVoteApi(request):
        view = postVote()
        post_id = request.POST["post_id"]
        # print(post_id)
        view.post(request=request, pk=post_id)
        return HttpResponseRedirect("..?success=true")