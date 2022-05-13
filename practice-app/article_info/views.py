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
        article = Article.objects.filter(id=id)
        if(article):
            serializer =ArticleSerializer(article)
            return Response(serializer.data,status=status.HTTP_200_OK)
        else:
            return Response(data = {"error": f"There is no such article with id: {id}"}, status=status.HTTP_404_NOT_FOUND)

    def post(self, request,id):

        article = Article.objects.filter(id=id)
        if (article):
            title = request.data.get('title')
            if not title:
                return Response(data={"error": f"Please insert a Title"},
                                status=status.HTTP_406_NOT_ACCEPTABLE)
            if (len(title) < 5):
                return Response(data={"error": f"Please insert a longer Title"},
                                status=status.HTTP_406_NOT_ACCEPTABLE)
            body = request.data.get('body')
            if not body:
                return Response(data={"error": f"Please insert a Body"},
                                status=status.HTTP_406_NOT_ACCEPTABLE)
            if (len(body) < 10):
                return Response(data={"error": f"Please insert a longer Body"},
                                status=status.HTTP_406_NOT_ACCEPTABLE)
            category = request.data.get('category')
            if not category:
                return Response(data={"error": f"Please Select a Category"},
                                status=status.HTTP_406_NOT_ACCEPTABLE)
            data = {
                "title": title,
                "body": body,
                "category": category,
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
