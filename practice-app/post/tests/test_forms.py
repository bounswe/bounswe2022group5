from django.test import TestCase
from post.forms import PostForm
from category.models import Category
from django.contrib.auth.models import User


class TestForms(TestCase):

    #creates a category and a user object to test the form
    def setUp(self):
        self.category = Category.objects.create(
            name = 'name',
            definition = 'definition'
        )

        self.user = User.objects.create_user(
            username='username',
            password='password',
            email='email'
        )

    #asserts true if form is valid
    def test_post_form_valid_data(self):
        form = PostForm(data={
            'title': 'title',
            'body': 'body',
            'category': self.category,
            'country': 'country',
        })

        self.assertTrue(form.is_valid())

    #asserts false if form is not valid
    def test_post_form_missing_input(self):
        self.client.login(username='username', password='password')
        form = PostForm(data={})
        self.assertFalse(form.is_valid())