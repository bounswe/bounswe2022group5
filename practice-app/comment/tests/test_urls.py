from django.test import SimpleTestCase
from django.urls import resolve,reverse
from comment.views import CommentApiView, getComments, postComment, index

class TestUrls(SimpleTestCase):

    def test_api_url_resolves(self):
        url = reverse('commentApi', args=[1])
        self.assertEquals(resolve(url).func.view_class, CommentApiView)

    def test_get_url_resolves(self):
        url = reverse('getComments')
        self.assertEquals(resolve(url).func, getComments)

    def test_post_url_resolves(self):
        url = reverse('postComment')
        self.assertEquals(resolve(url).func, postComment)

    def test_index_url_resolves(self):
        url = reverse('commentIndex')
        self.assertEquals(resolve(url).func, index)
    
    