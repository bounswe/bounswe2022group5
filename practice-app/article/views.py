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
import re

def articleIndex(req):
    articleForm = ArticlePostForm()
    context = {'form':articleForm}
    return render(req, 'article_index.html', context)

def createArticle(req):
    response = getpost(req).data
    # if response == 'Missing input': return render(req, 'notfound.html')
    if response in ['Missing input', 'Category info is missing', 'User should be logged in to post articles', 'Category does not exist', 'User does not exist']: 
        return render(req, 'article_cannot.html', {'context':response})

    
    article = [response["title"], response["body"], response["category"], response["user"], response["timestamp"], response["nof_upvotes"], response["nof_downvotes"]]
    
    context = {'response':article}
    return render(req, 'article_create.html', context)

def getArticles(req):
    responses = getpost(req).data    
    articles = []
    for response in responses:
        
        article = [response["title"], response["body"], response["category"], response["user"], response["timestamp"], response["nof_upvotes"], response["nof_downvotes"]]
        articles.append(article)

    context = {'response':articles}
    return render(req, 'article_get.html', context)

@api_view(["GET", "POST"])
def getpost(req):
    # if the request is a GET request, fetch all articles.
    if req.method == "GET":
        articles = Article.objects.all()
        serializer = ArticleSerializer(articles, many=True)
        return Response(data=serializer.data)
    # if the request is a POST request, create an article. Returns the article.
    if req.method == "POST":

        try:
            title = req.POST['title']
            body = req.POST['body']
            category = req.POST['category']
            # user = req.POST['user'] # not needed.
        except:
            return Response('Missing input', status=status.HTTP_400_BAD_REQUEST)
        
        # try to fetch user info from session
        try:
            user = req.user.id
        except:
            return Response('User should be logged in to post articles', status=status.HTTP_400_BAD_REQUEST)

        # if category is empty, return an error response.
        if category == '':
            return Response('Category info is missing', status=status.HTTP_400_BAD_REQUEST)
        
        # if user is empty, return an error response.
        if user == None: 
            return Response('User should be logged in to post articles', status=status.HTTP_400_BAD_REQUEST)
        
        # try to get category id from database, return error if not exist.
        try:
            p_category = Category.objects.get(pk=category)
        except:
            return Response('Category does not exist', status=status.HTTP_404_NOT_FOUND)

        # p_category = Category.objects.get(pk=category)  # this is basically category id, should be 1 if its the category with the category_id = 1.

        # try to get the user id from database, if not exist return error.
        try:
            p_user = User.objects.get(pk=user)
        except:
            return Response('User does not exist', status=status.HTTP_404_NOT_FOUND)

        # p_user = User.objects.get(pk=user)  # this is basically user id, should be 1 if its the user with the user_id = 1.

        # create the data dictionary which will be saved to database.
        data = {
            'title' : title,
            'body' : body,
            'category' : p_category,
            'user' : p_user,
        }
        
        # create ('C'RUD) the article and save it to database.
        _article = Article.objects.create(**data)
        serializer = ArticleSerializer(_article, partial=True)
        # return the article info.
        return Response(serializer.data, status=status.HTTP_201_CREATED)
