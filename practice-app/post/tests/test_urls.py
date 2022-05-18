from django.test import SimpleTestCase
from django.urls import resolve,reverse
from post.views import poster, index, get, create

#this class tests all urls in the folder /post/urls.py
#checks for every urls corresponding function is matches

class TestUrls(SimpleTestCase):

    def test_poster_url_resolves(self):
        url = reverse('poster')
        self.assertEquals(resolve(url).func, poster)

    def test_index_url_resolves(self):
        url = reverse('post_index')
        self.assertEquals(resolve(url).func, index)

    def test_get_url_resolves(self):
        url = reverse('post_get')
        self.assertEquals(resolve(url).func, get)
    
    def test_create_url_resolves(self):
        url = reverse('post_create')
        self.assertEquals(resolve(url).func, create)