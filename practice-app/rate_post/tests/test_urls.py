from django.test import SimpleTestCase
from django.urls import resolve,reverse,path
from rate_post.views import *

class TestUrls(SimpleTestCase):

    def test_poster_url_resolves(self):
        url = reverse('index')
        self.assertEquals(resolve(url).func, indexRatePost)

    def test_index_url_resolves(self):
        url = reverse('getVoteApi')
        self.assertEquals(resolve(url).func, postVote.getVoteApi)

    def test_get_url_resolves(self):
        url = reverse('postVoteApi')
        self.assertEquals(resolve(url).func, postVote.postVoteApi)