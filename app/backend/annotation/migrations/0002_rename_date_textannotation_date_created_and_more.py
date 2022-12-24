# Generated by Django 4.1.2 on 2022-12-18 13:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('annotation', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='textannotation',
            old_name='date',
            new_name='date_created',
        ),
        migrations.RemoveField(
            model_name='textannotation',
            name='body',
        ),
        migrations.AddField(
            model_name='textannotation',
            name='exact',
            field=models.TextField(default=''),
        ),
        migrations.AddField(
            model_name='textannotation',
            name='purpose',
            field=models.CharField(default='', max_length=100),
        ),
        migrations.AddField(
            model_name='textannotation',
            name='value',
            field=models.TextField(default=''),
        ),
        migrations.AlterField(
            model_name='textannotation',
            name='id',
            field=models.CharField(max_length=100, primary_key=True, serialize=False),
        ),
    ]