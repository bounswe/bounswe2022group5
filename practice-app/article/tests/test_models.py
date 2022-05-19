from django.test import TestCase
from article.models import Article
from category.models import Category
from django.contrib.auth.models import User

class TestModels(TestCase):

    #creates a category, a user, a post and necessary data to be tested.
    def setUp(self):

        category = Category.objects.create(
            name = 'name',
            definition = 'definition'
        )

        user = User.objects.create(
            username='username',
            password='password',
            email='email'
        )

        article_data = {
            'title' : 'title_of_the_model',
            'body' : 'body',
            'category' : category,
            'user' : user,
        }

        self._article = Article.objects.create(**article_data)

    #tests whether model returns the correct field with correct data
    def test_str(self):
        self.assertEquals(self._article.__str__(), 'title_of_the_model')
