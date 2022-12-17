from django.test import TestCase, Client
from rest_framework.authtoken.models import Token
from forum import models
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