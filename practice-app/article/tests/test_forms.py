from django.test import TestCase
from article.forms import ArticlePostForm
from category.models import Category
from article.models import Article
from django.contrib.auth.models import User


class TestForms(TestCase):

    #creates a category and a user object to test the form
    def setUp(self):
        self.category = Category.objects.create(name = 'name', definition = 'definition')

        user = User.objects.create_user(username='canberk', password='canberkpw', email='email')
        user.save()

        article = Article.objects.create(title = 'article_title_data',
            body = 'body',
            category = self.category,
            user = user,)

    def test_post_form_valid_data(self):
        form = ArticlePostForm(data={
            'title': 'title',
            'body': 'body',
            'category': self.category,
        })

        self.assertTrue(form.is_valid())

    def test_post_form_no_data(self):
        self.client.login(username='canberk', password='canberkpw')
        form = ArticlePostForm(data={})
        self.assertFalse(form.is_valid())