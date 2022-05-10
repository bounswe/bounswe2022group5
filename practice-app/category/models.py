from django.db import models

class Category(models.Model):
    name = models.CharField(max_length = 180, null = False)
    definition = models.CharField(max_length = 1800, null = False)

    def __str__(self):
        return self.name
