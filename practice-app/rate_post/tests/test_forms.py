from django.test import TestCase
from rate_post.forms import *
from category.models import Category
from django.contrib.auth.models import User


class TestForms(TestCase):

    def test_postGetForm_valid_data(self):
        form = postGetForm(data={
            'post_id': 4,
        })

        self.assertTrue(form.is_valid())

    def test_postPostForm_valid_data(self):
        form = postPostForm(data={
            'post_id': 4,
            'vote': "1",
        })
        self.assertTrue(form.is_valid())
    
    def test_postGetForm_missing_input(self):
        form = postGetForm(data={})
        self.assertFalse(form.is_valid())
    
    def test_postPostForm_missing_input(self):
        form = postPostForm(data={})
        self.assertFalse(form.is_valid())