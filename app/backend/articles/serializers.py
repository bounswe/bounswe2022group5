from articles.models import Article
from datetime import datetime
from rest_framework import serializers


class ArticleSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Article
        fields = '__all__'
    def create(self, validated_data):
        validated_data['date'] = datetime.now()
        
        return Article.objects.create(**validated_data)

class CreateArticleSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Article
        fields = ['title', 'body']