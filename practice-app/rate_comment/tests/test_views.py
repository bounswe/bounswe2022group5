from django.test import TestCase, Client
from django.urls import reverse
from comment.models import Comment
from post.models import Post
from category.models import Category
from django.contrib.auth.models import User
import json

class TestCommentViews(TestCase):

    def setUp(self):
        self.client = Client()
        self.index_url = reverse('Commentindex')
        self.get_url = reverse('getCommentVoteApi')
        self.post_url = reverse('postCommentVoteApi')

        self.user = User.objects.create(username='usertest1')
        self.user.set_password('passwordtest1')
        self.user.save()

        category = Category.objects.create(
            name = 'name',
            definition = 'definition'
        )
        post = Post.objects.create(
            title = 'title_post_data',
            body = 'body',
            category = category,
            user = self.user,
            country = 'turkey',
            covid19cases = {
                'death': 500,
                'case' : 1000,
            },
        )

        comment_data = {
            'body': 'comment_body',
            'user': self.user,
            'post' : post,
            'city_name': 'Ankara',
            'nof_upvotes': 1,
            'nof_downvotes': 4
        }
        self.update_info = {
            'comment_id': 1,
            'vote': "1"
        }

        self.comment = Comment.objects.create(**comment_data)
        self.api_url = reverse('api', args=[1])

    def test_index_GET(self):
        response = self.client.get(self.index_url)
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'formsratecomment.html')

    def test_comment_GET(self):
        response = self.client.get(self.get_url, {'comment_id': 1})
        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'viewratecomment.html')
        self.assertEquals(self.comment.body, 'comment_body')
        self.assertEquals(self.comment.city_name, 'Ankara')


    def test_comment_POST(self):
        response = self.client.post(self.post_url, self.update_info)
        comment = Comment.objects.get(id=1)
        self.assertEquals(response.status_code, 302)
        self.assertEquals(comment.nof_upvotes, 2)
