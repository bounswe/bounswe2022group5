from django.test import TestCase
from post.models import Post
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

        covid19 = {
            'death': 500,
            'case' : 1000,
        }

        post_data = {
            'title' : 'title_of_the_model',
            'body' : 'body',
            'category' : category,
            'user' : user,
            'country' : 'turkey',
            'covid19cases' : covid19,
        }

        self._post = Post.objects.create(**post_data)

    #tests whether model returns the correct field with correct data
    def test_str(self):
        self.assertEquals(self._post.__str__(), 'title_of_the_model')
