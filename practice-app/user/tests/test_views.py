from django.test import TestCase, Client
from django.urls import reverse
from django.contrib.auth.models import User


class TestViews(TestCase):

    def setUp(self):
        self.client = Client()
        self._user = User.objects.create(
            username='testUsername2',
            password='testPassword2',
            email='testEmail2@gmail.com'
        )
        
        
        self.user_url = reverse('userMain')
        self.userAPI_url = reverse('api')
        self.detail_url = reverse('detailView',args=[self._user.username,])
        self.allUsers_url = reverse('allUsers')
        self.createUser_url = reverse('createUser')
        

        




        self.data = {
            'username':'testUserDjango',
            'email':'emailTestDjango@gmail.com',
            'password':'testPassword'
        }

        self.invalid_data = {
            'username':'',
            'email':'',
            'password':''
        }

        
        

    def test_user_GET(self):
        response = self.client.get(self.user_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'user.html')

    def test_allUsers_GET(self):
        response = self.client.get(self.allUsers_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'allUsers.html')
    

    """ def test_create_POST_create_user(self):
        response = self.client.post(self.createUser_url, self.data)
        print(response.url)
        self.assertEquals(response.status_code, 302)
        self.assertRedirects(response, '')

    def test_create_POST_missing_input(self):
        response = self.client.post(self.createUser_url,self.invalid_data)
        
        self.assertEquals(response.status_code, 302)
        self.assertTemplateUsed(response, 'user.html') """

    def test_api_POST_create_user(self):
        response = self.client.post(self.userAPI_url, self.data)
        
        self.assertEquals(response.status_code, 201)
        self.assertEquals(response.data['username'], 'testUserDjango')

    def test_poster_POST_missing_input(self):
        response = self.client.post(self.userAPI_url,self.invalid_data)
       
        self.assertEquals(response.status_code, 400)
        self.assertEquals(response.data["message"], 'Invalid Data')

    def test_poster_GET(self):
        
        response = self.client.get(self.userAPI_url)
        self.assertEquals(response.status_code, 200)
        self.assertEquals(response.data[0]['username'], 'testUsername2')

    
        