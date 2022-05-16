from rest_framework import serializers
from .models import Comment
class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = ["body", "user", "timestamp", "post", 
            "city_name", "weather", "nof_upvotes", "nof_downvotes"]