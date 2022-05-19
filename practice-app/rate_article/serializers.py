from article.models import Article
from rest_framework import serializers
class rateArticleSerializer(serializers.ModelSerializer):

    class Meta:
        model = Article
        fields = ["nof_upvotes", "nof_downvotes"]