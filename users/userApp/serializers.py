from rest_framework import serializers
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError
from .models import *

class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True,style={'input_type': 'password'})
    class Meta:
        model = User
        fields = ('id','name','email','password','img','tel','cargo')
        
    #validamos la contrasena
    def validate_password(self, value):
        try:
            validate_password(value)
        except ValidationError as e:
            raise serializers.ValidationError(str(e))
        return value
    
    #se crea una nueva instancia del user usando el metodo create_user
    def create(self, validated_data):
        password = validated_data['password']
        user = User.objects.create_user(password=password,**validated_data)
        return user
    
class UserFCMSerializers(serializers.ModelSerializer):
    class Meta:
        model = UserFCM
        fields = '__all__'