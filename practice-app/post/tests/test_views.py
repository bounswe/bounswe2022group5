from django.test import TestCase, Client
from django.urls import reverse
from post.models import Post
from category.models import Category
from django.contrib.auth.models import User


class TestViews(TestCase):

    #creates a client to send requests in test
    #stores urls of the pages by reverse function
    #creates a category, a user, a post, and necessary data to be used in requests
    #logs the client in with created user parameters
    def setUp(self):
        self.client = Client()
        self.index_url = reverse('post_index')
        self.get_url = reverse('post_get')
        self.create_url = reverse('post_create')
        self.poster_url = reverse('poster')

        category = Category.objects.create(
            name = 'name',
            definition = 'definition'
        )

        user = User.objects.create_user(
            username='username',
            password='password',
            email='email'
        )

        covid19 = {
            'death': 500,
            'case' : 1000,
        }

        self.data = {
            'title' : 'title_create_data',
            'body' : 'body',
            'category' : 1,
            'user' : 1,
            'country' : 'turkey',
            'covid19cases' : covid19,    
        }

        self.ui_data = {
            'title' : 'title_ui_data',
            'body' : 'body',
            'category' : 1,
            'country' : 'turkey',
        }

        post_data = {
            'title' : 'title_post_data',
            'body' : 'body',
            'category' : category,
            'user' : user,
            'country' : 'turkey',
            'covid19cases' : covid19,
        }

        self._post = Post.objects.create(**post_data)

        self.client.login(username='username', password='password')
    
    #tests index function with GET functionality
    #checks returned status and rendered template
    def test_index_GET(self):
        response = self.client.get(self.index_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'post_index.html')

    #tests get function with GET functionality
    #checks returned status and rendered template
    def test_get_GET(self):
        response = self.client.get(self.get_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'post_get.html')

    #tests create function with POST functionality, success
    #checks returned status and rendered template
    def test_create_POST_create_post(self):
        response = self.client.post(self.create_url, self.ui_data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'post_create.html')

    #tests create function with POST functionality, failure
    #checks returned status and rendered template
    def test_create_POST_missing_input(self):
        response = self.client.post(self.create_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'post_notfound.html')

    #tests poster function with POST functionality, success
    #checks returned status and returned data
    def test_poster_POST_create_post(self):
        response = self.client.post(self.poster_url, self.data)
        self.assertEquals(response.status_code, 201)
        self.assertEquals(response.data['title'], 'title_create_data')

    #tests poster function with POST functionality, failure
    #checks returned status and returned data
    def test_poster_POST_missing_input(self):
        response = self.client.post(self.poster_url)
        self.assertEquals(response.status_code, 400)
        self.assertEquals(response.data, 'Missing input')

    #tests poster function with GET functionality
    #checks returned status and returned data
    def test_poster_GET(self):
        response = self.client.get(self.poster_url)
        self.assertEquals(response.status_code, 200)
        self.assertEquals(response.data[0]['title'], 'title_post_data')

    
        