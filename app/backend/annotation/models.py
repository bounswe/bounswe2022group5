from django.contrib.postgres.fields import ArrayField
from django.db import models

from backend.models import CustomUser


# Create your models here.

class TextAnnotation(models.Model):
    POST = 'POST'
    ARTICLE = 'ARTICLE'
    sources = [
        (POST, 'POST'),
        (ARTICLE, 'ARTICLE'),
    ]
    id = models.CharField(max_length=100, null=False,primary_key=True)
    source_type = models.CharField(max_length=50, choices=sources, null=False)
    source_id = models.IntegerField()
    author = models.ForeignKey(CustomUser, null=False, on_delete=models.CASCADE)
    value = models.TextField(null=False, default='')
    date_created = models.DateTimeField()
    date_modified = models.DateTimeField
    purpose = models.CharField(max_length=100,null=False, default='')
    exact = models.TextField(null=False, default='')
    start = models.IntegerField(null=False, default=0)
    end = models.IntegerField(null=False, default=0)