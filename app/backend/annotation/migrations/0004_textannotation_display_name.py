# Generated by Django 4.1.2 on 2022-12-18 13:45

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('annotation', '0003_textannotation_author_link'),
    ]

    operations = [
        migrations.AddField(
            model_name='textannotation',
            name='display_name',
            field=models.CharField(default='', max_length=100),
        ),
    ]
