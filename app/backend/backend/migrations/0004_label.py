# Generated by Django 4.1.2 on 2022-12-04 10:36

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0003_doctor_document'),
    ]

    operations = [
        migrations.CreateModel(
            name='Label',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
            ],
        ),
    ]
