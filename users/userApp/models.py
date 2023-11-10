from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager

#clase Manager para la creacion de usuarios
class Manager_account(BaseUserManager):
    def create_user(self,email,img,cargo,tel,name,password=None,):
        
        
        user = self.model(
            email=email,
            img=img,
            tel=tel,
            cargo=cargo,
            name = name,
        )
        
        user.set_password(password)
        user.is_active = True
        user.save(using = self._db)
        return user
    
    def create_superuser(self,email,username,password):
        
        user = self.create_user(
            email=email,
            username = username
        )
        
        user.set_password(password)
        user.is_admin = True
        user.is_active = True
        user.is_staff = True
        user.is_superuser = True
        user.save(using = self._db)
        return user

#clase de usuario
class User(AbstractBaseUser):
    #atributos del usuario
    email = models.EmailField(max_length=200,unique=True)
    name = models.CharField(max_length=100,unique=True)
    img = models.ImageField(upload_to='imgs/profile_img', null=True)
    tel = models.CharField(max_length=10,unique=True)
    cargo = models.CharField(max_length=50,default='auxiliar')

    
    #atributos de django
    date_joined = models.DateTimeField(auto_now_add=True)
    last_login = models.DateTimeField(auto_now_add=True)
    
    #roles de django
    is_admin = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    is_active = models.BooleanField(default=False)
    
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['name','img','tel','cargo']
    
    objects = Manager_account() #instanciamos la clase
    
    #valores a pintar al listar los usuarios
    def __str__(self):
        return self.name
    
    def has_perm(self,perm,obj=None):
        return self.is_superuser
    
    def has_module_perms(self,add_label):
        return True
    
    
#modelo par FCM
class UserFCM(models.Model):
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    token = models.CharField(max_length=300,unique=True)
    
    
