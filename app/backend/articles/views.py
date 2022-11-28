from backend.models import CustomUser
from datetime import datetime
from rest_framework.response import Response
from rest_framework import status
from articles.serializers import ArticleSerializer, CreateArticleSerializer
from articles.models import Article, ArticleImages
from rest_framework.pagination import PageNumberPagination
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated

from common.views import upload_to_s3


# Create your views here.

@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_all_articles(request):
    paginator = PageNumberPagination()
    paginator.page_size = request.GET.get('page_size', 10)
    paginator.page = request.GET.get('page', 1)
    article_objects = Article.objects.all().order_by('-date')
    articles = []
    user = CustomUser.objects.get(id=request.user.id)
    for article in article_objects:
        serializer_article_data = ArticleSerializer(article).data
        if article.id in user.upvoted_articles:
            serializer_article_data['vote'] = 'upvote'
        elif article.id in user.downvoted_articles:
            serializer_article_data['vote'] = 'downvote'
        else:
            serializer_article_data['vote'] = None
        articles.append(serializer_article_data)
    result_page = paginator.paginate_queryset(articles, request)
    return paginator.get_paginated_response(result_page)


@api_view(['GET', 'POST', 'DELETE'])
@permission_classes([IsAuthenticated,])
def article(request,id):
    if(request.method == 'GET'):
        try:
            article = Article.objects.get(id = id)
        except:
            return Response({'error': 'Article not found'}, status=400)
        article_serializer = ArticleSerializer(article)
        article_images = ArticleImages.objects.filter(article=article)
        image_urls = [image.image_url for image in article_images]
        response ={
            'article': article_serializer.data,
            'image_urls': image_urls
        }
        return Response(response, status=200)

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

        article = Article(title=title, author=author, body=body, date=date)
        article.save()

        data = {
            'title': title,
            'author': author,
            'body': body,
            'date': date
        }
        image_urls = []
        if len(request.FILES) > 0:
            count = 1
            for filename, file in request.FILES.items():
                image = file.read()
                photo_url = upload_to_s3(image, f'article/{article.id}/{count}.jpg')
                count = count + 1
                commentImage = ArticleImages(image_url=photo_url, post=article)
                commentImage.save()
                image_urls.append(photo_url)
        serialized_data = ArticleSerializer(data)
        return Response({'article': serialized_data.data, 'image_urls': image_urls})
    else:
        data = validate_article.errors
        return Response(status=400,data={'error': f'Fields are missing'})


@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def upvote_article(request, id):
        try:
            article = Article.objects.get(id=id)
            user_info = CustomUser.objects.get(id = request.user.id)
        except:
            return Response({'error': 'Article not found'}, status=400)

        if id in user_info.upvoted_articles :
            article.upvote -= 1
            article.save()
            user_info.upvoted_articles.remove(id)
            user_info.save()
        elif id in user_info.downvoted_articles :
            article.downvote -= 1
            article.upvote += 1
            article.save()
            user_info.downvoted_articles.remove(id)
            user_info.upvoted_articles.append(id)
            user_info.save()
        else:
            article.upvote += 1
            article.save()
            user_info.upvoted_articles.append(id)
            user_info.save()

        article_serializer = ArticleSerializer(article)
        return Response({'article': article_serializer.data}, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def downvote_article(request, id):
        try:
            article = Article.objects.get(id=id)
            user_info = CustomUser.objects.get(id = request.user.id)
        except:
            return Response({'error': 'Article not found'}, status=400)

        if id in user_info.downvoted_articles :
            article.downvote -= 1
            article.save()
            user_info.downvoted_articles.remove(id)
            user_info.save()
        elif id in user_info.upvoted_articles :
            article.upvote -= 1
            article.downvote += 1
            article.save()
            user_info.upvoted_articles.remove(id)
            user_info.downvoted_articles.append(id)
            user_info.save()
        else:
            article.downvote += 1
            article.save()
            user_info.downvoted_articles.append(id)
            user_info.save()

        article_serializer = ArticleSerializer(article)
        return Response({'article': article_serializer.data}, status=200)

