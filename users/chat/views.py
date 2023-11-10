from rest_framework.views import APIView
from django.shortcuts import render,redirect
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from rest_framework.decorators import api_view, permission_classes
from .serializers import *
from .models import *
from userApp.models import User, UserFCM
from django.db.models import Q
from pyfcm import FCMNotification


class MessageView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self,request):
        user=request.user.id
        user2=request.GET.get('addressee')
        message = Message_chat.objects.filter(
            Q(email_sender=user, email_addressee=user2) |
            Q(email_sender=user2, email_addressee=user)
        ).order_by('id')
        serializers = Message_chatSerializer(message,many=True)
        return Response(serializers.data)
    
    def post(self,request):
        user=request.user.id
        user2=request.data.get('addressee')
        title=request.data.get('title')
        body=request.data.get('body')
        
        #bbuscar tokens y crear una lista
        tokens1 = UserFCM.objects.filter(user=user2).values_list('id',flat=True)
        tokens_list = list(tokens1)
        
        tokens2 = UserFCM.objects.filter(user=user2).values_list('token',flat=True)
        tokens_list2 = list(tokens2)
        
        data = {
            'title':title,
            'body':body,
            'email_sender':user,
            'email_addressee':user2,
            'token_list':str(tokens_list),
            'response_firebase':'fff'
        }
        send_push_notification(tokens_list2,title,body)
        
        serializers = Message_chatSerializer(data=data)
        if serializers.is_valid():
            serializers.save()
            return Response(serializers.data, status=status.HTTP_201_CREATED)
        else:
            print(serializers.errors)
            return Response(serializers.errors, status=status.HTTP_400_BAD_REQUEST)
        

def send_push_notification(tokens,title,body):
    push = FCMNotification(api_key='AAAAOys6nYo:APA91bH6_yClAZPOBwtK8c9FCj9j0YEOekKZoCdsWVpIMtsYZddL-omGiQN-6G2kJ-jB6jvM67Hpp-4FQ61ULdXkEq3BeGD9oSbGqm2dsL-QdSmWP3fI3Bop5TLICZ2A2wzqfCvif1K9')
    message = {
        "registration_ids": tokens,
        "notification": {
            "title": title,
            "body": body,
        }
    }
    
    result = push.notify_multiple_devices(registration_ids=tokens,message_title=title,message_body=body)
    print(result)
