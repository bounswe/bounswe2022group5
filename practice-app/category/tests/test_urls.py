from django.test import SimpleTestCase
from django.urls import reverse, resolve
from category.views import index, getCategories, postCategory, CategoryView

class TestUrls(SimpleTestCase):
    
    def test_index_url_resolves(self):
        url = reverse('index_category')
        self.assertEquals(resolve(url).func, index)

    def test_list_url_resolves(self):
        url = reverse('getCategories')
        self.assertEquals(resolve(url).func, getCategories)

    def test_create_url_resolves(self):
        url = reverse('postCategory')
        self.assertEquals(resolve(url).func, postCategory)

    def test_api_url_resolves(self):
        url = reverse('api_category')
        self.assertEquals(resolve(url).func.view_class, CategoryView)