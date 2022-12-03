
from django.test import TestCase, Client
from django.contrib.auth.hashers import check_password
from rest_framework.authtoken.models import Token
from articles import models
from backend import models as backendModels
from tests.constants import *

from datetime import datetime

class ArticleTestCase(TestCase):
    def setUp(self) -> None:
        return super().setUp()
    def test_create_article_valid(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2)
        token = Token.objects.create(user=user)
        data = {'title':'test article title','body':'test article body'}
        response = client.post('/articles/article',data=data, content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["article"]["title"]), 'test article title')
        self.assertEqual(str(response.json()["article"]["author"]), str(user.id))
        self.assertEqual(response.status_code,200)
    def test_create_article_invalid(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2)
        token = Token.objects.create(user=user)
        data = {'title':'test article title'}
        response = client.post('/articles/article',data=data, content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Fields are missing')
        self.assertEqual(response.status_code,400)
    def test_get_article(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user, date = datetime.now())
        response = client.get(f'/articles/article/{article.id}',content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code,200)
    def test_get_article_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user, date = datetime.now())
        response = client.get(f'/articles/article/{article.id+1}',content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Article not found')
        self.assertEqual(response.status_code,400)
    def test_update_article_valid(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user, date = datetime.now())
        data = {'title':'test article title updated','body':'test article body updated'}
        response = client.post(f'/articles/article/{article.id}',data=data, content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["article"]["title"]), data['title'])
        self.assertEqual(str(response.json()["article"]["body"]), data['body'])
        self.assertEqual(str(response.json()["article"]["author"]), str(user.id))
        self.assertEqual(response.status_code,200)
    def test_update_article_missing_fields(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user, date = datetime.now())
        data = {'title':'test article title updated'}
        response = client.post(f'/articles/article/{article.id}',data=data, content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Fields are missing')
        self.assertEqual(response.status_code,400)
    def test_update_article_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user, date = datetime.now())
        data = {'title':'test article title updated','body':'test article body updated'}
        response = client.post(f'/articles/article/{article.id+1}',data=data, content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Article not found')
        self.assertEqual(response.status_code,400)
    def test_delete_article(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user, date = datetime.now())
        response = client.delete(f'/articles/article/{article.id}',content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code,200)
    def test_get_article_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user, date = datetime.now())
        response = client.delete(f'/articles/article/{article.id+1}',content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Article not found')
        self.assertEqual(response.status_code,400)
    def test_upvote_article(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user, date=datetime.now())
        # data = {}
        response = client.post(f'/articles/article/{article.id}/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)
    def test_upvote_article_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user,
                                                date=datetime.now())
        # data = {}
        response = client.post('/articles/article/999999/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Article not found')
        self.assertEqual(response.status_code,400)
    def test_upvote_article_when_already_exist(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user, date=datetime.now())
        response1 = client.post(f'/articles/article/{article.id}/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.post(f'/articles/article/{article.id}/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)
    def test_downvote_article(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user, date=datetime.now())
        # data = {}
        response = client.post(f'/articles/article/{article.id}/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)
    def test_downvote_article_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user, date=datetime.now())
        # data = {}
        response = client.post('/articles/article/999999/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Article not found')
        self.assertEqual(response.status_code,400)
    def test_downvote_article_when_already_exist(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        article = models.Article.objects.create(title='test article title', body='test article body', author=user, date=datetime.now())
        response1 = client.post(f'/articles/article/{article.id}/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.post(f'/articles/article/{article.id}/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)
    