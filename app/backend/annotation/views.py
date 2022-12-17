from django.shortcuts import render
from rest_framework.decorators import permission_classes, api_view
from rest_framework.permissions import IsAuthenticated
import datetime

from annotation.models import TextAnnotation
from urlextract import URLExtract

# Create your views here.

def _build_json_ld_text_annotation(objects):
    pass

@api_view(['POST',])
@permission_classes([IsAuthenticated,])
def get_text_annotations(request):
    author = request.user
    source_id = request.data['source_id']
    text_annotations = TextAnnotation.objects.filter(source_id=source_id).filter(author = author or author.type == 1)

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

