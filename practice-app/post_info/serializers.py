from rest_framework import serializers
from post.models import Post
from django.contrib.auth.models import User
from category.models import Category

class PostSerializer(serializers.Serializer):
    title = serializers.CharField(null=False)
    body = serializers.CharField(null=False)
    category = serializers.ForeignKey(Category)
    user = serializers.ForeignKey(User, null=False)
    timestamp = serializers.DateTimeField
    country = serializers.CharField
    covid19case = serializers.IntegerField
    nof_upvotes = serializers.IntegerField(default=0)
    nof_downvotes = serializers.IntegerField(default=0)

    def create(self, validated_data):
        return Post.objects.create(validated_data)

    def update(self, instance, validated_data):
        instance.title = validated_data.get('title', instance.title)
        instance.body = validated_data.get('body', instance.body)
        instance.category = validated_data.get('category', instance.category)
        instance.user = validated_data.get('user', instance.user)
        instance.timestamp = validated_data.get('timestamp', instance.timestamp)
        instance.country = validated_data.get('country', instance.country)
        instance.covid19case = validated_data.get('covid19case', instance.covid19case)
        instance.nof_upvotes = validated_data.get('nof_upvotes', instance.nof_upvotes)
        instance.nof_downvotes = validated_data.get('nof_downvotes', instance.nof_downvotes)

        instance.save()
        return instance