# Generated by Django 4.1.2 on 2022-12-17 10:32

import django.contrib.postgres.fields
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0004_label'),
    ]

    operations = [
        migrations.AddField(
            model_name='customuser',
            name='followed_categories',
            field=django.contrib.postgres.fields.ArrayField(base_field=models.IntegerField(null=True), default=list, size=None),
        ),
    ]
