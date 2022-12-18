from .views import *
from django.urls import path, include

urlpatterns = [
    path('text/<int:post_id>', create_text_annotation, name='create_text_annotation'),
    path('text/delete', delete_text_annotation, name='delete_text_annotation'),
    path('image/<int:post_id>', create_image_annotation, name='create_image_annotation'),
    path('image/delete', delete_image_annotation, name='delete_image_annotation'),
    path('<int:source_id>', get_annotations, name='get_annotations'),
    path('delete/<int:obj_id>', delete_all_text_annotations, name='delete_all_text_annotations'),
]