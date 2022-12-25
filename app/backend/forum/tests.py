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
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        response = client.post(f'/forum/post/{post.id}/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)
    def test_upvote_post_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user,
                                                date=datetime.now())
        response = client.post('/forum/post/999999/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Post not found')
        self.assertEqual(response.status_code,400)
    def test_upvote_post_when_already_upvoted(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        response1 = client.post(f'/forum/post/{post.id}/upvote', content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.post(f'/forum/post/{post.id}/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)
    def test_downvote_post(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        response = client.post(f'/forum/post/{post.id}/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)
    def test_downvote_post_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user,
                                                date=datetime.now())
        response = client.post('/forum/post/999999/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Post not found')
        self.assertEqual(response.status_code,400)
    def test_downvote_post_when_already_downvoted(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        response1 = client.post(f'/forum/post/{post.id}/downvote', content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.post(f'/forum/post/{post.id}/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)

    def test_get_all_posts(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        response = client.post(f'/forum/posts', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)

    def test_get_all_posts_with_search_query(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='I need sleep', body='Body about sleep', author=user, date=datetime.now())
        response = client.post(f'/forum/posts?q=sleep', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)
    def test_get_all_posts_with_user_search(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        member_info = backendModels.MemberInfo.create()
        member = backendModels.Member.objects.create(user=user, member_username='test', info = member_info )

        post = models.Post.objects.create(title='I need sleep', body='Body about sleep', author=user, date=datetime.now())
        response = client.post(f'/forum/posts?q=test', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)

class CommentTestCase(TestCase):
    def setUp(self) -> None:
        return super().setUp()
    def test_upvote_comment(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        comment = models.Comment.objects.create(body='test post body', author=user, date=datetime.now(), post_id=post.id)
        response = client.post(f'/forum/post/comment/{comment.id}/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)
    def test_upvote_comment_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        comment = models.Comment.objects.create(body='test post body', author=user,
                                                date=datetime.now(), post_id=post.id)
        response = client.post('/forum/post/comment/999999/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Comment not found')
        self.assertEqual(response.status_code,400)
    def test_upvote_comment_when_already_exist(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        comment = models.Comment.objects.create(body='test post body', author=user, date=datetime.now(), post_id=post.id)
        response1 = client.post(f'/forum/post/comment/{comment.id}/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.post(f'/forum/post/comment/{comment.id}/upvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)
    def test_downvote_comment(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        comment = models.Comment.objects.create(body='test post body', author=user, date=datetime.now(), post_id=post.id)
        response = client.post(f'/forum/post/comment/{comment.id}/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)
    def test_downvote_comment_invalid_id(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        comment = models.Comment.objects.create(body='test post body', author=user,
                                                date=datetime.now(), post_id=post.id)
        response = client.post('/forum/post/comment/999999/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(str(response.json()["error"]), 'Comment not found')
        self.assertEqual(response.status_code,400)
    def test_downvote_comment_when_already_exist(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        comment = models.Comment.objects.create(body='test post body', author=user, date=datetime.now(), post_id=post.id)
        response1 = client.post(f'/forum/post/comment/{comment.id}/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.post(f'/forum/post/comment/{comment.id}/downvote', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)

    def test_bookmark_post(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user,
                                          date=datetime.now())
        response = client.post(f'/forum/post/{post.id}/bookmark', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)

    def test_bookmark_remove_post(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2)
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())
        response1 = client.post(f'/forum/post/{post.id}/bookmark', content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.post(f'/forum/post/{post.id}/bookmark', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)

