from forum.models import Post
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


    