from forum.models import Post, Comment
from datetime import datetime
from rest_framework import serializers
from rest_framework.validators import UniqueValidator


class PostSerializer(serializers.ModelSerializer):

    class Meta:
        model = Post
        fields = '__all__'
    def create(self, validated_data):
        validated_data['date'] = datetime.now()
        
        return Post.objects.create(**validated_data)


class UpdatePostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = 'title', 'body', 'longitude', 'latitude'

    def create(self, validated_data):
        return Post.objects.create(**validated_data)


class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = '__all__'

    def create(self, validated_data):
        validated_data['date'] = datetime.now()

        return Comment.objects.create(**validated_data)

class CreateCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields =  'author', 'body', 'date', 'longitude', 'latitude', 'post'

    def create(self, validated_data):

        return Comment.objects.create(**validated_data)


    