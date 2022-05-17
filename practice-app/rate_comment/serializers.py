from comment.models import Comment
from rest_framework import serializers
class RateCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = ["nof_upvotes", "nof_downvotes"]