import os

from backend.models import CustomUser, Doctor, Member
from datetime import datetime

from django.db.models import Q
from rest_framework.response import Response
from rest_framework import status
from articles.serializers import ArticleSerializer, CreateArticleSerializer
from forum.serializers import LabelSerializer, CategorySerializer
from articles.models import Article, ArticleImages
from backend.models import Category, Label
from rest_framework.pagination import PageNumberPagination
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated, AllowAny

from common.views import upload_to_s3


# Create your views here.

@api_view(['GET',])
@permission_classes([AllowAny])
def get_all_articles(request):
    search_query = request.GET.get('q', None)
    search_query = search_query if search_query is None else search_query.split(" ")

    category = request.GET.get("c", None)
    paginator = PageNumberPagination()
    page_size = int(request.GET.get('page_size', 10))
    paginator.page_size = request.GET.get('page_size', 10)
    page = int(request.GET.get('page', 1))
    paginator.page = request.GET.get('page', 1)
    ##article_objects = Article.objects.all().order_by('-date')
    articles = []
    try:
        user = CustomUser.objects.get(email=request.user.email)
    except:
        user = None

    count = 0
    if category:
        category_object = Category.objects.get(name=category)
        article_objects = Article.objects.filter(category=category_object)[((page-1)*page_size):(page_size*page)]
        count = Article.objects.filter(category=category_object).count()
    if search_query:
        queryset_list1 = Q()

        for keyword in search_query:
            queryset_list1 |= (
                    Q(title__icontains=keyword) |
                    Q(body__icontains=keyword)
            )
            if category:
                article_objects = Article.objects.filter(category=category_object).filter(queryset_list1)[((page-1)*page_size):(page_size*page)]
                count = Article.objects.filter(category=category_object).filter(queryset_list1).count()
            else:
                article_objects = Article.objects.filter(queryset_list1).distinct().order_by('-date')[((page-1)*page_size):(page_size*page)]
                count = Article.objects.filter(queryset_list1).distinct().count()
    if (not category) and (not search_query):
        article_objects = Article.objects.all().order_by('-date')[((page-1)*page_size):(page_size*page)]
        count = Article.objects.count()

    authors = []
    if request.GET.get('q', None):

        search_query = request.GET.get('q', None)
        try:

            doctors = Doctor.objects.filter(full_name__icontains=search_query)

            for doctor in doctors:
                author = doctor.user
                authors.append(author)
        except:
            pass
        try:
            members = Member.objects.filter(member_username__icontains=search_query)

            for member in members:

                author = member.user
                authors.append(author)
        except:
            pass
    articles_by_user = Article.objects.filter(author__in=authors)

    for article in articles_by_user:
        serializer_article_data = ArticleSerializer(article).data
        if user:
            if article.id in user.upvoted_articles:
                serializer_article_data['vote'] = 'upvote'
            elif article.id in user.downvoted_articles:
                serializer_article_data['vote'] = 'downvote'
            else:
                serializer_article_data['vote'] = None
        else:
            serializer_article_data['vote'] = None
        serializer_article_data['id'] = article.id
        author = article.author
        if author.type == 1:
            try:
                doctor_data = Doctor.objects.get(user=author)
                author_data = {
                    'id': author.id,
                    'username': doctor_data.full_name,
                    'profile_photo': doctor_data.profile_picture,
                    'is_doctor': True
                }
            except:
                author_data = None

        elif author.type == 2:
            try:
                member_data = Member.objects.get(user=author)
                author_data = {
                    'id': author.id,
                    'username': member_data.member_username,
                    'profile_photo': f"https://api.multiavatar.com/{member_data.info.avatar}.svg?apikey={os.getenv('AVATAR')}",
                    'is_doctor': False
                }
            except:
                author_data = None
        serializer_article_data["author"] = author_data
        articles.append(serializer_article_data)
    for article in article_objects:
        serializer_article_data = ArticleSerializer(article).data
        if user:
            if article.id in user.upvoted_articles:
                serializer_article_data['vote'] = 'upvote'
            elif article.id in user.downvoted_articles:
                serializer_article_data['vote'] = 'downvote'
            else:
                serializer_article_data['vote'] = None

            if article.id in user.bookmarked_articles:
                serializer_article_data['bookmark'] = True
            else:
                serializer_article_data['bookmark'] = False
        else:
            serializer_article_data['vote'] = None
            serializer_article_data['bookmark'] = None

        serializer_article_data['id'] = article.id
        author = article.author
        if author.type == 1:
            try:
                doctor_data = Doctor.objects.get(user=author)
                author_data = {
                    'id': author.id,
                    'username': doctor_data.full_name,
                    'profile_photo': doctor_data.profile_picture,
                    'is_doctor': True
                }
            except:
                author_data = None

        elif author.type == 2:
            try:
                member_data = Member.objects.get(user=author)
                author_data = {
                    'id': author.id,
                    'username': member_data.member_username,
                    'profile_photo': f"https://api.multiavatar.com/{member_data.info.avatar}.svg?apikey={os.getenv('AVATAR')}",
                    'is_doctor': False
                }
            except:
                author_data = None
        serializer_article_data["author"] = author_data
        articles.append(serializer_article_data)
    #result_page = paginator.paginate_queryset(articles, request)
    #response = paginator.get_paginated_response(result_page)
    response = {}
    response["count"] = count
    response['next'] = None
    response['previous'] = None
    response['results'] = articles
    return Response(response, status=200)

