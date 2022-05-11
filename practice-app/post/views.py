from django.shortcuts import render
import requests
from .models import Post
from category.models import Category
from django.contrib.auth.models import User
from .serializers import PostSerializer
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

EXTERNAL_COVID_API_URL = f'https://coronavirus.m.pipedream.net/'

@api_view(["GET", "POST"])
def post(req):
    if req.method == "GET":
        posts = Post.objects.all()
        serializer = PostSerializer(posts, many=True)
        return Response(serializer.data)

    if req.method == "POST":

        try:
            title = req.POST['title']
            body = req.POST['body']
            category = req.POST['category']
            user = req.POST['user']
        except:
            return Response('Missing input', status=status.HTTP_400_BAD_REQUEST)
        
        try:
            country = req.POST['country']
        except:
            country = ''

        #category of the post will be given as dropdown menu
        p_category = Category.objects.get(name=category)

        #username = req.session['username']
        #username should be fetched from session, it will not be entered
        p_user = User.objects.get(username=user)

        covid19 = {}

        if not country == '':
            covidInfo = covidApi(country)

            covid19 = {
                'death': covidInfo[1],
                'case': covidInfo[0],
            }

        data = {
            'title' : title,
            'body' : body,
            'category' : p_category,
            'user' : p_user,
            'country' : country,   #country name should be fetched from location
            'covid19cases' : covid19    
        }
        
        _post = Post.objects.create(**data)
        serializer = PostSerializer(_post, partial=True)
        return Response(serializer.data, status=status.HTTP_201_CREATED)



def covidApi(country):
    result = requests.get(EXTERNAL_COVID_API_URL).json()
    countries = result["rawData"]

    country_info = [info for info in countries if info["Country_Region"] == country][0]

    return [country_info['Confirmed'], country_info['Deaths']]














