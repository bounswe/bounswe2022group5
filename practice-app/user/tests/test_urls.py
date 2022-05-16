from django.test import TestCase
from django.contrib.auth.models import User
from django.urls import resolve,reverse
from user.views import userView, UserList, userDetail, allUsers, createUser

class TestUrls(TestCase):
    def setUp(self):
        self._user = User.objects.create(
            username='usernameTestUser',
            password='passwordTestUser',
            email='emailTestUser@gmail.com'
        )

    def test_poster_url_resolves(self):
        url = reverse('userMain')
        self.assertEquals(resolve(url).func, userView)

    def test_index_url_resolves(self):
        url = reverse('api')
        self.assertEquals(resolve(url).func.__name__, UserList.as_view().__name__)

    def test_get_url_resolves(self):
        url = reverse('detailView',args=[self._user.username,])
        self.assertEquals(resolve(url).func.__name__, userDetail.as_view().__name__)
    
    def test_create_url_resolves(self):
        url = reverse('allUsers')
        self.assertEquals(resolve(url).func, allUsers)

    def test_create_url_resolves(self):
        url = reverse('createUser')
        self.assertEquals(resolve(url).func, createUser)