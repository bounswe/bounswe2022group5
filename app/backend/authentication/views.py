from backend.models import CustomUser
from .serializers import UserSerializer, RegistrationSerializer
from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError
from django.db import IntegrityError
from django.contrib.auth import login, logout
from django.contrib.auth.hashers import check_password
from rest_framework import viewsets

# Create your views here.
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.decorators import api_view, permission_classes
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
        data = {}
        serializer = RegistrationSerializer(data=request.data)
        if serializer.is_valid():
            account = serializer.save()
            account.is_active = True
            account.save()
            token = Token.objects.get_or_create(user=account)[0].key
            data["message"] = "User registered successfully"
            data["email"] = account.email
            #data["username"] = account.username
            data["token"] = token

        else:
            data = serializer.errors
            return Response(status=400,data=data)

        return Response(status=200,data=data)
    except IntegrityError as e:
        
        raise ValidationError({"400": f'{str(e)}'})

    except KeyError as e:
        raise ValidationError({"400": f'Field {str(e)} missing'})

@api_view(["POST"])
@permission_classes([AllowAny])
def login_user(request):

        data = {}
        reqBody = json.loads(request.body)
        email1 = reqBody['email']
        password = reqBody['password']
        try:

            Account = User.objects.get(email=email1)
        except BaseException as e:
            raise ValidationError({"400": f'{str(e)}'})

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