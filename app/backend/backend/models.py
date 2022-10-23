# from backend.auth_system import models
# from backend.follow_system import models
# from backend.profile_management import models

from django.db import models
from django.contrib.postgres.fields import ArrayField
import datetime

class User(models.Model):
    password = models.CharField(max_length=200, null=False)
    email = models.CharField(max_length=100, null=False, unique=True)

    type = models.IntegerField(null=False)

    def __str__(self):
        return self.email


class Admin(User):
    # user = models.ForeignKey(User, on_delete=models.CASCADE)
    username = models.CharField(max_length=50, null=False, unique=True)

    def __str__(self):
        return self.username

class MemberInfo(models.Model):
    firstname = models.CharField(max_length=25, null=False)
    lastname = models.CharField(max_length=25, null=False)
    address = models.CharField(max_length=100, null=True)
    weight = models.DecimalField(null=True, max_digits=3, decimal_places=1)
    height = models.IntegerField(null=True)
    age = models.IntegerField(null=True)

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


class Member(User):
    username = models.CharField(max_length=50, null=False, unique=True)
    banned_by = models.CharField(max_length=50, null=True, default=None)  # username of admin

    info = models.ForeignKey(MemberInfo, null=False, on_delete=models.CASCADE)

    def __str__(self):
        retval = ""
        if self.info.firstname != None:
            retval += self.info.firstname + " "
        if self.info.lastname != None:
            retval += self.info.firstname
        
        if retval != "":
            return retval

        return self.username


class Category(models.Model):
    name = models.CharField(max_length=50, null=False, unique=True)
    definition = models.CharField(max_length=100, null=True)


class Doctor(User):
    full_name = models.CharField(max_length=50, null=False)
    specialization = models.ForeignKey(Category, null=True, on_delete=models.SET_NULL)
    hospital_name = models.CharField(max_length=100, null=True)
    verified = models.BooleanField(max_length=100, null=False, default=False)

    def __str__(self):
        return self.full_name


class Report(models.Model):
    reporter_user = models.ForeignKey(User, null=False, on_delete=models.CASCADE, related_name='reporter_user')
    reported_user = models.ForeignKey(User, null=False, on_delete=models.CASCADE, related_name='reported_user')
    message = models.CharField(max_length=500, null=False)
    date = models.DateField(null=False, default=datetime.date.today)
    reviewed_by = models.ForeignKey(Admin, null=True, default=None, on_delete=models.SET_NULL, related_name='reviewed_by')
    reviewed_date = models.DateField(null=True)


    def __str__(self):
        return self.message
