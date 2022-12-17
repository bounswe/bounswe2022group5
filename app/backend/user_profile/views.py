import os

from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response

from forum.serializers import PostSerializer
from articles.serializers import ArticleSerializer
from common.views import upload_to_s3, delete_from_s3

from backend.constants import UserType
from backend.models import CustomUser, Category
from backend.models import MemberInfo
from backend.models import Member

from backend.constants import UserType
from forum.models import Post
from articles.models import Article
from backend.models import Doctor
from rest_framework.pagination import PageNumberPagination
import math
from datetime import datetime

PROFILE_PICTURE_FILE_NAME = "pp/{user_id}.jpg"

# Create your views here.
@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def upload_profile_picture(request):

    user = request.user
    if int(user.type) != UserType.DOCTOR.value:
        return Response('Only doctors can upload a profile picture', status=403)
    image_url = ""

    for filename, file in request.FILES.items():
        image = file.read()
        photo_url = upload_to_s3(image, f'pp/{user.id}.jpg')
        doctor_obj = Doctor.objects.get(user=user)
        doctor_obj.profile_picture = photo_url
        doctor_obj.save()
        image_url = photo_url



    return Response({'profile_picture': image_url}, status=200)


@api_view(['POST', ])
@permission_classes([IsAuthenticated, ])
def set_avatar(request):
    user = request.user
    if int(user.type) != UserType.MEMBER.value:
        return Response('Only members can set an avatar', status=403)

    member = Member.objects.get(user=user)
    member.info.avatar = request.data["avatar"]

    member.info.save()

    return Response({'profile_picture': f"https://api.multiavatar.com/{member.info.avatar}.svg?apikey={os.getenv('AVATAR')}"}, status=200)

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
def get_upvoted_articles(request):
    paginator = PageNumberPagination()
    paginator.max_page_size = 10
    paginator.page_size = request.GET.get('page_size', 10)
    paginator.page = request.GET.get('page', 1)

    upvoter = request.user

    upvoted_articles = upvoter.upvoted_articles
    articles = Article.objects.filter(id__in=upvoted_articles)



    temp = request.GET.get('sort', 'desc')
    if temp == 'desc' or temp == 'asc':
        sort = temp
    else:
        sort = 'desc'

    if sort == 'asc':
        articles = articles.order_by('date')
    elif sort == 'desc':
        articles = articles.order_by('-date')

    articles_response = []
    for article in articles:
        serializer_data = ArticleSerializer(article).data
        serializer_data['vote'] = "upvote"
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
        serializer_data["author"] = author_data
        articles_response.append(serializer_data)

    result_page = paginator.paginate_queryset(articles_response, request)

    return paginator.get_paginated_response(result_page)

@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_upvoted_posts(request):
    paginator = PageNumberPagination()
    paginator.max_page_size = 10
    paginator.page_size = request.GET.get('page_size', 10)
    paginator.page = request.GET.get('page', 1)
    upvoter = request.user
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

    post_response = []
    for post in posts:
        serializer_data = PostSerializer(post).data
        serializer_data['vote'] = "upvote"
        author = post.author
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
        serializer_data["author"] = author_data
        post_response.append(serializer_data)

    result_page = paginator.paginate_queryset(post_response, request)

    return paginator.get_paginated_response(result_page)



