from django.test import TestCase,Client
from django.urls import resolve,reverse
from .views import commentList,commentInfoIndex,requestGetter,requestPoster
from comment.models import Comment
from post.models import Post
from category.models import Category
from django.contrib.auth.models import User


# Some tests for testing URLS.
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
        
# Some tests for testing functions in the views. Including API and html renderer functions.
class TestViews(TestCase):

    # Since they are self explanatory, we did not feel necessary to explain each one individually.
    
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
            covid19cases = {
                "death" : 100,
                "case" : 100,
            }
        )

        comment = Comment.objects.create(
            body = "sample comment body",
            user = user,
            post = post,
            city_name = "Ankara",
            weather = "Sunny"
        )

    def test_index(self):

        url = reverse('comment-info-index')
        
        response = self.client.get(url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, "comment-info-index.html")
    
    def test_requestGetter_success(self):

        url = reverse("requestGetter")
        data = {
            "id" : 1
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, "comment-info-result.html")
    
    def test_requestGetter_error(self):

        url = reverse("requestGetter")
        data = {
            "id" : 100
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, "comment-info-error.html")
    
    def test_requestPoster_success(self):

        url = reverse("requestPoster")
        data = {
            "id" : 1,
            "body" : "hello this is a unit test",
            "city_name" : "Istanbul",
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, "comment-info-result.html")
    
    def test_requestPoster_error_InvalidID(self):

        url = reverse("requestPoster")
        data = {
            "id" : 100,
            "body" : "hello this is a unit test",
            "city_name" : "Istanbul",
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, "comment-info-error.html")

    def test_requestPoster_error_smallBody(self):

        url = reverse("requestPoster")
        data = {
            "id" : 1,
            "body" : "a",
            "city_name" : "Istanbul",
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, "comment-info-error.html")
    
    def test_requestPoster_error_missingInput_cityName(self):

        url = reverse("requestPoster")
        data = {
            "id" : 1,
            "body" : "a",
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, "comment-info-error.html")
    
    def test_requestPoster_error_missingInput_body(self):

        url = reverse("requestPoster")
        data = {
            "id" : 1,
            "city_name" : "Ankara"
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, "comment-info-error.html")
    
    def test_API_GET_success(self):

        url = reverse('base',args=[1])
        response = self.client.get(url)
        self.assertEquals(response.status_code, 200)
    
    def test_API_GET_failure(self):
        url = reverse('base',args=[100])
        response = self.client.get(url)
        self.assertEquals(response.status_code, 404)
    
    def test_API_POST_success(self):

        url = reverse('base',args=[1])
        data = {
            "body" : "This is a unit test",
            "city_name" : "Istanbul",
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 200)

    def test_API_POST_failure_InvalidID(self):

        url = reverse('base',args=[100])
        data = {
            "body" : "This is a unit test",
            "city_name" : "Istanbul",
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 404)

    def test_API_POST_failure_smallBody(self):

        url = reverse('base',args=[1])
        data = {
            "body" : "a",
            "city_name" : "Istanbul",
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 406)
    
    def test_API_POST_failure_missingInput_city_name(self):

        url = reverse('base',args=[1])
        data = {
            "body" : "this is a unit test",
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 406)

    def test_API_POST_failure_missingInput_body(self):
        
        url = reverse('base',args=[1])
        data = {
            "city_name" : "Ankara"
        }
        response = self.client.post(url, data)
        self.assertEquals(response.status_code, 406)