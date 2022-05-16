import django.db.models
from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from rest_framework.renderers import TemplateHTMLRenderer
from rest_framework.views import APIView
from rest_framework import permissions
from post.models import Post
from post.serializers import PostSerializer
import requests
from datetime import datetime
from django.db import models
import json
from django.utils.dateparse import parse_datetime
from .forms import *
# Create your views here.


def index(request):
    getForm = postGetForm()
    postForm = postPostForm()
    return render(request, "forms.html", {"getForm":getForm, "postForm":postForm})


class PostInfo(APIView):
    #renderer_classes = [TemplateHTMLRenderer]

    permission_classes = [permissions.IsAuthenticated]
    #template_name = 'PostInfo.html'
    model = Post
    context_object_name = 'post'

    def get_object(self, pk):
        try:
            return Post.objects.get(pk=pk)

        except:
            return None


    def get(self, request, pk,*args, **kwargs):
        post = self.get_object(pk)

        if not post:
            return Response(
                {"res": "Object with post id does not exists"},
                status=status.HTTP_400_BAD_REQUEST
            )

        serializer = PostSerializer(post)
        return Response(serializer.data, status=status.HTTP_200_OK)


    def post(self, request, pk,*args, **kwargs):
        post = self.get_object(pk)
        #serializer = PostSerializer(post, data=request.data)


        if not post:
            return Response(
                {"res": "Object with post id does not exists"},
                status=status.HTTP_400_BAD_REQUEST
            )

        country = request.data.get('country')

        try:
            result = requests.get(f"https://coronavirus.m.pipedream.net/").json()
            data = result["rawData"]
            output_dict = [x for x in data if x['Country_Region'] == country]
            output = output_dict[0]


            death = output['Deaths']
            case = output['Confirmed']

            covid19cases = {
                'death': death,
                'case': case
            }

        except:
            covid19cases = request.data.get('covid19cases')

        data = {
            'title': request.data.get('title'),
            'body': request.data.get('body'),
            'category': request.data.get('category'),
            'user': request.user.id,
            'timestamp': django.utils.timezone.now(),
            'country': request.data.get('country'),
            'covid19cases': covid19cases
        }


        serializer = PostSerializer(post, data=data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        #print("nooo")
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



@api_view(['GET', 'POST'])
def getPost(request):
    a = PostInfo()
    post_id = request.GET["post_id"]
    d = a.get(request=request, pk=post_id).data
    post = []
    posts = []
    for data in d:
        post.append(d[data])
    posts.append(post)
    return render(request, "view.html", {"posts":posts})

@api_view(['GET', 'POST'])
def postPost(request):
    a = PostInfo()
    post_id = request.POST["post_id"]
    a.post(request=request, pk=post_id)
    return HttpResponseRedirect("..?success=true")