@api_view(['GET',])
@permission_classes([AllowAny])
def get_articles_of_doctor(request, user_id):

    author = CustomUser.objects.get(id=user_id)

    paginator = PageNumberPagination()
    paginator.page_size = request.GET.get('page_size', 10)
    paginator.page = request.GET.get('page', 1)

    articles = Article.objects.filter(author=author)

    temp = request.GET.get('sort', 'desc')
    if temp == 'desc' or temp == 'asc':
        sort = temp
    else:
        sort = 'desc'

    if sort == 'asc':
        articles = articles.order_by('date')
    elif sort == 'desc':
        articles = articles.order_by('-date')

    response = []
    if request.user:
        user = request.user
        for article in articles:
            serializer_article_data = ArticleSerializer(article).data
            if article.id in user.upvoted_articles:
                serializer_article_data['vote'] = 'upvote'
            elif article.id in user.downvoted_articles:
                serializer_article_data['vote'] = 'downvote'
            else:
                serializer_article_data['vote'] = None

            if article.id in request.user.bookmarked_articles:
                serializer_article_data['bookmark'] = True
            else:
                serializer_article_data['bookmark'] = False

            serializer_article_data['id'] = article.id

            if author.type == 1:
                doctor_data = Doctor.objects.get(user=author)
                author_data = {
                    'id': author.id,
                    'username': doctor_data.full_name,
                    'profile_photo': doctor_data.profile_picture,
                    'is_doctor': True
                }

            elif author.type == 2:
                member_data = Member.objects.get(user=author)
                author_data = {
                    'id': author.id,
                    'username': member_data.member_username,
                    'profile_photo': f"https://api.multiavatar.com/{member_data.info.avatar}.svg?apikey={os.getenv('AVATAR')}",
                    'is_doctor': False
                }
            serializer_article_data['author'] = author_data
            response.append(serializer_article_data)
    else:
        for article in articles:
            serializer_article_data = ArticleSerializer(article).data
            serializer_article_data['vote'] = None
            serializer_article_data['id'] = article.id

            if author.type == 1:
                doctor_data = Doctor.objects.get(user=author)
                author_data = {
                    'id': author.id,
                    'username': doctor_data.full_name,
                    'profile_photo': doctor_data.profile_picture,
                    'is_doctor': True
                }

            elif author.type == 2:
                member_data = Member.objects.get(user=author)
                author_data = {
                    'id': author.id,
                    'username': member_data.member_username,
                    'profile_photo': f"https://api.multiavatar.com/{member_data.info.avatar}.svg?apikey={os.getenv('AVATAR')}",
                    'is_doctor': False
                }
            serializer_article_data['author'] = author_data

            response.append(serializer_article_data)

    result_page = paginator.paginate_queryset(response, request)

    return paginator.get_paginated_response(result_page)

