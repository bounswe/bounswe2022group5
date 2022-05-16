from django.test import SimpleTestCase
from category.forms import categoriesPostForm

class TestForms(SimpleTestCase):

    def test_category_post_form_valid_data(self):
        form = categoriesPostForm(data={
            "name": "liver"
        })

        self.assertTrue(form.is_valid())

    def test_category_post_form_no_data(self):
        form = categoriesPostForm(data={})

        self.assertFalse(form.is_valid())
        self.assertEquals(len(form.errors), 1)