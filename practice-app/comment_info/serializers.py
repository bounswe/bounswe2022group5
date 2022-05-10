from comment.models import Comment
from rest_framework import serializers
class commentInfoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Comment
        fields = "__all__"