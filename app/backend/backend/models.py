# from backend.auth_system import models
# from backend.follow_system import models
# from backend.profile_management import models

from django.db import models
from django.contrib.postgres.fields import ArrayField
import datetime
from django.contrib.auth.models import AbstractBaseUser, AbstractUser, UserManager
from django.contrib.auth.base_user import BaseUserManager

class CustomUserManager(UserManager):
    def _create_user(self, email, password, **extra_fields):
        """
        Creates and saves a User with the given email and password.
        """
        if not email:
            raise ValueError('The given email must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email, password=None, **extra_fields):
        extra_fields.setdefault('is_superuser', False)
        return self._create_user(email, password, **extra_fields)

    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self._create_user(email, password, type=0, **extra_fields)
class CustomUser(AbstractUser):
    objects = CustomUserManager()
    username = None
    first_name = None
    groups = None
    last_name = None
    password = models.CharField(max_length=200, null=False)
    email = models.CharField(max_length=100, null=False, unique=True) 
    type = models.IntegerField(null=False)
    date_of_birth = models.DateField(null=True)
    upvoted_posts = ArrayField(models.IntegerField(null=True), null=True, default=list)
    downvoted_posts = ArrayField(models.IntegerField(null=True), null=True, default=list)
    upvoted_comments = ArrayField(models.IntegerField(null=True), null=True, default=list)
    downvoted_comments = ArrayField(models.IntegerField(null=True), null=True, default=list)
    upvoted_articles = ArrayField(models.IntegerField(null=True), null=True, default=list)
    downvoted_articles = ArrayField(models.IntegerField(null=True), null=True, default=list)
    followed_categories = ArrayField(models.IntegerField(null=True), null=True, default=list)
    bookmarked_posts = ArrayField(models.IntegerField(null=True), null=True, default=list)
    bookmarked_articles = ArrayField(models.IntegerField(null=True), null=True, default=list)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    def __str__(self):
        return self.email

class CustomAdmin(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE,)
    admin_username = models.CharField(max_length=50, null=False, unique=True,primary_key=True)

    def __str__(self):
        return self.admin_username

class MemberInfo(models.Model):
    firstname = models.CharField(max_length=25, null=True)
    lastname = models.CharField(max_length=25, null=True)
    address = models.CharField(max_length=100, null=True)
    weight = models.DecimalField(null=True, max_digits=3, decimal_places=1)
    height = models.IntegerField(null=True)
    age = models.IntegerField(null=True)

    avatar = models.IntegerField(null=False, default=1)

    past_illnesses = ArrayField(
        models.CharField(max_length=25), null=True
    )
    allergies = ArrayField(
        models.CharField(max_length=25), null=True
    )
    chronic_diseases = ArrayField(
        models.CharField(max_length=25), null=True
    )
    undergone_operations = ArrayField(
        models.CharField(max_length=25), null=True
    )
    used_drugs = ArrayField(
        models.CharField(max_length=25), null=True
    )


class Member(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    member_username = models.CharField(max_length=50, null=False, unique=True)
    banned_by = models.CharField(max_length=50, null=True, default=None)  # username of admin

    info = models.ForeignKey(MemberInfo, null=False, on_delete=models.CASCADE)

    def __str__(self):
        retval = ""
        if self.info.firstname != None:
            retval += self.info.firstname + " "
        if self.info.lastname != None:
            retval += self.info.lastname
        
        if retval != "":
            return retval

        return self.member_username


class Category(models.Model):
    name = models.CharField(max_length=50, null=False, unique=True)
    definition = models.CharField(max_length=100, null=True)


class Doctor(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    full_name = models.CharField(max_length=50, null=False)
    specialization = models.ForeignKey(Category, null=True, on_delete=models.SET_NULL)
    hospital_name = models.CharField(max_length=100, null=True)
    verified = models.BooleanField(max_length=100, null=False, default=False)
    document = models.TextField(null=True, default=None)
    profile_picture = models.TextField(null=True)

    def __str__(self):
        return self.full_name


class Report(models.Model):
    reporter_user = models.ForeignKey(CustomUser, null=False, on_delete=models.CASCADE, related_name='reporter_user')
    reported_user = models.ForeignKey(CustomUser, null=False, on_delete=models.CASCADE, related_name='reported_user')
    message = models.CharField(max_length=500, null=False)
    date = models.DateField(null=False, default=datetime.date.today)
    reviewed_by = models.ForeignKey(CustomAdmin, null=True, default=None, on_delete=models.SET_NULL, related_name='reviewed_by')
    reviewed_date = models.DateField(null=True)


    def __str__(self):
        return self.message


class Label(models.Model):
    name = models.CharField(max_length=100, null=False)

