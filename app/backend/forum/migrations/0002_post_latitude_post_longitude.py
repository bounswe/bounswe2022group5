# Generated by Django 4.1.2 on 2022-11-27 18:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('forum', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='post',
            name='latitude',
            field=models.FloatField(default=0),
        ),
        migrations.AddField(
            model_name='post',
            name='longitude',
            field=models.FloatField(default=0),
        ),
    ]
