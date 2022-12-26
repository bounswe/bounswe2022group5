from django.test import TestCase, Client
from rest_framework.authtoken.models import Token
from forum import models
from articles import models as amodels
from backend import models as backendModels
from tests.constants import *
from datetime import datetime

class UserProfileTestCase(TestCase):
    def setUp(self) -> None:
        return super().setUp()
    def test_get_personal_info(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        response = client.get(f'/profile/get_personal_info',content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code,200)
    def test_get_doctor_profile(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        category = backendModels.Category.objects.create(name="specialization profile test", definition="definiton profile test")
        doctor = backendModels.Doctor.objects.create(user=user,full_name="Joe Doe",hospital_name="hospital test name",verified = True,specialization=category, profile_picture="test profile picture url")
        response = client.get(f'/profile/get_doctor_profile/{doctor.id}',content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code,200)
    def test_follow_category(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        category = backendModels.Category.objects.create(name="Category 1",
                                                         definition="Definition 1")
        response = client.post(f'/profile/follow_category/{category.id}', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 200)

    def test_unfollow_category(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        category = backendModels.Category.objects.create(name="Category 1",
                                                         definition="Definition 1")
        response1 = client.post(f'/profile/follow_category/{category.id}', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.post(f'/profile/follow_category/{category.id}', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)
    def test_follow_category_error(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        category = backendModels.Category.objects.create(name="Category 1",
                                                         definition="Definition 1")
        response = client.post(f'/profile/follow_category/99999', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response.status_code, 400)
    def test_get_followed_categories(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        category = backendModels.Category.objects.create(name="Category 1",
                                                         definition="Definition 1")
        response1 = client.post(f'/profile/follow_category/99999', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.get(f'/profile/followed_categories', content_type="application/json",
                                **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)
    def test_get_bookmarked_posts(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user, date=datetime.now())

        response1 = client.post(f'/forum/post/{post.id}/bookmark', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.get(f'/profile/bookmarked_posts', content_type="application/json",
                                **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)

    def test_get_upvoted_posts(self):
        client = Client
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        post = models.Post.objects.create(title='test post title', body='test post body', author=user,
                                          date=datetime.now())
        response1 = client.post(f'/forum/post/{post.id}/upvote', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.get(f'/profile/upvoted_posts?page=1&page_size=10&sort=desc&user_id={user.id}', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)

    def test_get_upvoted_articles(self):
        client = Client
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        article = amodels.Article.objects.create(title='test post title', body='test post body', author=user,
                                          date=datetime.now())
        response1 = client.post(f'/articles/articles/{article.id}/upvote', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.get(f'/profile/upvoted_articles?page=1&page_size=10&sort=desc&user_id={user.id}', content_type="application/json",
                               **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)

    def test_get_bookmarked_articles(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)
        article = amodels.Article.objects.create(title='test article title', body='test article body', author=user, date=datetime.now())

        response1 = client.post(f'/articles/article/{article.id}/bookmark', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        response2 = client.get(f'/profile/bookmarked_articles', content_type="application/json",
                                **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        self.assertEqual(response2.status_code, 200)

    def test_delete_an_account(self):
        client = Client()
        user = backendModels.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",
                                                            type=2, date_of_birth=datetime.now())
        token = Token.objects.create(user=user)

        response = client.delete(f'/profile/delete_account', content_type="application/json",
                              **{"HTTP_AUTHORIZATION": f"Token {token.key}"})

        self.assertEqual(response.status_code, 200)