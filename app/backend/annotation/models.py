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
    source_type = models.CharField(max_length=50, choices=sources, null=False)
    source_id = models.IntegerField()
    author = models.ForeignKey(CustomUser, null=False, on_delete=models.CASCADE)
    body = models.TextField(null=False)
    date = models.DateTimeField()
    start = models.IntegerField(null=False, default=0)
    end = models.IntegerField(null=False, default=0)