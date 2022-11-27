from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from forum.serializers import PostSerializer
from articles.serializers import ArticleSerializer
from common.views import upload_to_s3, delete_from_s3

from backend.constants import UserType
from backend.models import CustomUser

from backend.constants import UserType
from forum.models import Post
from articles.models import Article
from backend.models import Doctor
from rest_framework.pagination import PageNumberPagination
import math

PROFILE_PICTURE_FILE_NAME = "pp/{user_id}.jpg"

# Create your views here.
@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def upload_profile_picture(request):

    user = request.user
    if int(user.type) != UserType.DOCTOR.value:
        return Response('Only doctors can upload a profile picture', status=403)

    file_name = PROFILE_PICTURE_FILE_NAME.format(user_id=str(user.id))
    
    img = request.data['img'].read()

    pp_url = upload_to_s3(img, file_name)

    doctor_obj = Doctor.objects.get(user=user)
    doctor_obj.profile_picture = file_name

    doctor_obj.save()

    return Response({'profile_picture_url': pp_url}, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def delete_profile_picture(request):
    
    user = request.user
    if int(user.type) != UserType.DOCTOR.value:
        return Response('Only doctors can upload / delete profile pictures', status=403)
    
    doctor_obj = Doctor.objects.get(user=user)
    file_name = doctor_obj.profile_picture

    delete_from_s3(file_name=file_name)

    doctor_obj.profile_picture=None
    doctor_obj.save()

    return Response('Profile picture successfully deleted.', status=200)

@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_upvoted_articles(request, user_id = None):

    if user_id != None:
        upvoter = CustomUser.objects.get(id=user_id)
    else:
        upvoter = CustomUser.objects.get(id=request.user.id)

    upvoted_articles = upvoter.upvoted_articles
    articles = Article.objects.filter(id__in=upvoted_articles)

    page_size = 10
    page_number = 0
    if 'page_number' in request.data:
        page_number = int(request.data['page_number'])

    # sort
    sort = 'desc'
    if 'sort' in request.data:
        temp = request.data['sort']
        if temp == 'desc' or temp == 'asc':
            sort = temp

    if sort == 'asc':
        articles = articles.order_by('date')
    elif sort == 'desc':
        articles = articles.order_by('-date')

    total = articles.count()
    start = page_number * page_size
    end = (page_number + 1) * page_size

    serializer = ArticleSerializer(articles[start:end], many=True)

    return Response({
        'data': serializer.data,
        'total': total,
        'page_number': page_number,
        'last_page': math.ceil(total / page_size) - 1
    })

@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_upvoted_posts(request):
    paginator = PageNumberPagination()
    paginator.max_page_size = 10
    paginator.page_size = request.GET.get('page_size', 10)
    paginator.page = request.GET.get('page_size', 1)
    upvoter = CustomUser.objects.get(id=request.user.id)
    upvoted_posts = upvoter.upvoted_posts

    posts = Post.objects.filter(id__in=upvoted_posts)



    temp = request.GET.get('sort', 'desc')
    if temp == 'desc' or temp == 'asc':
        sort = temp
    else:
        sort = 'desc'

    if sort == 'asc':
        posts = posts.order_by('date')
    elif sort == 'desc':
        posts = posts.order_by('-date')

    result_page = paginator.paginate_queryset(posts, request)
    serializer = PostSerializer(result_page, many=True)
    return paginator.get_paginated_response(serializer.data)
