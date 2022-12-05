from backend.models import CustomUser, Label, Category
from django.db import models

# Create your models here.

class Post(models.Model):
    title = models.CharField(max_length=100, null=False)
    author = models.ForeignKey(CustomUser, null=False, on_delete=models.CASCADE)
    body = models.TextField(null=False)
    date = models.DateTimeField()
    upvote = models.IntegerField(null=False, default=0)
    downvote = models.IntegerField(null=False, default=0)
    longitude = models.FloatField(default=0, null=True)
    latitude = models.FloatField(default=0, null=True)
    commented_by_doctor = models.BooleanField(default=False)
    labels = models.ManyToManyField(Label)
    category = models.ForeignKey(Category, on_delete=models.CASCADE, null=True, blank=True)

class PostImages(models.Model):
    image_url = models.CharField(max_length=100)
    post = models.ForeignKey(Post,on_delete=models.CASCADE)

class Comment(models.Model):
    author = models.ForeignKey(CustomUser, null=False, on_delete=models.CASCADE)
    body = models.TextField(null=False)
    date = models.DateTimeField()
    upvote = models.IntegerField(null=False, default=0)
    downvote = models.IntegerField(null=False, default=0)
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    longitude = models.FloatField(default=0, null=True)
    latitude = models.FloatField(default=0, null=True)

class CommentImages(models.Model):
    image_url = models.CharField(max_length=100)
    comment = models.ForeignKey(Comment, on_delete=models.CASCADE)