@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_personal_info(request):

    user = request.user
    personal_info = {}
    try:
        self_info = CustomUser.objects.get(id=user.id)
    except:
        return Response({'error': 'User not found'}, status=400)
    
    email = self_info.email
    personal_info['id'] =self_info.id
    personal_info['email'] = email
    date_of_birth = self_info.date_of_birth
    personal_info['date_of_birth'] = date_of_birth
    
    now = datetime.now()

    year_now = int(now.strftime("%Y"))
    birth_year = int(date_of_birth.strftime("%Y"))
    age = year_now - birth_year

    register_date = request.user.date_joined.strftime("%y/%m/%d")
    personal_info['register_date'] = register_date

    # Initialization of fields: (to return null values as "-1". Frontend will handle it.)
    personal_info['type'] =  "-1"
    personal_info['full_name'] = "-1"
    personal_info['specialization'] = "-1"
    personal_info['hospital_name'] = "-1"
    personal_info['verified'] = "-1"
    personal_info['document'] = "-1"
    personal_info['profile_image'] = "-1"
    personal_info['member_username'] = "-1"
    personal_info['firstname'] = "-1"
    personal_info['lastname'] = "-1"
    personal_info['address'] = "-1"
    personal_info['weight'] = "-1"
    personal_info['height'] = "-1"
    personal_info['age'] = "-1"
    personal_info['avatar'] = "-1"
    personal_info['past_illnesses'] = "-1"
    personal_info['allergies'] = "-1"
    personal_info['chronic_diseases'] = "-1"
    personal_info['undergone_operations'] = "-1"
    personal_info['used_drugs'] =  "-1"


    if int(user.type) == UserType.DOCTOR.value:

        doctor = Doctor.objects.get(user=user) # or request.user ?
        personal_info['type'] =  1
        full_name = doctor.full_name
        specialization = doctor.specialization
        hospital_name = doctor.hospital_name
        verified = doctor.verified
        document = doctor.document
        profile_picture = doctor.profile_picture

        personal_info['full_name'] = full_name
        personal_info['specialization'] = specialization.name
        personal_info['hospital_name'] = hospital_name
        personal_info['verified'] = verified
        personal_info['document'] = document
        personal_info['profile_image'] = profile_picture
        

    elif int(user.type) == UserType.MEMBER.value:

        member = Member.objects.get(user=user) # or request.user ? or id=request.user.id
        personal_info['type'] =  2
        member_info = member.info
        # member_info_alternative = MemberInfo.objects.get(user=user) there is no primary key, so I used foreign key above.

        member_username = member.member_username
        firstname = member_info.firstname
        lastname = member_info.lastname
        address = member_info.address
        weight = member_info.weight
        height = member_info.height
        age = age  # we calculated it above.
        avatar =f"https://api.multiavatar.com/{member_info.avatar}.svg?apikey={os.getenv('AVATAR')}"
        past_illnesses = member_info.past_illnesses
        allergies = member_info.allergies
        chronic_diseases = member_info.chronic_diseases
        undergone_operations = member_info.undergone_operations
        used_drugs = member_info.used_drugs

        personal_info['member_username'] = member_username
        personal_info['firstname'] = firstname
        personal_info['lastname'] = lastname
        personal_info['address'] = address
        personal_info['weight'] = weight
        personal_info['height'] = height
        personal_info['age'] = age
        personal_info['profile_image'] = avatar
        personal_info['past_illnesses'] = past_illnesses
        personal_info['allergies'] = allergies
        personal_info['chronic_diseases'] = chronic_diseases
        personal_info['undergone_operations'] = undergone_operations
        personal_info['used_drugs'] = used_drugs
    
    return Response(personal_info, status=200)
    

