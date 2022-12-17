from django.shortcuts import render
from rest_framework.decorators import permission_classes, api_view
from rest_framework.permissions import IsAuthenticated
import datetime

from annotation.models import TextAnnotation
from rest_framework.response import Response
from urlextract import URLExtract

from annotation.annotation_schema import annotation_mapper


# Create your views here.

@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def get_text_annotations(request, source_id):
    author = request.user
    source_type = request.GET.get('type')
    text_annotations = TextAnnotation.objects.filter(source_type=source_type).filter(source_id=source_id).filter(author = author or author.type == 1)
    response = []
    for text_annotation in text_annotations:
        response.append(annotation_mapper(text_annotation))

    return Response(response, status=200)

@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def create_text_annotation(request):
    author = request.user
    data = request.data
    source_type = data['source_type']
    source_id = data['source_id']
    body = data['body']
    date = datetime.now()
    start = data['start']
    end = data['end']

    extractor = URLExtract()
    urls = extractor.find_urls(body, only_unique=True,get_indices=False)

    text_annotation = TextAnnotation(
        source_type=source_type,
        source_id=source_id,
        author=author,
        body=body,
        date=date,
        start=start,
        end=end,
        urls = urls
    )
    text_annotation.save()

