from backend.models import CustomUser
from django.db import models

# Create your models here.

class Article(models.Model):
    title = models.CharField(max_length=100, null=False)
    author = models.ForeignKey(CustomUser, null=False, on_delete=models.CASCADE)
    body = models.TextField(null=False)
    date = models.DateTimeField()
    upvote = models.IntegerField(null=False, default=0)
    downvote = models.IntegerField(null=False, default=0)
