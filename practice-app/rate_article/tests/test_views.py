from django.test import TestCase, Client
from django.urls import reverse
from django.contrib.auth.models import User
from article.models import Article
from category.models import Category
import json


class TestViews(TestCase):

    def setUp(self):
        self.client = Client()
        self.index_url = reverse('index1')
        self.get_url = reverse('getVoteApis')
        self.post_url = reverse('postVoteApis')

        self.category = Category.objects.create(
            name='category name',
            definition='category definition'
        )

        self.category2 = Category.objects.create(
            name='category name 2',
            definition='category definition 2'
        )

        self.user = User.objects.create(username='testuser')
        self.user.set_password('12345678')
        self.user.save()

        logged_in = self.client.login(username='testuser', password='12345678')

        article_info = {
            'title': 'article_title',
            'body': 'article_body',
            'category': self.category,
            'user': self.user,
            'nof_upvotes': 0,
            'nof_downvotes': 0
        }

        self.update_info = {
            'article_id': 1,
            'vote': "1"
        }

        self.article_ = Article.objects.create(**article_info)
        self.api_url = reverse('api', args=[1])

    def test_index_GET(self):
        response = self.client.get(self.index_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'forms_rate_article.html')

    def test_article_GET(self):
        response = self.client.get(self.get_url, {'article_id': 1})
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'view_rate_article.html')
        self.assertEquals(self.article_.title, 'article_title')
        self.assertEquals(self.article_.body, 'article_body')
        self.assertEquals(self.article_.category, self.category)

    def test_article_POST(self):
        response = self.client.post(self.post_url, self.update_info)
        article__ = Article.objects.get(id=1)
        self.assertEquals(response.status_code, 302)
        self.assertEquals(article__.nof_upvotes, 1)


