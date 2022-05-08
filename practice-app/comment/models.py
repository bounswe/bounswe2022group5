from django.db import models
from django.contrib.auth.models import User
from post.models import Post

class Comment(models.Model):
    body = models.CharField(max_length = 500)
    user = models.ForeignKey(User, on_delete = models.CASCADE, blank = True, null = True)
    post = models.ForeignKey(Post, on_delete = models.CASCADE, blank = False, null = False)
    timestamp = models.DateTimeField(auto_now_add = True, auto_now = False)
    city_name = models.CharField(max_length = 500, null=True)
    weather = models.CharField(max_length = 500, null=True)

    def __str__(self):
        return self.body
