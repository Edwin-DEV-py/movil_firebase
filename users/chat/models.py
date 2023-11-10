from django.db import models
from userApp.models import User

class Message_chat(models.Model):
    title = models.CharField(max_length=30)
    body = models.CharField(max_length=255)
    email_sender = models.ForeignKey(User,on_delete=models.CASCADE,related_name='sender')
    email_addressee = models.ForeignKey(User,on_delete=models.CASCADE,related_name='addressee')
    token_list = models.CharField(max_length=500)
    response_firebase = models.CharField(max_length=255)