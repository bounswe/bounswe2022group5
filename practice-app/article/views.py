from django.shortcuts import render
import requests
import json
from .models import Article
from .forms import ArticlePostForm
from .serializers import ArticleSerializer
from category.models import Category
from django.contrib.auth.models import User
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.http import HttpResponseRedirect
from django.contrib import messages


def index(req):
    articleForm = ArticlePostForm()
    context = {'form':articleForm}
    return render(req, 'index.html', context)

def create(req):
    response = getpost(req).data
    if response == 'Missing input': return render(req, 'notfound.html')

    
    article = [response["title"], response["body"], response["category"], response["user"], response["timestamp"], response["nof_upvotes"], response["nof_downvotes"]]
    
    context = {'response':article}
    return render(req, 'create.html', context)

def get(req):
    responses = getpost(req).data    
    articles = []
    for response in responses:
        
        article = [response["title"], response["body"], response["category"], response["user"], response["timestamp"], response["nof_upvotes"], response["nof_downvotes"]]
        articles.append(article)

    context = {'response':articles}
    return render(req, 'get.html', context)

@api_view(["GET", "POST"])
def getpost(req):
    if req.method == "GET":
        articles = Article.objects.all()
        serializer = ArticleSerializer(articles, many=True)
        return Response(data=serializer.data)

    if req.method == "POST":

        try:
            title = req.POST['title']
            body = req.POST['body']
            category = req.POST['category']
            user = req.POST['user']
        except:
            return Response('Missing input', status=status.HTTP_400_BAD_REQUEST)
        
        
        p_category = Category.objects.get(pk=category)  # this is basically category id, should be 1 if its the category with the category_id = 1.

        #username = req.session['username']
        #username should be fetched from session, it will not be entered
        p_user = User.objects.get(pk=user)  # this is basically user id, should be 1 if its the user with the user_id = 1.

        
        data = {
            'title' : title,
            'body' : body,
            'category' : p_category,
            'user' : p_user,
        }
        
        _article = Article.objects.create(**data)
        serializer = ArticleSerializer(_article, partial=True)
        print(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
