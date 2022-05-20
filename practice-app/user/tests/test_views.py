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

        self.username_taken = {
            'username':'testUsername2',
            'email': 'unique@gmail.com',
            'password': "unique"
        }
        

        self.email_taken = {
            'username':'unique',
            'email': 'testEmail2@gmail.com',
            'password': "unique"

        }

        self.username_short = {
            'username':'uniq',
            'email': 'unique@gmail.com',
            'password': "unique"
        }

        self.password_short = {
            'username':'unique',
            'email': 'uniqu@gmail.com',
            'password': "uniq"
        }
        
        self.email_not_valid = {
            'username':'unique',
            'email': 'emailWithNoDomain@com',
            'password': "unique"
        } 
        self.email_not_valid_2 = {
            'username':'unique',
            'email': 'emailWithInvalidDomain@gmali.com',
            'password': "unique"
        } 

    def test_user_GET(self):
        response = self.client.get(self.user_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'user.html')

    def test_allUsers_GET(self):
        response = self.client.get(self.allUsers_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'allUsers.html')
    
    #doesn't need to test views
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
        self.assertEquals(response.data["error_code"], 1)
    
    def test_poster_POST_username_taken(self):
        response = self.client.post(self.userAPI_url,self.username_taken)
        usernames = User.objects.values_list('username', flat=True)
    
        self.assertEquals(response.status_code, 409)
        self.assertEquals(response.data["error_code"], 2)
    
    def test_poster_POST_email_taken(self):
        response = self.client.post(self.userAPI_url,self.email_taken)
        
        self.assertEquals(response.status_code, 409)
        self.assertEquals(response.data["error_code"], 3)
    def test_poster_POST_username_short(self):
        response = self.client.post(self.userAPI_url,self.username_short)
        
        self.assertEquals(response.status_code, 400)
        self.assertEquals(response.data["error_code"], 4)
    def test_poster_POST_password_short(self):
        response = self.client.post(self.userAPI_url,self.password_short)
        
        self.assertEquals(response.status_code, 400)
        self.assertEquals(response.data["error_code"], 5)
    def test_poster_POST_email_not_valid(self):
        response = self.client.post(self.userAPI_url,self.email_not_valid)
        
        self.assertEquals(response.status_code, 400)
        self.assertEquals(response.data["error_code"], 6)
    def test_poster_POST_email_not_valid(self):
        response = self.client.post(self.userAPI_url,self.email_not_valid_2)
        self.assertEquals(response.status_code, 400)
        self.assertEquals(response.data["error_code"], 7)
    
    

    def test_poster_GET(self):
        
        response = self.client.get(self.userAPI_url)
        self.assertEquals(response.status_code, 200)
        self.assertEquals(response.data[0]['username'], 'testUsername2')

    
        