from django.test import TestCase
from comment.models import Comment
from category.models import Category
from post.models import Post
from django.contrib.auth.models import User
from comment.forms import *

class TestForms(TestCase):

    def setUp(self):
        category = Category.objects.create(
            name = 'name',
            definition = 'definition'
        )

        user = User.objects.create_user(username='halil',email = "email", password="12345")
        user.save()

        post = Post.objects.create(
            title = 'title_post_data',
            body = 'body',
            category = category,
            user = user,
            country = 'turkey',
            covid19cases = {
                'death': 500,
                'case' : 1000,
            },
        )

        comment1 = Comment.objects.create(
            body = 'comment1body',
            user = user,
            post = post,
        )

        comment2 = Comment.objects.create(
            body = 'comment2body',
            user = user,
            post = post,
        )

    def test_get_form_valid_data(self):
        getForm = commentGetForm(data={
            'post_id' : 1
        })
        self.assertTrue(getForm.is_valid())

    def test_get_form_no_data(self):
        getForm = commentGetForm(data={})
        self.assertFalse(getForm.is_valid())
        self.assertEquals(len(getForm.errors), 1)

    def test_post_form_valid_data(self):
        postForm = commentPostForm(data={
            'body' : 'new comment',
            'post_id' : 1,
            'city_name' : 'istanbul'
        })

        self.assertTrue(postForm.is_valid())

    def test_post_form_no_data(self):
        postForm = commentPostForm(data={})
        self.assertFalse(postForm.is_valid())
        self.assertEquals(len(postForm.errors), 3)
