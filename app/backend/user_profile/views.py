from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from forum.serializers import PostSerializer
from articles.serializers import ArticleSerializer
from common.views import upload_to_s3, delete_from_s3

from backend.constants import UserType
from backend.models import CustomUser
from backend.models import MemberInfo
from backend.models import Member

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
def get_upvoted_articles(request):
    paginator = PageNumberPagination()
    paginator.max_page_size = 10
    paginator.page_size = request.GET.get('page_size', 10)
    paginator.page = request.GET.get('page', 1)

    upvoter = CustomUser.objects.get(id=request.user.id)

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

    result_page = paginator.paginate_queryset(articles, request)
    serializer = ArticleSerializer(result_page, many=True)
    return paginator.get_paginated_response(serializer.data)

@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_upvoted_posts(request):
    paginator = PageNumberPagination()
    paginator.max_page_size = 10
    paginator.page_size = request.GET.get('page_size', 10)
    paginator.page = request.GET.get('page', 1)
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



@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_personal_info(request):

    user = request.user
    personal_info = {}

    try:
        self_info = CustomUser.objects.get(user=user)
    except:
        return Response({'error': 'User not found'}, status=400)
    
    email = self_info.email
    personal_info['email'] = email
        
    date_of_birth = self_info.date_of_birth
    personal_info['date_of_birth'] = date_of_birth
        
    register_date = request.user.date_joined
    personal_info['register_date'] = register_date

    # Initialization of fields: (to return null values as "-1". Frontend will handle it.)
    personal_info['type'] =  "-1"
    personal_info['full_name'] = "-1"
    personal_info['specialization'] = "-1"
    personal_info['hospital_name'] = "-1"
    personal_info['verified'] = "-1"
    personal_info['document'] = "-1"
    personal_info['profile_picture'] = "-1"
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
        personal_info['specialization'] = specialization
        personal_info['hospital_name'] = hospital_name
        personal_info['verified'] = verified
        personal_info['document'] = document
        personal_info['profile_picture'] = profile_picture
        

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
        age = member_info.age
        avatar = member_info.avatar
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
        personal_info['avatar'] = avatar
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
        self_info = CustomUser.objects.get(user=user)
    except:
        return Response({'error': 'User not found'}, status=400)

    personal_info = {}

    email = data['email']
    self_info.email = email

    date_of_birth = data['date_of_birth']
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
    personal_info['profile_picture'] = "-1"
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

        full_name = data['full_name']
        doctor.full_name = full_name

        specialization = data['specialization']
        doctor.specialization = specialization

        hospital_name = data['hospital_name']
        doctor.hospital_name = hospital_name

        verified = data['verified']
        doctor.verified = verified

        document = data['document']
        doctor.document = document

        profile_picture = data['profile_picture']
        doctor.profile_picture = profile_picture

        doctor.save()

        personal_info['full_name'] = full_name
        personal_info['specialization'] = specialization
        personal_info['hospital_name'] = hospital_name
        personal_info['verified'] = verified
        personal_info['document'] = document
        personal_info['profile_picture'] = profile_picture

    elif int(user.type) == UserType.MEMBER.value:
        
        try:
            member = Member.objects.get(user=user)
        except:
            return Response({'error': 'User not found'}, status=400)

        personal_info['type'] =  2
        member_info = member.info

        member_username = data['member_username']
        member.member_username = member_username

        firstname = data['firstname']
        member_info.firstname = firstname

        lastname = data['lastname']
        member_info.lastname = lastname

        address = data['address']
        member_info.address = address

        weight = data['weight']
        member_info.weight = weight

        height = data['height']
        member_info.height = height

        age = data['age']
        member_info.age = age

        avatar = data['avatar']
        member_info.avatar = avatar

        past_illnesses = data['past_illnesses']
        member_info.past_illnesses = past_illnesses

        allergies = data['allergies']
        member_info.allergies = allergies

        chronic_diseases = data['chronic_diseases']
        member_info.chronic_diseases = chronic_diseases

        undergone_operations = data['undergone_operations']
        member_info.undergone_operations =undergone_operations

        used_drugs = data['used_drugs']
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
        personal_info['avatar'] = avatar
        personal_info['past_illnesses'] = past_illnesses
        personal_info['allergies'] = allergies
        personal_info['chronic_diseases'] = chronic_diseases
        personal_info['undergone_operations'] = undergone_operations
        personal_info['used_drugs'] = used_drugs


    return Response(personal_info, status=200)


    
@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_doctor_profile(request, id):
    # user = request.user  # Maybe we will use this in search history.
    data = request.data
    try:
        doctor = Doctor.objects.get(id = id)
    except:
        return Response({'error': 'Doctor not found'}, status=400)

    personal_info = {}

    full_name = doctor.full_name
    specialization = doctor.specialization
    hospital_name = doctor.hospital_name
    profile_picture = doctor.profile_picture

    personal_info['full_name'] = full_name
    personal_info['specialization'] = specialization
    personal_info['hospital_name'] = hospital_name
    personal_info['profile_picture'] = profile_picture
    # to get posts and articles of a doctor, one should use get_posts_of_user and get_articles_of_doctor endpoints.
    return Response(personal_info, status=200)