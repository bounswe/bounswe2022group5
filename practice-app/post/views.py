from django.shortcuts import render
import requests
import json
from .models import Post
from .forms import PostForm
from category.models import Category
from django.contrib.auth.models import User
from .serializers import PostSerializer
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

EXTERNAL_COVID_API_URL = f'https://coronavirus.m.pipedream.net/'

def index(req):
    postForm = PostForm()
    context = {'form':postForm}
    return render(req, 'index.html', context)

# response = Response(serializer.data)
#     get = {'response':response}
#     return render(req, 'get.html', get)

def create(req):
    response = poster(req).data
    print(response)
    post = [response["title"], response["body"], response["category"], response["user"], response["timestamp"], response["country"], response["covid19cases"], response["nof_upvotes"], response["nof_downvotes"]]
    print(post)

    context = {'response':post}
    return render(req, 'create.html', context)

def get(req):
    responses = poster(req).data
    
    posts = []
    for response in responses:
        post = [response["title"], response["body"], response["category"], response["user"], response["timestamp"], response["country"], response["covid19cases"], response["nof_upvotes"], response["nof_downvotes"]]
        posts.append(post)

    context = {'response':posts}
    return render(req, 'get.html', context)

@api_view(["GET", "POST"])
def poster(req):
    if req.method == "GET":
        posts = Post.objects.all()
        serializer = PostSerializer(posts, many=True)
        return Response(data=serializer.data)

    if req.method == "POST":

        try:
            title = req.POST['title']
            body = req.POST['body']
            category = req.POST['category']
            print('\n\n\n\n',category,'\n\n\n\n')
            user = req.POST['user']
        except:
            return Response('Missing input', status=status.HTTP_400_BAD_REQUEST)
        
        try:
            country = req.POST['country']
        except:
            country = ''

        #category of the post will be given as dropdown menu
        p_category = Category.objects.get(pk=category)

        #username = req.session['username']
        #username should be fetched from session, it will not be entered
        p_user = User.objects.get(pk=user)

        covid19 = {}

        if not country == '':
            covidInfo = covidApi(country)

            if len(covidInfo) > 0:
                covid19 = {
                    'death': covidInfo[1],
                    'case': covidInfo[0],
                }

        if covid19 == {}:
            country = 'NotFound'

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

    country_info = [info for info in countries if info["Country_Region"] == country]
    
    if country_info:
        country_info = country_info[0]
        return [country_info['Confirmed'], country_info['Deaths']]

    return []














