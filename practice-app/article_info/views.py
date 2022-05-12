import datetime

from django.shortcuts import render

# Create your views here.
from rest_framework import generics,status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.views import APIView
from article.models import Article
from article.serializers import ArticleSerializer

# Create your views here.
class ArticleInfo(APIView):

    def get(self,request,id):
        article = Article.objects.get(id=id)
        if(article):
            serializer =ArticleSerializer(article)
            return Response(serializer.data,status=status.HTTP_200_OK)
        else:
            return Response(data = {"error": f"There is no such article with id: {id}"}, status=status.HTTP_404_NOT_FOUND)

    def post(self, request, *args, **kwargs):
        id = self.kwargs["id"]
        article = Article.objects.get(id=id)
        if (article):
            title = request.data.get('title')
            # print(title)
            # body = request.POST["body"]
            # category = request.POST["category"]
            # timestamp = datetime.datetime.now()
            article = Article.objects.get(id=id)
            article.title = title
            # article.body = body
            # article.category = category
            # article.timestamp = timestamp
            #article.save()
            data = {
                "title": request.data.get('title'),
                "body": request.data.get('body'),
                "category": request.data.get('category'),
                "user": request.user.id,
                "timestamp": datetime.datetime.now(),
                "nof_upvotes": article.nof_upvotes,
                "nof_downvotes": article.nof_downvotes
            }
            serializer = ArticleSerializer(article,data=data)
            if serializer.is_valid():
                serializer.save()
            return Response(data=serializer.data, status=status.HTTP_200_OK)
        else:
            return Response(data={"error": f"There is no such article with id: {id}"}, status=status.HTTP_404_NOT_FOUND)
"""
    def post(self, request, id):
        article = Article.objects.get(id=id)
        serializer = ArticleSerializer(article, data=request.data)
        print(serializer.data.get("title"))
        if(serializer.is_valid()):
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
"""