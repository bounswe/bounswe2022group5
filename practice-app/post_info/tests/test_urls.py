from django.test import TestCase, Client
from django.urls import resolve,reverse
from post.models import Post
from category.models import Category
from django.contrib.auth.models import User
from post_info.views import index, getPost, postPost, PostInfo

class TestUrls(TestCase):

    def setUp(self):
        self.client = Client()
        self.index_url = reverse('index_post_info')
        self.get_url = reverse('getPost')
        self.post_url = reverse('postPost')

        covid19cases = {
            'death': 500,
            'case': 1000,
        }

        self.category = Category.objects.create(
            name='category name',
            definition='category definition'
        )

        user = User.objects.create(
            username='username',
            password='password',
            email='email@gmail.com'
        )

        post_data = {
            'title': 'post_title',
            'body': 'post_body',
            'category': self.category,
            'user': user,
            'country': 'Turkey',
            'covid19cases': covid19cases,
            'nof_upvotes': 0,
            'nof_downvotes': 0
        }

        self.post_ = Post.objects.create(**post_data)


    def test_index_url_resolves(self):
        url = reverse('index_post_info')
        self.assertEquals(resolve(url).func, index)

    def test_get_url_resolves(self):
        url = reverse('getPost')
        self.assertEquals(resolve(url).func, getPost)

    def test_post_url_resolves(self):
        url = reverse('postPost')
        self.assertEquals(resolve(url).func, postPost)

    def test_api_url_resolves(self):
        url = reverse('api_post_info', args=[1])
        self.assertEquals(resolve(url).func.view_class, PostInfo)

