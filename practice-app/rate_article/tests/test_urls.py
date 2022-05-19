from django.shortcuts import resolve_url
from django.test import SimpleTestCase
from django.urls import resolve, reverse, path
from rate_article.views import *

class TestUrls(SimpleTestCase):


    def test_index_url_is_resolved(self):
        url = reverse('getVoteApis')
        self.assertEquals(resolve(url).func, articleVotes.getVoteApis)

    def test_get_url_is_resolved(self):
        url = reverse('postVoteApis')
        self.assertEquals(resolve(url).func, articleVotes.postVoteApis)

    def test_poster_url_is_resolved(self):
        url = reverse('index1')
        self.assertEquals(resolve(url).func, indexRateArticle)
