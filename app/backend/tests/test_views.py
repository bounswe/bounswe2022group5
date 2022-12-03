from django.test import TestCase, Client
from django.contrib.auth.hashers import check_password
from rest_framework.authtoken.models import Token
from backend import models
from backend import constants

from tests.constants import *


class RegisterTestCase(TestCase):
    def setUp(self) -> None:
        return super().setUp()
    def test_register_with_valid_email(self):
        client = Client()
        data = {
            'email':'joedoetest@gmail.com',
            'password':'testpassword',
            'type':2, 
            'username': 'testuser', 
            'date_of_birth': '2000-12-28'
            }
        response = client.post('/auth/register',data)
        self.assertEqual(str(response.json()["email"]), 'joedoetest@gmail.com')
        self.assertEqual(response.status_code,200)
        self.assertContains(response, "token")
    def test_register_with_invalid_email(self):
        client = Client()
        user = models.CustomUser.objects.create(email="joedoetest@gmail.com", password="testpassword",type=2)
        data = {
            'email':'joedoetest@gmail.com',
            'password':'testpassword',
            'type':2, 
            'username': 'testuser', 
            'date_of_birth': '2000-12-28'
            }
        response = client.post('/auth/register',data)
        
        self.assertNotEqual(response.status_code,200)

class LoginTestCase(TestCase):
    def setUp(self) -> None:
        user = models.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2)
        return super().setUp()
    def test_login_with_valid_credentials(self):
        client = Client()
        
        data = {'email':'joedoetest@gmail.com','password':'testpassword'}
        response = client.post('/auth/login',data, content_type="application/json")
        self.assertEqual(str(response.json()["data"]["email"]), 'joedoetest@gmail.com')
        self.assertEqual(response.status_code,200)
        self.assertContains(response, "token")
    def test_login_with_invalid_credentials(self):
        client = Client()
        data = {'email':'joedoetest2@gmail.com','password':'testpassword'}
        response = client.post('/auth/login',data, content_type="application/json")
        
        self.assertNotEqual(response.status_code,200)

class PersonalInfoTestCase(TestCase):
    def setUp(self) -> None:
        return super().setUp()
    def test_token_with_valid_credentials(self):
        client = Client()
        user = models.CustomUser.objects.create_user(email="joedoetest@gmail.com", password="testpassword",type=2)
        token = Token.objects.create(user=user)
        
        response = client.get('/auth/me',content_type="application/json", **{"HTTP_AUTHORIZATION": f"Token {token.key}"})
        
        self.assertEqual(str(response.json()["email"]), 'joedoetest@gmail.com')
        self.assertEqual(response.status_code,200)
        self.assertContains(response, "type")
    




