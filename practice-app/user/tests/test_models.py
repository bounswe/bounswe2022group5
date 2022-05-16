from django.test import TestCase
from django.contrib.auth.models import User

class TestModels(TestCase):

    def setUp(self):

        

        self._user = User.objects.create(
            username='username',
            password='password',
            email='email'
        )

        


    def test_str(self):
        self.assertEquals(self._user.__str__(), 'username')
