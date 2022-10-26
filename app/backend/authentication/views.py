from django.shortcuts import render
from backend.models import CustomUser
from .serializers import UserSerializer
from django.contrib.auth import get_user_model
from rest_framework import viewsets

# Create your views here.
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework import status
from rest_framework.authentication import TokenAuthentication
from rest_framework import generics

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
