# Generated by Django 4.1.2 on 2022-12-18 15:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('annotation', '0006_textannotation_date_modified_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='imageannotation',
            name='date_modified',
            field=models.DateTimeField(null=True),
        ),
        migrations.AlterField(
            model_name='imageannotation',
            name='date_created',
            field=models.DateTimeField(null=True),
        ),
    ]
