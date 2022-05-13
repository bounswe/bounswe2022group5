from django.test import TestCase
from post.forms import PostForm
from category.models import Category
from django.contrib.auth.models import User


class TestForms(TestCase):

    def setUp(self):
        self.category = Category.objects.create(
            name = 'name',
            definition = 'definition'
        )

        self.user = User.objects.create(
            username='username',
            password='password',
            email='email'
        )

    def test_post_form_valid_data(self):
        form = PostForm(data={
            'title': 'title',
            'body': 'body',
            'category': self.category,
            'user': self.user,
            'country': 'country',
        })

        self.assertTrue(form.is_valid())

    def test_post_form_missing_input(self):
        form = PostForm(data={})
        self.assertFalse(form.is_valid())