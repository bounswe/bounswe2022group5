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
import re

#this is the external API that is used to fetch COVID19 data
EXTERNAL_COVID_API_URL = f'https://api.covid19api.com/summary'

#creates a form
#renders the page for post app
def index(req):
    postForm = PostForm()
    context = {'form':postForm}
    return render(req, 'post_index.html', context)

#calls the API and stores the returned data as response
#then processes tha response
#renders notfound page or createdpost page according to response
def create(req):
    response = poster(req).data
    if response in ['Missing input', 'Missing category info', 'User should be logged in', 'Category does not exist', 'User does not exist']: 
        return render(req, 'post_notfound.html', {'context':response})

    if(response["covid19cases"] == {}):
        post = [response["title"], response["body"], response["category"], response["user"], response["timestamp"], response["country"],  'No Data', 'No Data', response["nof_upvotes"], response["nof_downvotes"]]
    else:
        post = [response["title"], response["body"], response["category"], response["user"], response["timestamp"], response["country"],  response["covid19cases"]["death"], response["covid19cases"]["case"], response["nof_upvotes"], response["nof_downvotes"]]
    context = {'response':post}
    return render(req, 'post_create.html', context)

#calls the API and stores the returned data as responses
#then processes the responses
#renders the allposts page with the element of responses
def get(req):
    responses = poster(req).data
    
    posts = []
    for response in responses:
        if(response["covid19cases"] == {}):
            post = [response["title"], response["body"], response["category"], response["user"], response["timestamp"], response["country"],  'No Data', 'No Data', response["nof_upvotes"], response["nof_downvotes"]]
        else:
            post = [response["title"], response["body"], response["category"], response["user"], response["timestamp"], response["country"],  response["covid19cases"]["death"], response["covid19cases"]["case"], response["nof_upvotes"], response["nof_downvotes"]]
        posts.append(post)

    context = {'response':posts}
    return render(req, 'post_get.html', context)

#API to GET and POST
@api_view(["GET", "POST"])
def poster(req):

    #runs if the call method is GET
    #returns all the posts
    if req.method == "GET":
        posts = Post.objects.all()
        serializer = PostSerializer(posts, many=True)
        return Response(data=serializer.data)

    #runs if the call method is POST
    #creates a post
    #returns the data of the created post
    if req.method == "POST":
        
        #tries to fetch user input
        #returns error if fails
        try:
            title = req.POST['title']
            body = req.POST['body']
            category = req.POST['category']
        except:
            return Response('Missing input', status=status.HTTP_400_BAD_REQUEST)
        
        #tries to fetch country info
        #converts the first letter of every word to uppercase except the word 'of'
        #assigns country as empty string if fails
        try:
            country = req.POST['country']
            country = re.sub("(^|\s)(\S)", convert_into_uppercase, country.lower()).replace('Of', 'of')
        except:
            country = ''

        #tries to fetch user info from session
        #returns error if fails
        try:
            user = req.user.id
        except:
            return Response('User should be logged in', status=status.HTTP_400_BAD_REQUEST)

        #double checks
        #returns error if category field is empty
        if(category == ''): return Response('Missing category info', status=status.HTTP_400_BAD_REQUEST)
        #double checks
        #returns error if user info is not fetched
        if(user == None): return Response('User should be logged in', status=status.HTTP_400_BAD_REQUEST)

        #tries to get category id from database
        #returns error if fails
        try:
            p_category = Category.objects.get(pk=category)
        except:
            return Response('Category does not exist', status=status.HTTP_404_NOT_FOUND)

        #tries to get user id from database
        #returns error if fails
        try:
            p_user = User.objects.get(pk=user)
        except:
            return Response('User does not exist', status=status.HTTP_404_NOT_FOUND)

        #initializes covid19 data
        covid19 = {}

        #if country is succesfully entered
        #gets covid19 info from an external API
        #if the response from the external API is not empty set, updates covid19 data
        if not country == '':
            covidInfo = covidApi(country)

            if len(covidInfo) > 0:
                covid19 = {
                    'death': covidInfo[1],
                    'case': covidInfo[0],
                }
        #if no covid19 info is returned from the external API
        #change country field as NotFound instead of giving error
        if covid19 == {}:
            country = 'NotFound'

        #creates the final result of data to be returned
        data = {
            'title' : title,
            'body' : body,
            'category' : p_category,
            'user' : p_user,
            'country' : country,
            'covid19cases' : covid19    
        }
        
        #creates a post with corresponding data and returns the data
        _post = Post.objects.create(**data)
        serializer = PostSerializer(_post, partial=True)
        return Response(serializer.data, status=status.HTTP_201_CREATED)

#fetches covid19 data from an external API
#param: country: country name whose data will be fetched
def covidApi(country):
    result = requests.get(EXTERNAL_COVID_API_URL).json()
    countries = result["Countries"]

    country_info = [info for info in countries if info["Country"] == country]
    
    if country_info:
        country_info = country_info[0]
        return [country_info['NewConfirmed'], country_info['NewDeaths']]

    return []

#makes user input case-insensitive
def convert_into_uppercase(a):
    return a.group(1) + a.group(2).upper()














