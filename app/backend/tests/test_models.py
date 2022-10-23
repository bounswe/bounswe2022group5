from django.test import TestCase
from django.contrib.auth.hashers import check_password

from backend import models
from backend import constants
from backend import utils

TEST_ADMIN_EMAIL = "test_admin@test.com"
TEST_ADMIN_PASSWORD = "test_password"
TEST_ADMIN_USERNAME = "test_admin_unsername"

class AdminTestCase(TestCase):
    def setUp(self):
        models.Admin.objects.create(
            email=TEST_ADMIN_EMAIL,
            password=utils.make_password(TEST_ADMIN_PASSWORD),
            type=constants.UserType.ADMIN.value,
            username=TEST_ADMIN_USERNAME
        )
    
    def test_admin_name(self):
        testAdmin = models.Admin.objects.get(username=TEST_ADMIN_USERNAME)

        self.assertTrue(isinstance(testAdmin, models.Admin))

        self.assertEqual(testAdmin.email, TEST_ADMIN_EMAIL)
        self.assertTrue(check_password(TEST_ADMIN_PASSWORD, testAdmin.password))
        self.assertEqual(str(testAdmin), TEST_ADMIN_USERNAME)
        self.assertEqual(testAdmin.type, constants.UserType.ADMIN.value)

