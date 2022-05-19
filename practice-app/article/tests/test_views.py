from django.test import TestCase, Client
from django.urls import reverse
from article.models import Article
from category.models import Category
from django.contrib.auth.models import User


class TestViews(TestCase):

    #creates a client to send requests in test
    #stores urls of the pages by reverse function
    #creates a category, a user, a post, and necessary data to be used in requests
    #logs the client in with created user parameters
    def setUp(self):
        self.client = Client()
        self.index_url = reverse('article_index') # 'api/'
        self.get_url = reverse('article_get') # 'get/'
        self.create_url = reverse('article_create') # 'create/'
        self.getpost_url = reverse('getpost') # ''

        category = Category.objects.create(
            name = 'name',
            definition = 'definition'
        )

        user = User.objects.create_user(
            username='username',
            password='password',
            email='email'
        )
        
        user2 = User.objects.create_user(
            username='username2',
            password='password2',
            email='email2'
        )



        self.data = {
            'title' : 'title_create_data',
            'body' : 'body',
            'category' : 1,
            'user' : 1,  
        }

        self.ui_data = {
            'title' : 'title_ui_data',
            'body' : 'body',
            'category' : 1,
        }

        article_data = {
            'title' : 'title_article_data',
            'body' : 'body',
            'category' : category,
            'user' : user,
        }

        self._article = Article.objects.create(**article_data)

        self.client.login(username='username', password='password')
    
    #tests articleIndex function with GET functionality, get page
    #checks returned status and rendered template
    def test_articleIndex_GET(self):
        response = self.client.get(self.index_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'article_index.html')

    #tests getArticles function with GET functionality, getting all articles
    #checks returned status and rendered template
    def test_getArticles_GET(self):
        response = self.client.get(self.get_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'article_get.html')

    #tests createArticle function with POST, success, created article
    #checks returned status and rendered template
    def test_createArticle_POST_create_article(self):
        response = self.client.post(self.create_url, self.ui_data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'article_create.html')

    #tests createArticle function with POST functionality, failure
    #checks returned status and rendered template
    def test_createArticle_POST_missing_input(self):
        response = self.client.post(self.create_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'article_cannot.html')

    #tests getpost function with POST functionality, success
    #checks returned status and returned data
    def test_getpost_POST_create_article(self):
        response = self.client.post(self.getpost_url, self.data)
        self.assertEquals(response.status_code, 201)
        self.assertEquals(response.data['title'], 'title_create_data')

    #tests getpost function with POST functionality, failure
    #checks returned status and returned data
    def test_getpost_POST_missing_input(self):
        response = self.client.post(self.getpost_url)
        self.assertEquals(response.status_code, 400)
        self.assertEquals(response.data, 'Missing input')

    #tests getpost function with GET functionality
    #checks returned status and returned data
    def test_getpost_GET(self):
        response = self.client.get(self.getpost_url)
        self.assertEquals(response.status_code, 200)
        self.assertEquals(response.data[0]['body'], 'body')

    
        