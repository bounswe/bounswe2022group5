from datetime import datetime
from rest_framework.response import Response
from rest_framework import status
from articles.serializers import ArticleSerializer, CreateArticleSerializer
from articles.models import Article
from rest_framework.pagination import PageNumberPagination
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
# Create your views here.

@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_all_articles(request):
    paginator = PageNumberPagination()
    paginator.page_size = 10
    article_objects = Article.objects.all()
    result_page = paginator.paginate_queryset(article_objects, request)
    serializer = ArticleSerializer(result_page, many=True)
    return paginator.get_paginated_response(serializer.data)

@api_view(['GET', 'POST', 'DELETE'])
@permission_classes([IsAuthenticated,])
def article(request,id):
    if(request.method == 'GET'):
        try:
            article = Article.objects.get(id = id)
        except:
            return Response({'error': 'Article not found'}, status=400)
        article_serializer = ArticleSerializer(article)
        
        return Response(article_serializer.data, status=200)

    if(request.method == 'DELETE'):
        try:
            article = Article.objects.get(id = id)
        except:
            return Response({'error': 'Article not found'}, status=400)
        
        article.delete()
        
        return Response(status=200)

    if(request.method == 'POST'):
        validate_article = CreateArticleSerializer(data=request.data)
        if validate_article.is_valid():
            try:
                article = Article.objects.get(id = id)
            except:
                return Response({'error': 'Article not found'}, status=400)
            data = request.data
            article.title = data['title']
            article.body = data['body']
            article.save()
            article_serializer = ArticleSerializer(article)
            
            return Response({'article':article_serializer.data}, status=200)
        else:
            data = validate_article.errors
            return Response(status=400,data={'error': f'Fields are missing'})

@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def create_article(request):
    validate_article = CreateArticleSerializer(data=request.data)
    if validate_article.is_valid():
        title = request.data['title']
        author = request.user
        body = request.data['body']
        date = datetime.now()

        post = Article(title=title, author=author, body=body, date=date)
        post.save()

        data = {
            'title':title,
            'author': author,
            'body':body,
            'date':date
        }
        
        serialized_data = ArticleSerializer(data)
        return Response({'article':serialized_data.data})
    else:
        data = validate_article.errors
        return Response(status=400,data={'error': f'Fields are missing'})


@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def upvote_an_article(request, id):
        try:
            article = Article.objects.get(id=id)
        except:
            return Response({'error': 'Article not found'}, status=400)
        article.upvote += 1
        article.save()
        article_serializer = ArticleSerializer(article)

        return Response({'article': article_serializer.data}, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def downvote_an_article(request, id):
        try:
            article = Article.objects.get(id=id)
        except:
            return Response({'error': 'Article not found'}, status=400)
        article.downvote += 1
        article.save()
        article_serializer = ArticleSerializer(article)

        return Response({'article': article_serializer.data}, status=200)

