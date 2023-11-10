# Generated by Django 4.2.3 on 2023-11-08 01:28

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('chat', '0002_alter_message_chat_email_addressee'),
    ]

    operations = [
        migrations.AlterField(
            model_name='message_chat',
            name='email_addressee',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='addressee', to=settings.AUTH_USER_MODEL),
        ),
    ]
