from django.shortcuts import render
from rest_framework.decorators import permission_classes, api_view
from rest_framework.permissions import IsAuthenticated
import datetime

from annotation.models import TextAnnotation, ImageAnnotation
from rest_framework.response import Response
from urlextract import URLExtract

from annotation.annotation_schema import text_annotation_mapper, image_annotation_mapper


# Create your views here.
@api_view(['DELETE',])
@permission_classes([IsAuthenticated,])
def delete_text_annotation(request):
    annotation_id = request.data['id']
    annotation = TextAnnotation.objects.get(id=annotation_id)
    annotation.delete()
    return Response(status=200)

@api_view(['DELETE',])
@permission_classes([IsAuthenticated,])
def delete_image_annotation(request):
    annotation_id = request.data['id']
    annotation = ImageAnnotation.objects.get(id=annotation_id)
    annotation.delete()
    return Response(status=200)

@api_view(['DELETE',])
@permission_classes([IsAuthenticated,])
def delete_all_text_annotations(request, obj_id):
    source_type = request.GET.get('type')
    TextAnnotation.objects.filter(source_type=source_type).filter(source_id=obj_id).delete()
    return Response(status=200)

@api_view(['GET',])
@permission_classes([IsAuthenticated,])
def get_annotations(request, source_id):
    author = request.user
    source_type = request.GET.get('type')
    text_annotations = TextAnnotation.objects.filter(source_type=source_type).filter(source_id=source_id).filter(author = author or author.type == 1)
    text_annotations_response = []
    for text_annotation in text_annotations:
        text_annotations_response.append(text_annotation_mapper(text_annotation))

    image_annotations = ImageAnnotation.objects.filter(source_type=source_type).filter(source_id=source_id).filter(author=author or author.type == 1)
    image_annotations_response = []
    for image_annotation in image_annotations:
        image_annotations_response.append(image_annotation_mapper(image_annotation))

    data = {
        "text_annotations" : text_annotations_response,
        "image_annotations" : image_annotations_response
    }
    return Response(data, status=200)

@api_view(['POST','PUT'])
@permission_classes([IsAuthenticated,])
def create_text_annotation(request ,post_id):
    source_type = request.GET.get('type')
    author = request.user
    data = request.data

    body = data['body'][0]
    date_created = body['created']
    author_link = body['creator']['id']
    display_name = body['creator']['name']
    date_modified = body['modified']
    purpose = body['purpose']
    value = body['value']

    id = data['id']

    object = data['target']['selector']
    exact = object[0]['exact']
    start = object[1]['start']
    end = object[1]['end']

    text_annotation = TextAnnotation(
        id = id,
        source_type = source_type,
        source_id = post_id,
        author = author,
        author_link = author_link,
        display_name = display_name,
        value = value,
        date_created = date_created,
        date_modified = date_modified,
        purpose = purpose,
        exact = exact,
        start = start,
        end = end
    )
    text_annotation.save()

    return Response(text_annotation_mapper(text_annotation))


@api_view(['POST', 'PUT'])
@permission_classes([IsAuthenticated,])
def create_image_annotation(request ,post_id):
    source_type = request.GET.get('type')
    author = request.user
    data = request.data

    body = data['body'][0]
    date_created = body['created']
    author_link = body['creator']['id']
    display_name = body['creator']['name']
    date_modified = body['modified']
    purpose = body['purpose']
    value = body['value']

    id = data['id']

    object = data['target']['selector']
    pixels = object['value']
    photo_url = data['target']['source']

    image_annotation = ImageAnnotation(
        id = id,
        source_type = source_type,
        source_id = post_id,
        author = author,
        author_link = author_link,
        display_name = display_name,
        value = value,
        date_created = date_created,
        date_modified = date_modified,
        purpose = purpose,
        pixels = pixels,
        photo_url = photo_url
    )
    image_annotation.save()

    return Response(image_annotation_mapper(image_annotation))

