# Generated by Django 4.1.2 on 2022-11-19 21:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='customuser',
            name='profile_picture',
            field=models.TextField(null=True),
        ),
    ]