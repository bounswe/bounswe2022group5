from django.shortcuts import render
# Create your views here.
from article.models import Article
from django.http import HttpResponse, HttpResponseRedirect
from rest_framework import generics,status
from rest_framework.response import Response
from rest_framework.views import APIView 
from .serializers import * 
from rest_framework import permissions
from rest_framework.decorators import api_view
import requests
import datetime
import json
from .forms import *

def indexRateArticle(request):
    getForm = articleGetForm()
    postForm = articlePostForm()
    return render(request, "forms_rate_article.html", {"getForm":getForm, "postForm":postForm})

class articleVotes(APIView):
    model = Article
    context_object_name = 'article'

    def get_object(self, pk):
        try:
            return Article.objects.get(pk=pk)

        except:
            return None

    def get(self, request, pk, *args, **kwargs):
        article = self.get_object(pk)

        if not article:
            return Response(
                {"message": "Please enter a valid article-id. No articles were found with the given id."},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        serializer = rateArticleSerializer(article)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request, pk, *args, **kwargs):
        article = Article.objects.get(pk=pk)
        #article = self.get_object(pk)
        if not article:
            return Response(
                {"message": "Please enter a valid article-id. No articles were found with the given id."},
                status=status.HTTP_400_BAD_REQUEST
            )

        queryset = Article.objects.filter(pk=pk)
        if(queryset):
            data = request.data
            vote = data["vote"]

            if(vote == "1"):
                article.nof_upvotes += 1
            elif(vote == "-1"):
                article.nof_downvotes += 1
            article.save()

            serializedObject = rateArticleSerializer(article)
            return Response(data=serializedObject.data,status=status.HTTP_200_OK)

        else:
            return Response(data={"message" : f"Please enter a valid article-id. No articles were found with the given id."}, status = status.HTTP_404_NOT_FOUND)

    @api_view(['GET', 'POST'])
    def getVoteApis(request):
        view = articleVotes()
        article_id = request.GET["article_id"]
        d = view.get(request=request, pk=article_id).data
        article = []
        for data in d:
            article.append(d[data])
        return render(request, "view_rate_article.html", {"article":article})

    @api_view(['GET', 'POST'])
    def postVoteApis(request):
        view = articleVotes()
        article_id = request.POST["article_id"]
        view.post(request=request, pk=article_id)
        return HttpResponseRedirect("..?success=true")