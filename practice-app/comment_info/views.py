from django.shortcuts import render
# Create your views here.
from comment.models import Comment
from rest_framework import generics,status
from rest_framework.response import Response
from rest_framework.decorators import api_view
class commentList(generics.ListAPIView):
    queryset = Comment.objects.all()
    

