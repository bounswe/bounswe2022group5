from backend.models import CustomUser, Label, Category
from django.db import models

# Create your models here.

class Article(models.Model):
    title = models.CharField(max_length=100, null=False)
    author = models.ForeignKey(CustomUser, null=False, on_delete=models.CASCADE)
    body = models.TextField(null=False)
    date = models.DateTimeField()
    upvote = models.IntegerField(null=False, default=0)
    downvote = models.IntegerField(null=False, default=0)
    labels = models.ManyToManyField(Label)
    category = models.ForeignKey(Category, on_delete=models.CASCADE, null=True, blank=True)

class ArticleImages(models.Model):
    image_url = models.CharField(max_length=100)
    article = models.ForeignKey(Article,on_delete=models.CASCADE)
