from django.test import TestCase, Client
from django.contrib.auth.hashers import check_password
from rest_framework.authtoken.models import Token
from forum import models
from backend import models as backendModels
from tests.constants import *
from datetime import datetime

class PostTestCase(TestCase):
    def setUp(self) -> None:
        return super().setUp()
    def test_upvote_post(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        article = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        response = client.post(f'/forum/post/{article.id}/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)
    def test_upvote_post_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        article = models.Post.objects.create(title='test post title', body='test post body', author=user,
                                                date=datetime.now())
        response = client.post('/forum/post/999999/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Post not found')
        self.assertEqual(response.status_code,400)
    def test_downvote_post(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        article = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        response = client.post(f'/forum/post/{article.id}/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)
    def test_downvote_post_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        article = models.Post.objects.create(title='test post title', body='test post body', author=user,
                                                date=datetime.now())
        response = client.post('/forum/post/999999/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Post not found')
        self.assertEqual(response.status_code,400)


class CommentTestCase(TestCase):
    def setUp(self) -> None:
        return super().setUp()
    def test_upvote_comment(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        comment = models.Comment.objects.create(body='test post body', author=user, date=datetime.now())
        response = client.post(f'/forum/post/comment/{comment.id}/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)
    def test_upvote_comment_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        comment = models.Comment.objects.create(body='test post body', author=user,
                                                date=datetime.now())
        response = client.post('/forum/post/comment/999999/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Comment not found')
        self.assertEqual(response.status_code,400)
    def test_downvote_comment(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        comment = models.Comment.objects.create(body='test post body', author=user, date=datetime.now())
        response = client.post(f'/forum/post/comment/{comment.id}/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)
    def test_downvote_comment_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        comment = models.Comment.objects.create(body='test post body', author=user,
                                                date=datetime.now())
        response = client.post('/forum/post/comment/999999/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Post not found')
        self.assertEqual(response.status_code,400)