# Generated by Django 4.1.2 on 2022-12-04 10:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0004_label'),
        ('forum', '0009_alter_comment_date_alter_post_date'),
    ]

    operations = [
        migrations.AddField(
            model_name='post',
            name='labels',
            field=models.ManyToManyField(to='backend.label'),
        ),
    ]