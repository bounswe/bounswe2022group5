from django.test import TestCase
from article_info.forms import articleGetForm, articlePostForm
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

    def test_get_form_valid_data(self):
        form = articleGetForm(data={'article_id':1})
        self.assertTrue(form.is_valid())

    def test_get_form_missing_input(self):
        form = articleGetForm(data={})
        self.assertFalse(form.is_valid())

    def test_post_form_valid_data(self):
        data = {
            'article_id': 1,
            'title': 'article_title',
            'body': 'article_body',
            'category_id': self.category
        }
        form = articlePostForm(data=data)
        self.assertTrue(form.is_valid())

    def test_post_form_missing_input(self):
        form = articlePostForm(data={})
        self.assertFalse(form.is_valid())