@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def update_personal_info(request):
    
    user = request.user
    data = request.data
    try:
        self_info = CustomUser.objects.get(id=user.id)
    except:
        return Response({'error': 'User not found'}, status=400)

    personal_info = {}
    if 'email' in data:
        email = data['email']
    else:
        email = self_info.email

    self_info.email = email

    if 'date_of_birth' in data:
        date_of_birth = data['date_of_birth']

        now = datetime.now()
        year_now = int(now.strftime("%Y"))
        birth_year = int(date_of_birth.strftime("%Y"))
        age = year_now - birth_year

    else:
        date_of_birth = self_info.date_of_birth

    self_info.date_of_birth = date_of_birth
    
    personal_info['email'] = email
    personal_info['date_of_birth'] = date_of_birth
    
    self_info.save()
    
    # Initialization of fields: (to return null values as "-1". Frontend will handle it.)
    personal_info['type'] =  "-1"
    personal_info['full_name'] = "-1"
    personal_info['specialization'] = "-1"
    personal_info['hospital_name'] = "-1"
    personal_info['verified'] = "-1"
    personal_info['document'] = "-1"
    personal_info['profile_image'] = "-1"
    personal_info['member_username'] = "-1"
    personal_info['firstname'] = "-1"
    personal_info['lastname'] = "-1"
    personal_info['address'] = "-1"
    personal_info['weight'] = "-1"
    personal_info['height'] = "-1"
    personal_info['age'] = "-1"
    personal_info['avatar'] = "-1"
    personal_info['past_illnesses'] = "-1"
    personal_info['allergies'] = "-1"
    personal_info['chronic_diseases'] = "-1"
    personal_info['undergone_operations'] = "-1"
    personal_info['used_drugs'] =  "-1"

    if int(user.type) == UserType.DOCTOR.value:

        try:
            doctor = Doctor.objects.get(user=user) # or request.user ?
        except:
            return Response({'error': 'User not found'}, status=400)

        personal_info['type'] =  1

        if 'full_name' in data:
            full_name = data['full_name']
        else:
            full_name = doctor.full_name

        doctor.full_name = full_name



        if 'hospital_name' in data:
            hospital_name = data['hospital_name']
        else:
            hospital_name = doctor.hospital_name

        doctor.hospital_name = hospital_name

        verified = doctor.verified

        document = doctor.document


        profile_picture = doctor.profile_picture

        doctor.save()

        personal_info['full_name'] = full_name
        personal_info['specialization'] = doctor.specialization.name
        personal_info['hospital_name'] = hospital_name
        personal_info['verified'] = verified
        personal_info['document'] = document
        personal_info['profile_image'] = profile_picture

    elif int(user.type) == UserType.MEMBER.value:
        
        try:
            member = Member.objects.get(user=user)
        except:
            return Response({'error': 'User not found'}, status=400)

        personal_info['type'] =  2
        personal_info['id'] = user.id
        member_info = member.info

        if 'member_username' in data:
            member_username = data['member_username']
        else:
            member_username = member.member_username

        member.member_username = member_username

        if 'firstname' in data:
            firstname = data['firstname']
        else:
            firstname = member_info.firstname

        member_info.firstname = firstname

        if 'lastname' in data:
            lastname = data['lastname']
        else:
            lastname = member_info.lastname
        member_info.lastname = lastname

        if 'address' in data:
            address = data['address']
        else:
            address = member_info.address
        member_info.address = address

        if 'weight' in data:
            weight = data['weight']
        else:
            weight = member_info.weight

        member_info.weight = weight

        if 'height' in data:
            height = data['height']
        else:
            height = member_info.height

        member_info.height = height

        if 'date_of_birth' in data:
            member_info.age = age
        else:  # if birtday is not changed
            age = member_info.age
        member_info.age = age


        if 'past_illnesses' in data:
            past_illnesses = data['past_illnesses']
        else:
            past_illnesses = member_info.past_illnesses
        member_info.past_illnesses = past_illnesses

        if 'allergies' in data:
            allergies = data['allergies']
        else:
            allergies = member_info.allergies

        member_info.allergies = allergies

        if 'chronic_diseases' in data:
            chronic_diseases = data['chronic_diseases']
        else:
            chronic_diseases = member_info.chronic_diseases
        member_info.chronic_diseases = chronic_diseases

        if 'undergone_operations' in data:
            undergone_operations = data['undergone_operations']
        else:
            undergone_operations = member_info.undergone_operations
        member_info.undergone_operations =undergone_operations

        if 'used_drugs' in data:
            used_drugs = data['used_drugs']
        else:
            used_drugs = member_info.used_drugs
        member_info.used_drugs = used_drugs

        member.save()
        member_info.save()

        personal_info['member_username'] = member_username
        personal_info['firstname'] = firstname
        personal_info['lastname'] = lastname
        personal_info['address'] = address
        personal_info['weight'] = weight
        personal_info['height'] = height
        personal_info['age'] = age
        personal_info['avatar'] = member_info.avatar
        personal_info['past_illnesses'] = past_illnesses
        personal_info['allergies'] = allergies
        personal_info['chronic_diseases'] = chronic_diseases
        personal_info['undergone_operations'] = undergone_operations
        personal_info['used_drugs'] = used_drugs


    return Response(personal_info, status=200)


    
@api_view(['GET',])
@permission_classes([AllowAny])
def get_doctor_profile(request, id):
    # user = request.user  # Maybe we will use this in search history.
    user = CustomUser.objects.get(id=id)
    try:
        doctor = Doctor.objects.get(user = user)
    except:
        return Response({'error': 'Doctor not found'}, status=400)

    personal_info = {}
    full_name = doctor.full_name
    specialization = doctor.specialization.name
    hospital_name = doctor.hospital_name
    profile_picture = doctor.profile_picture

    personal_info['full_name'] = full_name
    personal_info['specialization'] = specialization
    personal_info['hospital_name'] = hospital_name
    personal_info['profile_picture'] = profile_picture
    # to get posts and articles of a doctor, one should use get_posts_of_user and get_articles_of_doctor endpoints.
    return Response(personal_info, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated, ])
def follow_category(request, id):
        try:
            category = Category.objects.get(id=id)
            user_info = request.user
        except:
            return Response({'error': 'Category not found'}, status=400)

        if id in user_info.followed_categories :
            user_info.followed_categories.remove(id)
            user_info.save()
            return Response({'response':'Category unfollowed successfully'}, status=200)
        else:
            user_info.followed_categories.append(id)
            user_info.save()
            return Response({'response':'Category followed successfully'}, status=200)