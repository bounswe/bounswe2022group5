from rest_framework import serializers
from .models import Article
class ArticleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Article
        fields = ["title", "body", "category", "user", "timestamp", 
        "nof_upvotes", "nof_downvotes"]