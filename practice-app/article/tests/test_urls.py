from django.test import SimpleTestCase
from django.urls import resolve,reverse
from article.views import getpost, articleIndex, getArticles, createArticle

#this class tests all urls in the folder /post/urls.py
#checks for every urls corresponding function is matches

class TestUrls(SimpleTestCase):

    def test_getpost_url_resolves(self):
        url = reverse('getpost')
        self.assertEquals(resolve(url).func, getpost)

    def test_index_url_resolves(self):
        url = reverse('article_index')
        self.assertEquals(resolve(url).func, articleIndex)

    def test_get_url_resolves(self):
        url = reverse('article_get')
        self.assertEquals(resolve(url).func, getArticles)
    
    def test_create_url_resolves(self):
        url = reverse('article_create')
        self.assertEquals(resolve(url).func, createArticle)