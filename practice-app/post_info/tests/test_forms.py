from django.test import TestCase
from post_info.forms import postGetForm, postPostForm
from category.models import Category
from django.contrib.auth.models import User


class TestForms(TestCase):

    def setUp(self):
        self.category = Category.objects.create(
            name = 'category name',
            definition = 'category definition'
        )

        self.user = User.objects.create(
            username='username',
            password='password',
            email='email@gmail.com'
        )

    def test_post_form_valid_data(self):
        form = postPostForm(data={
            'post_id': 1,
            'title': 'title',
            'body': 'body',
            'category': self.category,
            'country': 'Turkey'
        })

        self.assertTrue(form.is_valid())

    def test_post_form_missing_input(self):
        form = postPostForm(data={})
        self.assertFalse(form.is_valid())

    def test_get_dorm_valid_data(self):
        form = postGetForm(data={
            'post_id': 1
        })

        self.assertTrue(form.is_valid())

    def test_get_form_missing_input(self):
        form = postGetForm(data={})
        self.assertFalse(form.is_valid())