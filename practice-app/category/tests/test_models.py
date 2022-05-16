from django.test import TestCase
from category.models import Category

class TestModels(TestCase):

    def setUp(self):
        self.category1 = Category.objects.create(
            name = "liver",
            definition = "liver definition"
        )

    def test_category_fields(self):
        self.assertEquals(self.category1.name, "liver")
        self.assertEquals(self.category1.definition, "liver definition")

    def test_category_str(self):
        self.assertEquals(self.category1.__str__(), "liver")