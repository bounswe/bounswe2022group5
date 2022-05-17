from django.test import TestCase
from comment.models import Comment
from category.models import Category
from post.models import Post
from django.contrib.auth.models import User

class TestModel(TestCase):
    def setUp(self):
        category = Category.objects.create(
            name = 'name',
            definition = 'definition'
        )

        user = User.objects.create_user(username='halil',email = "email", password="12345")
        user.save()

        post = Post.objects.create(
            title = 'title_post_data',
            body = 'body',
            category = category,
            user = user,
            country = 'turkey',
            covid19cases = {
                'death': 500,
                'case' : 1000,
            },
        )

        comment_data = {
            'body' : 'body_of_the_comment',
            'user' : user,
            'post' : post,
            'city_name' : 'istanbul'
        }

        self._comment = Comment.objects.create(**comment_data) 

    def test_str(self):
        self.assertEquals(self._comment.__str__(), 'body_of_the_comment')
