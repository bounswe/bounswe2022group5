from django.test import SimpleTestCase
from django.urls import resolve,reverse
from post.views import poster, index, get, create

class TestUrls(SimpleTestCase):

    def test_poster_url_resolves(self):
        url = reverse('poster')
        self.assertEquals(resolve(url).func, poster)

    def test_index_url_resolves(self):
        url = reverse('index')
        self.assertEquals(resolve(url).func, index)

    def test_get_url_resolves(self):
        url = reverse('get')
        self.assertEquals(resolve(url).func, get)
    
    def test_create_url_resolves(self):
        url = reverse('create')
        self.assertEquals(resolve(url).func, create)