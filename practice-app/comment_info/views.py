from django.shortcuts import render
# Create your views here.
from comment.models import Comment
from rest_framework import generics,status
from rest_framework.response import Response
from rest_framework.views import APIView 
from .serializers import * 
import requests
import datetime
import json
class commentList(APIView):

    def get(self, *args, **kwargs):
        id=self.kwargs["id"]
        queryset = Comment.objects.filter(id=id)
        
        if(queryset):
            serializedObject = commentInfoSerializer(queryset[0])
            return Response(data=serializedObject.data,status=status.HTTP_200_OK)
        else:
            return Response(data={"message" : f"There is no such comment with id: {id}"}, status = status.HTTP_404_NOT_FOUND)

    def post(self, request, *args, **kwargs):
        id=self.kwargs["id"]


        body = request.POST["body"]
        timestamp = datetime.datetime.now()
        city_name = request.POST["city_name"]
        r = requests.get(f"https://community-open-weather-map.p.rapidapi.com/weather?q={city_name}&units=metric",headers={"X-RapidAPI-Host": "community-open-weather-map.p.rapidapi.com", "X-RapidAPI-Key" : "c014e97b45mshfcf2fa729f382a2p10fd63jsn96c65393f10a"}).json()
        weather = r["weather"][0]["main"]


        comment = Comment.objects.get(id=id)
        comment.body = body
        comment.timestamp = timestamp
        comment.city_name = city_name
        comment.weather = weather

        comment.save()

        serializedObject = commentInfoSerializer(comment)
        return Response(data=serializedObject.data,status=status.HTTP_200_OK)
