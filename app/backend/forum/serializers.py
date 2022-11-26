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


class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = '__all__'

    def create(self, validated_data):
        validated_data['date'] = datetime.now()

        return Comment.objects.create(**validated_data)


    