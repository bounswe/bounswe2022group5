from django.test import TestCase, Client
from django.urls import reverse
from comment.models import Comment
from category.models import Category
from post.models import Post
from django.contrib.auth.models import User

class TestViews(TestCase):
    def setUp(self):
        self.client = Client()
        self.api_url = reverse('commentApi', args=[1]) # api/<int:post_id>/
        self.get_url = reverse('getComments') # 'list/'
        self.post_url = reverse('postComment') # 'create/'
        self.index_url = reverse('commentIndex') # ''

        category = Category.objects.create(
            name = 'name',
            definition = 'definition'
        )

        user1 = User.objects.create_user(username='halil',email = "email", password="12345")
        user2 = User.objects.create_user(username='burak',email = "email", password="12345")

        user1.save()
        user2.save()

        post = Post.objects.create(
            title = 'title_post_data',
            body = 'body',
            category = category,
            user = user1,
            country = 'turkey',
            covid19cases = {
                'death': 500,
                'case' : 1000,
            },
        )

        comment_data = {
            'body' : 'body_of_the_1st_comment',
            'user' : user2,
            'post' : post,
            'city_name' : 'istanbul'
        }

        self.create_comment_data = {
            'body': 'comment create body',
            'post' : post,
            'city_name' : 'istanbul'
        }

        self.comment_with_wrong_post = {
            'body': 'comment create body',
            'post' : post,
            'city_name' : 'istanbul'
        }

        self._comment = Comment.objects.create(**comment_data) 

    # API tests:
    def test_api_GET(self): 
        # Performing a proper GET:
        response = self.client.get(self.api_url, {'post_id':1})
        self.assertEquals(response.status_code, 200)
        self.assertEquals(response.data[0]['body'],'body_of_the_1st_comment')
    
    def test_api_POST_create_comment(self):
        # Performing a proper POST to create a new comment:
        self.client.login(username='burak', password='12345')
        response = self.client.post(self.api_url, self.create_comment_data)
        self.assertEquals(response.status_code, 201)
        self.assertEquals(response.data['body'],'comment create body')

    def test_api_POST_not_authenticated(self):
        # Non authenticated users cannot perform POST:
        response = self.client.post(self.api_url, self.create_comment_data)
        self.assertEquals(response.status_code, 403)

    def test_api_POST_missing_input(self):
        # There should be input:
        self.client.login(username='burak', password='12345')
        response = self.client.post(self.api_url)
        self.assertEquals(response.status_code, 400)
        self.assertEquals(response.data['error'],'Missing input')

    def test_api_POST_no_post(self):
        # There cannot be a comment for a nonexisting post:
        self.client.login(username='burak', password='12345')
        response = self.client.post(reverse('commentApi', args=[2]), {
            'body' : 'comment for a nonexisting post',
            'city_name' : 'ankara'
        })
        self.assertEquals(response.status_code, 404)
        self.assertEquals(response.data['error'],'There is no post with id 2')

    def test_api_POST_no_body(self):
        # There cannot be a comment without a body:
        self.client.login(username='burak', password='12345')
        response = self.client.post(self.api_url, {
            'city_name' : 'ankara'
        })
        self.assertEquals(response.status_code, 400)
        self.assertEquals(response.data['error'],'Missing body of the comment')

    def test_api_POST_empty_body(self):
        # There cannot be a comment with an empty body:
        self.client.login(username='burak', password='12345')
        response = self.client.post(self.api_url, {
            'body' : '',
            'city_name' : 'ankara'
        })
        self.assertEquals(response.status_code, 400)
        self.assertEquals(response.data['error'],'Body of the comment cannot be empty')

    # Frontend tests:
    def test_index_GET(self):
        response= self.client.get(self.index_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'comment.html')

    def test_get_comments_GET(self):
        response = self.client.get(self.get_url, {'post_id' : 1})
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'listComments.html')

    def test_post_coment_POST(self):
        self.client.login(username='burak', password='12345')
        response = self.client.post(self.post_url, {
            'body' : 'a comment for post',
            'post_id' : 1,
            'city_name' : 'ankara'
        })
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'comment.html')
