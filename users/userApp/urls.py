from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from .views import *

urlpatterns = [
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),  # Obtener token de acceso
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),  # Renovar token de acceso
    path('register/',Register.as_view(),name='register'), #vista para crear usuarios
    path('users/',UsersView.as_view(),name='users'), #vista de lista de usuarios
    path('fcm/',TokenFCM.as_view(),name='fcm'), #vista para guardar los tokens FCM
]