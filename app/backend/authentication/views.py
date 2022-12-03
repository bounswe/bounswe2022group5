import os

from backend.models import CustomUser, Doctor, Member, Category, MemberInfo
from .serializers import UserSerializer, RegistrationSerializer, DoctorSerializer, MemberSerializer
from django.contrib.auth import get_user_model
from django.contrib.auth import login, logout
from django.contrib.auth.hashers import check_password
from rest_framework import viewsets
from common.views import upload_to_s3, delete_from_s3
# Create your views here.
from rest_framework.views import APIView
from rest_framework.exceptions import ValidationError, ParseError
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework import status
from rest_framework.authentication import TokenAuthentication
from rest_framework import generics
from rest_framework.authtoken.models import Token
import json

User = get_user_model()

class HealthCheck(APIView):
    permission_classes = (IsAuthenticated,)
    def get(self, request):
        content = {'detail': 'Health Check!'}
        return Response(content, status=status.HTTP_400_BAD_REQUEST)


class UserViewSet(viewsets.ModelViewSet):
    authentication_classes = (TokenAuthentication,)
    permission_classes = (IsAuthenticated,)
    User = get_user_model()
    queryset = User.objects.all()
    serializer_class = UserSerializer


@api_view(["POST"])
@permission_classes([AllowAny])
def register_user(request):
    try:
        custom_data = {
            'email': request.data['email'],
            'password': request.data['password'],
            'type': request.data['type'],
            'date_of_birth': request.data['date_of_birth']
        }
        data = {}
        serializer = RegistrationSerializer(data=custom_data)
        if serializer.is_valid():
            account = serializer.save()
            account.is_active = True
            account.save()
            token = Token.objects.get_or_create(user=account)[0].key
            if(request.data['type']== '1'):

                doctor_data = {}
                full_name = f"{request.data['firstname']} {request.data['lastname']}"
                doctor_data['full_name'] =  full_name
                doctor_data['specialization']= Category.objects.get(name=request.data['branch']).id
                doctor_data['user'] = account.id
                doctor_serializer = DoctorSerializer(data=doctor_data)
                if doctor_serializer.is_valid():
                    doctor = doctor_serializer.save()
                    print(request.FILES)
                    if len(request.FILES) > 0:
                        for filename, file in request.FILES.items():
                            print(filename)
                            name, extension = os.path.splitext(file.name)
                            document = file.read()
                            document_url = upload_to_s3(document, f'document/{account.id}/{filename}{extension}')
                            doctor.document = document_url
                            doctor.save()
                else:
                    data = doctor_serializer.errors
                    account.delete()
                    return Response(status=400,data=data)
            elif(request.data['type'] == 2):
                member_data = {}
                
                member_data['user'] =  account.id
                member_data['member_username']= request.data['username']
                member_serializer = MemberSerializer(data=member_data)
                if member_serializer.is_valid():
                    try:
                        member_serializer.save()
                    except:
                        account.delete()
                        return Response(status=400, data={'username':['This field must be unique']})
                else:
                    account.delete()
                    data = member_serializer.errors
                    return Response(status=400,data=data)


            data["message"] = "User registered successfully"
            data["email"] = account.email
            #data["username"] = account.username
            data["token"] = token

        else:
            data = serializer.errors
            return Response(status=400,data=data)

        return Response(status=200,data=data)
    except ValidationError as e:
        
        raise ValidationError({"400": f'{str(e)}'})


@api_view(["POST"])
@permission_classes([AllowAny])
def login_user(request):

        data = {}
        reqBody = json.loads(request.body)
        email1 = reqBody['email']
        password = reqBody['password']
        
        if User.objects.filter(email = email1).exists():
            Account = User.objects.get(email=email1)
        else:
            raise ValidationError({"message":"Incorrect Login credentials"})
        

        token = Token.objects.get_or_create(user=Account)[0].key
        if not check_password(password, Account.password):
            raise ValidationError({"message": "Incorrect Login credentials"})

        if Account:
            if Account.is_active:
                login(request, Account)
                data["message"] = "user logged in"
                data["email"] = Account.email

                Res = {"data": data, "token": token}

                return Response(Res)

            else:
                raise ValidationError({"400": f'Account not active'})

        else:
            raise ValidationError({"400": f'Account doesnt exist'})

@api_view(["GET"])
@permission_classes([IsAuthenticated])
@authentication_classes([TokenAuthentication])
def logout_user(request):

    request.user.auth_token.delete()

    logout(request)

    return Response('User Logged out successfully')

@api_view(["GET"])
@permission_classes([IsAuthenticated])
def me(request):

    user = CustomUser.objects.get(email = request.user.email)
    serialized = UserSerializer(user)
    data = serialized.data
    if user.type == 1:
        doctor = Doctor.objects.get(user=user)
        profile_photo = doctor.profile_picture
        id = user.id
        username = doctor.full_name
    if user.type == 2:
        member = Member.objects.get(user=user)
        profile_photo = f'https://group5static.s3.amazonaws.com/member/{member.info.avatar}'
        id = user.id
        username = member.member_username

    data['profile_image'] = profile_photo
    data['id'] = id
    data['username'] = username

    return Response(status=200, data=serialized.data)