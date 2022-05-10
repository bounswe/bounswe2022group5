from rest_framework import serializers
from .models import Post
class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = ["title", "body", "category", "user", "timestamp", 
        "country", "covid19cases", "nof_upvotes", "nof_downvotes"]