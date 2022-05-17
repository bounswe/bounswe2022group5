from django.test import TestCase, Client
from django.urls import reverse
from article.models import Article
from category.models import Category
from django.contrib.auth.models import User
import json

class TestViews(TestCase):

    def setUp(self):
        self.client = Client()
        self.index_url = reverse('index_article_info')
        self.get_url = reverse('getArticle')
        self.post_url = reverse('postArticle')
        self.api_url = reverse('api_article_info', args=[1])

        self.category = Category.objects.create(
            name='category name',
            definition='category definition'
        )
        self.category2 = Category.objects.create(
            name='category name 2',
            definition='category definition 2'
        )

        self.user = User.objects.create(username='username')
        self.user.set_password('password')
        self.user.save()
        # logged_in = self.client.login(username='username', password ='password')

        article_data = {
            'title': 'article_title',
            'body': 'body',
            'category': self.category,
            'user': self.user,
            'nof_upvotes': 0,
            'nof_downvotes': 0
        }
        self.update_data ={
            'article_id': 1,
            'title': 'article_title_updated',
            'body': 'body_updated',
            'category_id': 2
        }

        self.article_ = Article.objects.create(**article_data)

    def test_index_GET(self):
        response = self.client.get(self.index_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'forms_article_info.html')

    def test_getArticle_GET(self):
        response = self.client.get(self.get_url, {'article_id':1})
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'view_article_info.html')
        self.assertEquals(self.article_.title, 'article_title')
        self.assertEquals(self.article_.body, 'body')
        self.assertEquals(self.article_.category, self.category)

    def test_getArticle_id_error(self):
        response = self.client.get(self.get_url, {'article_id': 2})
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'error_article_info.html')

    def test_postArticle_POST(self):
        response = self.client.post(self.post_url, self.update_data)
        article__ = Article.objects.get(id=1)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'updated_article_info.html')
        self.assertEquals(article__.title, 'article_title_updated')
        self.assertEquals(article__.body, 'body_updated')
        self.assertEquals(article__.category, self.category2)

    def test_postArticle_invalid_id_error(self):
        update_data={
            'article_id': 2, #invalid
            'title': 'Testing Title',
            'body': 'Testing Body',
            'category_id': 1
        }
        response = self.client.post(self.post_url, update_data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'error_article_info.html')

    def test_postArticle_no_title_error(self):
        self.update_data={
            'article_id': 1,
            # no title
            'body': 'Testing Body',
            'category_id': 1
        }
        response = self.client.post(self.post_url, self.update_data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'error_article_info.html')

    def test_postArticle_invalid_title_error(self):
        self.update_data={
            'article_id': 1,
            'title':'T', # len(title)<5
            'body': 'Testing Body',
            'category_id': 1
        }
        response = self.client.post(self.post_url, self.update_data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'error_article_info.html')

    def test_postArticle_invalid_body_error(self):
        self.update_data={
            'article_id': 1,
            'title': 'Testing Title',
            'body': 'Too short', # len(body)<10
            'category_id': 1
        }
        response = self.client.post(self.post_url, self.update_data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'error_article_info.html')

    def test_postArticle_no_body_error(self):
        self.update_data={
            'article_id': 1,
            'title': 'Testing Title',
            'category_id': 1
        }
        response = self.client.post(self.post_url, self.update_data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'error_article_info.html')

    def test_api_article_info_GET_success(self):
        api_url = reverse('api_article_info',args=[1])
        response = self.client.get(api_url)
        self.assertEquals(response.status_code, 200)

    def test_api_article_info_GET_failure(self):
        api_url = reverse('api_article_info', args=[2])
        response = self.client.get(api_url)
        self.assertEquals(response.status_code, 404)

    def test_api_article_info_POST_success(self):
        data={
            'title': 'Testing Title',
            'body': 'Testing Body',
            'category_id': 1
        }
        api_url = reverse('api_article_info', args=[1])
        response = self.client.post(api_url, data)
        self.assertEquals(response.status_code, 200)

    def test_api_article_info_POST_invalid_id_failure(self):
        data={
            'title': 'Testing Title',
            'body': 'Testing Body',
            'category_id': 1
        }
        api_url = reverse('api_article_info', args=[2])
        response = self.client.post(api_url, data)
        self.assertEquals(response.status_code, 404)

    def test_api_article_info_POST_no_title_failure(self):
        data={
            # no title
            'body': 'Testing Body',
            'category_id': 1
        }
        api_url = reverse('api_article_info', args=[1])
        response = self.client.post(api_url, data)
        self.assertEquals(response.status_code, 406)

    def test_api_article_info_POST_invalid_title_failure(self):
        data={
            'title': 'T',# len(title)<5
            'body': 'Testing Body',
            'category_id': 1
        }
        api_url = reverse('api_article_info', args=[1])
        response = self.client.post(api_url, data)
        self.assertEquals(response.status_code, 406)

    def test_api_article_info_POST_invalid_body_failure(self):
        data={
            'title': 'Testing Title',
            'body': 'Too short',#len(body)<10
            'category_id': 1
        }
        api_url = reverse('api_article_info', args=[1])
        response = self.client.post(api_url, data)
        self.assertEquals(response.status_code, 406)

    def test_api_article_info_POST_no_body_failure(self):
        data={
            'title': 'Testing Title',
            #no body
            'category_id': 1
        }
        api_url = reverse('api_article_info', args=[1])
        response = self.client.post(api_url, data)
        self.assertEquals(response.status_code, 406)

    def test_api_article_info_POST_no_category_failure(self):
        data={
            'title': 'Testing Title',
            'body': 'Testing Body'
        }
        api_url = reverse('api_article_info', args=[1])
        response = self.client.post(api_url, data)
        self.assertEquals(response.status_code, 406)





