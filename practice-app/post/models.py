from django.db import models
from django.contrib.auth.models import User
from category.models import Category

class Post(models.Model):
    title = models.CharField(max_length = 180, blank = False, null = False)
    body = models.CharField(max_length = 1800, blank = False, null = False)
    category = models.ForeignKey(Category, on_delete = models.CASCADE, blank = True, null = False)
    user = models.ForeignKey(User, on_delete = models.CASCADE, blank = True, null = False)
    timestamp = models.DateTimeField(auto_now_add = True, auto_now = False)
    country = models.CharField(max_length = 180)
    covid19cases = models.JSONField(default=dict)
    #covid19cases = models.IntegerField(default = 0)
    nof_upvotes = models.IntegerField(default = 0)
    nof_downvotes = models.IntegerField(default = 0)

    def __str__(self):
        return self.title
