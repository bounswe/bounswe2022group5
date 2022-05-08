from django.shortcuts import render
# Create your views here.
from django.contrib.auth.models import User
from .serializers import * 
from rest_framework import generics,status
from rest_framework.response import Response
from rest_framework.decorators import api_view
class UserList(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def post(self,req):
        user = User.objects.create_user(username=req.POST['username'],
                                 email=req.POST['email'],
                                 password=req.POST['password'])
        data = {
            "username":user.username,
            "email":user.email,
            "password": user.password
        }
        return Response(data=data,status=status.HTTP_201_CREATED)

@api_view(['GET', 'POST'])
def userDetail(request):
    user = User.objects.get(username=request.GET.get('username', ''))
    data = {
            "username":user.username,
            "email":user.email,
            "password": user.password
        }
    if request.method == 'GET':
        return Response(data=data)
    return Response({"message": "Only GET Method Allowed"})