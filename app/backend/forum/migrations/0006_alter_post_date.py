# Generated by Django 4.1.2 on 2022-12-03 21:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('forum', '0005_alter_comment_latitude_alter_comment_longitude_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='post',
            name='date',
            field=models.DateTimeField(verbose_name='y-m-d'),
        ),
    ]