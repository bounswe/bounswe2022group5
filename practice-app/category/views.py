from django.shortcuts import render
import requests
from .models import Category
from .serializers import CategorySerializer
from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .forms import *
from django.http import HttpResponseRedirect
from django.contrib import messages


class CategoryView(generics.ListAPIView):

    queryset = Category.objects.all()
    serializer_class = CategorySerializer

    def post(self, req):

        try:
            url = 'https://api.dictionaryapi.dev/api/v2/entries/en/' + req.data.get('name')
            r = requests.get(url)
            definition = r.json()[0]['meanings'][0]['definitions'][0]['definition']

        except:
            definition = req.data.get('definition')

        try:
            category = Category.objects.create(
                name = req.data.get('name'),
                definition = definition
            )
            response = { "name": category.name, "definition": category.definition }
            return Response(data=response, status=status.HTTP_201_CREATED)
        except:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


    def get(self, req):
        categories = Category.objects.all()
        response = [{ "name": category.name, "definition": category.definition } for category in categories]
        return Response(data=response, status=status.HTTP_200_OK)


# User Interface:
@api_view(['GET'])
def index(request):
    success = request.GET.get('success')
    if success == "True":
        messages.success(request, 'Category created successfully.')
    elif success == "False":
        messages.error(request, 'Category could not be created!')
    return render(request, "index_category.html")


@api_view(['GET'])
def getCategories(request):
    view = CategoryView()
    categories = view.get(req=request).data
    
    return render(
        request, 
        "listCategories_category.html", 
        {"categories": categories}
    )


@api_view(['GET', 'POST'])
def postCategory(request):
    if request.method == 'GET':
        postForm = categoriesPostForm()
        return render(request, "createForm_category.html", {"post_form":postForm})
    elif request.method == 'POST':
        view = CategoryView()
        response = view.post(req=request)
        return HttpResponseRedirect(f"..?success={response.status_code == 201}")
    