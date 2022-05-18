from django.test import TestCase, Client
from django.urls import reverse
from post.models import Post
from category.models import Category
from django.contrib.auth.models import User
import json


class TestViews(TestCase):

    def setUp(self):
        self.client = Client()
        self.index_url = reverse('index')
        self.get_url = reverse('getVoteApi')
        self.post_url = reverse('postVoteApi')

        covid19cases = {
            'death': 500,
            'case': 1000,
        }

        self.category = Category.objects.create(
            name='category name',
            definition='category definition'
        )

        self.category2 = Category.objects.create(
            name='category name 2',
            definition='category definition 2'
        )

        self.user = User.objects.create(username='testuser')
        self.user.set_password('12345')
        self.user.save()

        logged_in = self.client.login(username='testuser', password='12345')

        post_data = {
            'title': 'post_title',
            'body': 'post_body',
            'category': self.category,
            'user': self.user,
            'country': 'Turkey',
            'covid19cases': covid19cases,
            'nof_upvotes': 0,
            'nof_downvotes': 0
        }

        self.update_data = {
            'post_id': 1,
            'vote': "1"
        }

        self.post_ = Post.objects.create(**post_data)
        self.api_url = reverse('api', args=[1])

    def test_index_GET(self):
        response = self.client.get(self.index_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'forms_rate_post.html')

    def test_post_GET(self):
        response = self.client.get(self.get_url, {'post_id': 1})
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'view_rate_post.html')
        self.assertEquals(self.post_.title, 'post_title')
        self.assertEquals(self.post_.body, 'post_body')
        self.assertEquals(self.post_.category, self.category)
        self.assertEquals(self.post_.country, 'Turkey')


    def test_post_POST(self):
        response = self.client.post(self.post_url, self.update_data)
        post__ = Post.objects.get(id=1)
        self.assertEquals(response.status_code, 302)
        self.assertEquals(post__.nof_upvotes, 1)






