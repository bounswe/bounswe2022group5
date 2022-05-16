from django.test import TestCase, Client
from django.urls import reverse
from category.models import Category
import json

class TestViews(TestCase):

    def setUp(self):
        self.client = Client()
        self.index_url = reverse('index_category')
        self.get_categories_url = reverse('getCategories')
        self.post_category_url = reverse('postCategory')

        self.post_data = {
            "name": "liver",
            "definition": "A large organ in the body that stores and metabolizes nutrients, destroys toxins and produces bile. It is responsible for thousands of biochemical reactions."
        }

    def test_index_GET(self):
        response = self.client.get(self.index_url)

        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'index_category.html')

    def test_get_categories_GET(self):
        response = self.client.get(self.get_categories_url)

        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'listCategories_category.html')

    def test_post_category_GET(self):
        response = self.client.get(self.post_category_url)

        self.assertEquals(response.status_code, 200)
        self.assertTemplateUsed(response, 'createForm_category.html')

    def test_post_category_POST(self):
        response = self.client.post(self.post_category_url, self.post_data)
        new_categories = Category.objects.all()

        self.assertEquals(response.status_code, 302)
        self.assertEquals(Category.objects.count(), 1)
        self.assertEquals(new_categories[0].name, 'liver')
        self.assertEquals(new_categories[0].definition, 'A large organ in the body that stores and metabolizes nutrients, destroys toxins and produces bile. It is responsible for thousands of biochemical reactions.')
