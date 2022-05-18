from post.models import Post
from rest_framework import serializers
class ratePostSerializer(serializers.ModelSerializer):

    class Meta:
        model = Post
        fields = ["nof_upvotes", "nof_downvotes"]