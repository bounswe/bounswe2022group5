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
        # In order to check whether the given comment ID exists or not.
        queryset = Comment.objects.filter(id=id)
        
        if(queryset):
            serializedObject = commentInfoSerializer(queryset[0])
            return Response(data=serializedObject.data,status=status.HTTP_200_OK)
        else:
            return Response(data={"message" : f"There is no such comment with id: {id}"}, status = status.HTTP_404_NOT_FOUND)

    def post(self, request, *args, **kwargs):
        id=self.kwargs["id"]

        queryset = Comment.objects.filter(id=id)
        if(queryset):
            body = request.POST["body"]
            # To prevent empty bodies and very small bodies.
            if(len(body) < 5):
                return Response(data={"message" : f"Please insert a longer body message"}, status = status.HTTP_406_NOT_ACCEPTABLE)
            
            timestamp = datetime.datetime.now()
            city_name = request.POST["city_name"]

            # From here using the external API to fetch weather data.
            url = "https://weatherapi-com.p.rapidapi.com/current.json"
            querystring = {"q":city_name}

            headers = {
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
            "X-RapidAPI-Key": "ab60675eb2msh1e4a5cb6e387b12p19a699jsnf1fda92ea63f"}   

            r = requests.request("GET", url, headers=headers, params=querystring).json()
            
            if("current" in r):
                weather = r["current"]["condition"]["text"]
            else:
                weather = "There is no matching location. Weather information could not be found."
                # Note that we could've return another response and do not change the body also.
                # Instead of that, we simply leave the weather place with this message.
            # Weather data fetched.

            comment = Comment.objects.get(id=id)
            comment.body = body
            comment.timestamp = timestamp
            comment.city_name = city_name
            comment.weather = weather

            comment.save()

            serializedObject = commentInfoSerializer(comment)
            return Response(data=serializedObject.data,status=status.HTTP_200_OK)

        else:
            return Response(data={"message" : f"There is no such comment with id: {id}"}, status = status.HTTP_404_NOT_FOUND)