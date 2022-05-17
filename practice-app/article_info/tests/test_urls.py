from django.shortcuts import resolve_url
from django.test import SimpleTestCase
from django.urls import resolve, reverse
from article_info.views import getArticle, postArticle, index, ArticleInfo

class TestUrls(SimpleTestCase):

    def test_getArticle_url_is_resolved(self):
        url = reverse('getArticle')
        self.assertEquals(resolve(url).func, getArticle)

    def test_postArticle_url_is_resolved(self):
        url = reverse('postArticle')
        self.assertEquals(resolve(url).func, postArticle)

    def test_index_url_is_resolved(self):
        url = reverse('index_article_info')
        self.assertEquals(resolve(url).func, index)

    def test_ArticleInfo_url_resolves(self):
        url = reverse('api_article_info', args=[1])
        self.assertEquals(resolve(url).func.view_class, ArticleInfo)