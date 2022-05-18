from django.shortcuts import render
from django.http import HttpResponseRedirect
from matplotlib.font_manager import json_load
from comment.models import Comment
from rate_comment.serializers import RateCommentSerializer
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView 
from rest_framework.decorators import api_view
from rate_comment.serializers import * 
from rate_comment.forms import *

def index(request):
    a = commentGetForm()   
    b = commentPostForm()
    return render(request, "formsratecomment.html", {"getForm":a, "postForm":b})

class CommentRating(APIView):
    
    def get(self, request, pk, *args, **kwargs):
        comment_check = Comment.objects.filter(pk=pk)
        if (comment_check):
            serializer = RateCommentSerializer(Comment.objects.get(pk=pk))
            return Response(data=serializer.data, status=status.HTTP_200_OK)
        else:
            return Response(data={"error" : f"There is no such comment with id: {pk}"}, status = status.HTTP_404_NOT_FOUND)

    def post(self, request, pk, *args, **kwargs):
        comment_check = Comment.objects.filter(pk=pk)
        
        if(comment_check):
            
            comment = Comment.objects.get(pk=pk)
            data = request.data
            vote = data.get("vote",True)

            if(vote == "1"):
                comment.nof_upvotes += 1
            elif(vote == "-1"):
                comment.nof_downvotes += 1
            comment.save()

            serializedObject = RateCommentSerializer(comment)
            return Response(data=serializedObject.data,status=status.HTTP_200_OK)

        else:
            return Response(data={"message" : f"There is no such comment with this id"}, status = status.HTTP_404_NOT_FOUND)

    
    def getVoteApi(request):
        view = CommentRating()
        if 'comment_id' in request.GET:
            comment_id = request.GET['comment_id']
        else:
            comment_id = False
        d = view.get(request=request, pk=comment_id).data
        comment = []
        for data in d:
            comment.append(d[data])
        return render(request, "viewratecomment.html", {"post":comment})
    @api_view(['GET', 'POST'])
    def postVoteApi(request):
        view = CommentRating()
        comment_id = request.POST["comment_id"]
        test = view.post(request=request, pk=comment_id)
        if (test.status_code == 200):
            return HttpResponseRedirect("..?success=true")
        else:
            comment=[]
            return render(request, "viewratecomment.html",{"action_fail":True})


# Create your views here.