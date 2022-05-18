import datetime

from django.shortcuts import render

# Create your views here.
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.views import APIView
from article.models import Article
from article.serializers import ArticleSerializer
from .forms import *


def index(request):
    getForm = articleGetForm()
    postForm = articlePostForm()
    return render(request, "forms_article_info.html", {"getForm":getForm, "postForm":postForm})

class ArticleInfo(APIView):

    def get(self,request,id):
        article = Article.objects.filter(id=id)
        if(article):
            serializer = ArticleSerializer(article[0])
            return Response(serializer.data,status=status.HTTP_200_OK)
        else:
            return Response(data={"error": f"There is no such article with id: {id}"}, status=status.HTTP_404_NOT_FOUND)

    def post(self, request,id):

        article = Article.objects.filter(id=id)
        if (article):
            article = Article.objects.get(id=id)
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
            category = request.data.get('category_id')
            if not category:
                return Response(data={"error": f"Please insert a Category ID"},
                                status=status.HTTP_406_NOT_ACCEPTABLE)
            data = {
                "title": title,
                "body": body,
                "category": category,
                "user": id,
                "timestamp": datetime.datetime.now(),
                "nof_upvotes": article.nof_upvotes,
                "nof_downvotes": article.nof_downvotes
            }
            serializer = ArticleSerializer(article,data=data)
            if serializer.is_valid():
                serializer.save()
                return Response(data=serializer.data, status=status.HTTP_200_OK)
            return Response(data=serializer.errors, status=status.HTTP_501_NOT_IMPLEMENTED)
        else:
            return Response(data={"error": f"There is no such article with id: {id}"}, status=status.HTTP_404_NOT_FOUND)

@api_view(['GET', 'POST'])
def getArticle(request):
    if not request.GET["article_id"]:
        return render(request, "error_article_info.html",
                      {"message": "Please Enter ID", "status_code": "404", "status_message": "Not Found"})
    a = ArticleInfo()
    article_id = request.GET["article_id"]
    d = a.get(request=request, id=article_id).data
    articleData = []
    for data in d:
        articleData.append(d[data])
    if("error" in d):
        status_code=a.get(request=request, id=article_id).status_code
        status_message=a.get(request=request, id=article_id).status_text
        return render(request, "error_article_info.html",{"message":d["error"],"status_code":status_code,"status_message":status_message})
    return render(request, "view_article_info.html", {"articles":articleData})

@api_view(['GET', 'POST'])
def postArticle(request):
    article_id = request.POST["article_id"]
    if not request.POST["article_id"]:
        return render(request, "error_article_info.html",
                      {"message": "Please Enter ID", "status_code": "404", "status_message": "Not Found"})
    a = ArticleInfo()
    d = a.post(request=request, id=article_id).data
    if ("error" in d):
        status_code = a.post(request=request, id=article_id).status_code
        status_message = a.post(request=request, id=article_id).status_text
        return render(request, "error_article_info.html",{"message": d["error"], "status_code": status_code, "status_message": status_message})
    articleData = []
    for data in d:
        articleData.append(d[data])
    return render(request, "updated_article_info.html", {"articles": articleData})