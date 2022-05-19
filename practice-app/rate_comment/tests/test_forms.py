from django.test import TestCase
from rate_comment.forms import *
from category.models import Category
from django.contrib.auth.models import User


class TestForms(TestCase):

    def test_commentGetForm_valid_data(self):
        form = commentGetForm(data={
            'comment_id': 1,
        })

        self.assertTrue(form.is_valid())

    def test_commentPostForm_valid_data(self):
        form = commentPostForm(data={
            'comment_id': 1,
            'vote': "1",
        })
        self.assertTrue(form.is_valid())
    
    def test_commentGetForm_missing_input(self):
        form = commentGetForm(data={})
        self.assertFalse(form.is_valid())
    
    def test_commentPostForm_missing_input(self):
        form = commentPostForm(data={})
        self.assertFalse(form.is_valid())
