from rest_framework import serializers
from .models import *

class Message_chatSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message_chat
        fields = '__all__'