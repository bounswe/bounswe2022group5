from django.test import SimpleTestCase
from django.urls import resolve,reverse
from rate_comment.views import *

class TestUrls(SimpleTestCase):

    def test_post_url(self):
        url = reverse('Commentindex')
        self.assertEquals(resolve(url).func, index)

    def test_index_url(self):
        url = reverse('getCommentVoteApi')
        self.assertEquals(resolve(url).func, CommentRating.getCommentVoteApi)

    def test_get_url(self):
        url = reverse('postCommentVoteApi')
        self.assertEquals(resolve(url).func, CommentRating.postCommentVoteApi)
