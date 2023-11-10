from rest_framework.views import APIView
from django.shortcuts import render,redirect
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from rest_framework.decorators import api_view, permission_classes
from django.conf import settings
from .serializers import *
from django.contrib.auth import get_user_model,logout
from .models import User
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login
from rest_framework.pagination import PageNumberPagination
from rest_framework.generics import ListAPIView
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.generics import *
from rest_framework.parsers import FileUploadParser, MultiPartParser, FormParser
from django.db import IntegrityError


#registro de usuario en la API    
class Register(APIView):
    parser_classes = (MultiPartParser, FormParser)
    def post(self,request,*args, **kwargs):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():       
            #crear el usuario
            user = User.objects.create_user(**serializer.validated_data)
            user.save()
            
            return Response({'message': 'Usuario registrado'}, status=status.HTTP_201_CREATED)
        else:
            print(serializer.errors)  # Imprime los errores de validación en la consola
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
class UsersView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self,request):
        users = User.objects.exclude(id=request.user.id)
        serializers = UserSerializer(users,many=True)
        return Response(serializers.data)
    
class TokenFCM(APIView):
    permission_classes = [IsAuthenticated]
    def post(self,request):
        try:
            user = request.user.id
            fcm = request.data.get('token')
            data = {
                'user':user,
                'token':fcm
            }
            print(data)
            serializers = UserFCMSerializers(data=data)
            try:    
                if serializers.is_valid():
                    serializers.save()
                    return Response(serializers.data)
            except IntegrityError:
                pass
            
            return Response(serializers.errors)
        except:
            return Response({'message':'usuario invalido'})
        