from django.test import TestCase
from rate_article.forms import *
from category.models import Category
from django.contrib.auth.models import User

class TestForms(TestCase):

    def test_articleGetForm_missing_input(self):
        form = articleGetForm(data={})

        self.assertFalse(form.is_valid())
    
    def test_articlePostForm_missing_input(self):
        form = articlePostForm(data={})

        self.assertFalse(form.is_valid())

    def test_articleGetForm_valid_data(self):
        form = articleGetForm(data={
            'article_id': 3,
        })

        self.assertTrue(form.is_valid())

    def test_articlePostForm_valid_data(self):
        form = articlePostForm(data={
            'article_id': 3,
            'vote': "-1",
        })

        self.assertTrue(form.is_valid())
    
