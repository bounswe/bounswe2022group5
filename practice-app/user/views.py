
from django.urls import resolve,reverse
from distutils.log import error
from django.shortcuts import redirect
from django.shortcuts import render
# Create your views here.
from django.contrib.auth.models import User
from rest_framework.views import APIView
from .serializers import * 
from rest_framework import generics,status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from email_validator import validate_email, EmailNotValidError
from rest_framework.renderers import TemplateHTMLRenderer
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import get_object_or_404
from dotenv import load_dotenv
import requests
import os
load_dotenv()
BASE_URL = "http://localhost:8000"
EXTERNAL_API_HOST = "mailcheck.p.rapidapi.com"
MAIL_DOMAIN_VALIDATE_API_KEY= os.getenv('MAIL_DOMAIN_VALIDATE_API_KEY')

class UserList(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    def get(self,request):
        queryset = User.objects.all()
        data = []
        for i in queryset:
            serialized = UserSerializer(i)
            data.append(serialized.data)
        
        return Response(data=data)
    def post(self,req):
        
        usernames = User.objects.values_list('username', flat=True)
        emails = User.objects.values_list('email',flat=True)
        if req.data["username"]=="":
            return Response(data={"message":"Invalid Data"},status=status.HTTP_400_BAD_REQUEST)
        if req.data["email"]=="":
            return Response(data={"message":"Invalid Data"},status=status.HTTP_400_BAD_REQUEST)
        if req.data["password"]=="":
            return Response(data={"message":"Invalid Data"},status=status.HTTP_400_BAD_REQUEST)
        if req.data["username"] in usernames:
            return Response(data={"message":"Username is taken!"},status=status.HTTP_409_CONFLICT)
        if req.data["email"] in emails:
            return Response(data={"message":"Email is already used!"},status=status.HTTP_409_CONFLICT)
        if(len(req.data["username"])<6):
            return Response(data={"message":"Username is too short!"},status=status.HTTP_400_BAD_REQUEST)
        if(len(req.data["password"])<6):
            return Response(data={"message":"Password is too short!"},status=status.HTTP_400_BAD_REQUEST)
        try:
            email = validate_email(req.data["email"]).email
        except EmailNotValidError as e:
            # email is not valid, exception message is human-readable
            error=str(e)
            return Response(data={"message":error},status=status.HTTP_400_BAD_REQUEST)
        
        import requests

        url = "https://mailcheck.p.rapidapi.com/"

        querystring = {"domain":req.data["email"].split("@")[1]}

        headers = {
            "X-RapidAPI-Host": EXTERNAL_API_HOST,
            "X-RapidAPI-Key": MAIL_DOMAIN_VALIDATE_API_KEY
        }
        try:
            response = requests.request("GET", url, headers=headers, params=querystring)
            isValid = response.json()["valid"]
            explanation = response.json()["text"]
            print(response.json())
            if(isValid==False or explanation=="Should be blocked"): 
                return Response(data={"message":f"Email domain is not valid! {explanation}!"},status=status.HTTP_400_BAD_REQUEST)
        except:
            print("external api problem")

        ##IMPORTANT

        try:
            user = User.objects.create_user(username=req.data['username'],
                                    email=req.data['email'],
                                    password=req.data['password'])
        except:
            return Response(data={"message":"User can not be created"},status=status.HTTP_500_INTERNAL_SERVER_ERROR)
            
        
        data = {
            "username":user.username,
            "email":user.email,
            "password": user.password
        }
        return Response(data=data,status=status.HTTP_201_CREATED)
class userDetail(APIView):

    def get(self, *args, **kwargs):
        username=self.kwargs["username"]
        queryset = User.objects.filter(username=username)

        if(queryset):
            serializedObject = UserSerializer(queryset[0])
            return Response(data=serializedObject.data,status=status.HTTP_200_OK)
        else:
            return Response(data={"message" : f"There is no such User with id: {id}"}, status = status.HTTP_404_NOT_FOUND)

def userView(request):
    isFailed=request.GET.get("fail",False)
    isSuccess=request.GET.get("success",False)
    errorMessage = request.GET.get("error","No Error")
    return render(request,"user.html",{"action_fail":isFailed,"action_success":isSuccess,"error_message":errorMessage})

def allUsers(req):
    ##calling api inside the server
    response = UserList.as_view()(request=req).data
    array = []
    for i in response:
        object=[]
        object.append(i["username"])
        object.append(i["email"])

        array.append(object)
    print(array)
    return render(req,"allUsers.html",{'profiles':array})

def createUser(req):
    data = {'username': req.POST["username"],
    'email': req.POST["email"],
    'password': req.POST["password"]}
    urltoUse = BASE_URL+reverse('api')
    x = requests.post(urltoUse, data = data)
    print(x)
    userURL=BASE_URL + reverse('userMain')
    if(x.status_code==201):
        
        return HttpResponseRedirect(f"{userURL}?success=true")
    else:
        message = x.json()['message']
        return HttpResponseRedirect(f"{userURL}?fail=true&error={message}")