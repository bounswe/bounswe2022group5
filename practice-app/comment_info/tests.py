from django.test import TestCase,Client
from django.urls import resolve,reverse
from .views import commentList,commentInfoIndex,requestGetter,requestPoster
from comment.models import Comment
from post.models import Post
from category.models import Category
from django.contrib.auth.models import User

class TestURLs(TestCase):

    def test_index_url_resolves(self):
        url = reverse('comment-info-index')
        self.assertEquals(resolve(url).func, commentInfoIndex)

    def test_request_getter_resolves(self):
        url = reverse('requestGetter')
        self.assertEquals(resolve(url).func, requestGetter)

    def test_request_poster_resolves(self):
        url = reverse('requestPoster')
        self.assertEquals(resolve(url).func, requestPoster)

    def test_baseURL_resolves(self):
        url = reverse('base',args=[1])
        self.assertEquals(resolve(url).func.view_class, commentList)

"""
class TestViews(TestCase):

    def setUp(self):
        self.client = Client()

        category = Category.objects.create(
            name = "dermatology",
            definition = "sample category"
        )

        user = User.objects.create(
            username = "sampleName",
            password = "samplePass",
            email = "sampleMail@gmail.com"
        )

        post = Post.objects.create(
            title = "samplePost",
            body = "sample Post Body",
            category = category,
            user = user,
            country = "Turkey",
            covid19cases = 100
        )

        comment = Comment.objects.create(
            body = "sample comment body",
            user = user,
            post = post,
            city_name = "Ankara",
            weather = "Sunny"
        )

    def test_index(self):

        url = reverse('commentInfoIndex')
        
        response = self.client.get(url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, "index.html")
    
    def test_requestGetter_success(self):

        url = reverse("requestGetter")
        data = {
            "id" : 1
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, "result.html")
"""