@api_view(['GET', 'POST', 'DELETE'])
@permission_classes([AllowAny])
def article(request,id):
    if(request.method == 'GET'):
        try:
            article = Article.objects.get(id = id)
        except:
            return Response({'error': 'Article not found'}, status=400)
        article_serializer = ArticleSerializer(article)
        response_dict = article_serializer.data
        author = article.author
        article_images = ArticleImages.objects.filter(article=article)
        image_urls = [image.image_url for image in article_images]

        doctor_data = Doctor.objects.get(user=author)
        author_data = {
            'id': author.id,
            'username': doctor_data.full_name,
            'profile_photo': doctor_data.profile_picture,
            'is_doctor': True
        }
        response_dict["id"] = article.id
        response_dict["author"] = author_data

        try:
            user = CustomUser.objects.get(email = request.user.email)
        except:
            user = None
        if user:
            if article.id in request.user.upvoted_articles:
                response_dict['vote'] = 'upvote'
            elif article.id in request.user.downvoted_posts:
                response_dict['vote'] = 'downvote'
            else:
                response_dict['vote'] = None

            if article.id in request.user.bookmarked_articles:
                response_dict['bookmark'] = True
            else:
                response_dict['bookmark'] = False
        else:
            response_dict['vote'] = None
            response_dict['bookmark'] = None

        response = {
            'article': response_dict,
            'image_urls': image_urls,
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
            article_serializer["id"] = article.id
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
            'id': article.id,
            'title': title,
            'author': author,
            'body': body,
            'date': date,
        }


        image_urls = []
        if len(request.FILES) > 0:
            count = 1
            for filename, file in request.FILES.items():
                image = file.read()
                photo_url = upload_to_s3(image, f'article/{article.id}/{count}.jpg')
                count = count + 1
                commentImage = ArticleImages(image_url=photo_url, article=article)
                commentImage.save()
                image_urls.append(photo_url)
        serialized_data = ArticleSerializer(data).data
        if 'category' in request.data:
            try:
                category = request.data["category"]

                category = Category.objects.get(name=category)
                article.category = category
                article.save()
                category_serialized = CategorySerializer(category).data

                serialized_data['category'] = category_serialized
            except:
                pass

        if 'labels' in request.data:
            try:
                labels = request.data["labels"].split(",")
                l = []
                for label in labels:
                    label, valid = Label.objects.get_or_create(name=label)
                    article.labels.add(label)
                    article.save()
                    label_serialized = LabelSerializer(label).data
                    l.append(label_serialized)
                serialized_data['labels'] = l
            except:
                pass

        return Response({'article': serialized_data, 'image_urls': image_urls})
    else:
        data = validate_article.errors
        return Response(status=400,data={'error': f'Fields are missing'})


@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def upvote_article(request, id):
        try:
            article = Article.objects.get(id=id)
            user_info = request.user
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
            user_info = request.user
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

@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def bookmark_article(request, id):
        try:
            article = Article.objects.get(id=id)
            user_info = request.user
        except:
            return Response({'error': 'Article not found'}, status=400)

        if id in user_info.bookmarked_articles :
            user_info.bookmarked_articles.remove(id)
            user_info.save()
            return Response({'response': 'Bookmark removed successfully'}, status=200)
        else:
            user_info.bookmarked_articles.append(id)
            user_info.save()
            return Response({'response': 'Bookmark added successfully'}, status=200)