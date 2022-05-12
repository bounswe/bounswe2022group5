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

baseAPIURL = "http://localhost:8000/comment-info/api/"
weatherAPIKEY = "ab60675eb2msh1e4a5cb6e387b12p19a699jsnf1fda92ea63f"

# Rendering index of the page
def index(req):
    return render(req, "index.html")

# This is for rendering the first form, which is used for getting a comment with a spesific ID.
# Calls the GET part of the API in the below in order to get the data from the database.
def requestGetter(req):
    id=req.POST["id"]
    url = baseAPIURL + str(id)
    r = requests.request("GET" , url).json()
    if("error" in r):
        message = [r["error"]]
        return render(req, "error.html", {"comment": message})
    else:
        array = [r["id"], r["body"], r["timestamp"], r["city_name"], r["weather"], r["user"], r["post"]]
        return render(req, "result.html", {"comment": array})

# This is for rendering the second form in the html. Used for updating a comment with a spesific ID.
# Calls the POST part of the API in the below.
def requestPoster(req):
    id=req.POST["id"]
    url = baseAPIURL + str(id)
    data = {"body": req.POST["body"], "city_name": req.POST["city_name"]}
    r = requests.request("POST", url, data=data).json()
    if("error" in r):
        message = [r["error"]]
        return render(req, "error.html", {"comment": message})
    else:
        array = [r["id"], r["body"], r["timestamp"], r["city_name"], r["weather"], r["user"], r["post"]]
        return render(req, "result.html", {"comment": array})

# Our API lies here.
# It has 2 functions as GET and POST.
# Get part finds the corresponding Comment with the given ID in the database and returns it's values in a json format.
# Post part updates the Comment with the given ID and make necessary changes in the database.
# Both functions make necessary parameter checks.
class commentList(APIView):

    def get(self, *args, **kwargs):
        id=self.kwargs["id"]
        # In order to check whether the given comment ID exists or not.

        queryset = Comment.objects.filter(id=id)
        if(queryset):
            serializedObject = commentInfoSerializer(queryset[0])
            return Response(data=serializedObject.data,status=status.HTTP_200_OK)
        else:
            return Response(data={"error" : f"There is no such comment with id: {id}"}, status = status.HTTP_404_NOT_FOUND)


    def post(self, request, *args, **kwargs):

        id=self.kwargs["id"]
        queryset = Comment.objects.filter(id=id)

        if(queryset):
            try:
                body = request.POST["body"]
            except:
                return Response(data={"error" : f"Body field not found"}, status = status.HTTP_406_NOT_ACCEPTABLE)

            # To prevent empty bodies and very small bodies.
            if(len(body) < 5):
                return Response(data={"error" : f"Please insert a longer body message"}, status = status.HTTP_406_NOT_ACCEPTABLE)
            
            timestamp = datetime.datetime.now()
            try:
                city_name = request.POST["city_name"]
            except:
                return Response(data={"message" : f"City field not found"}, status = status.HTTP_406_NOT_ACCEPTABLE)
            
            # From here using the external API to fetch weather data.
            url = "https://weatherapi-com.p.rapidapi.com/current.json"
            querystring = {"q":city_name}

            headers = {
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
            "X-RapidAPI-Key": weatherAPIKEY}   

            r = requests.request("GET", url, headers=headers, params=querystring).json()
            # default weather value.
            weather = "There is no matching weather."
            if("current" in r):
                if("condition" in r["current"]):
                    if("text" in r["current"]["condition"]):
                        weather = r["current"]["condition"]["text"]
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
            return Response(data={"error" : f"There is no such comment with id: {id}"}, status = status.HTTP_404_NOT_FOUND)