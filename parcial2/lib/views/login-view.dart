// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial2/viewModel/firebase-controller.dart';
import 'package:parcial2/viewModel/login-controller.dart';
import 'package:parcial2/views/register-view.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //campos del formulario
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//contenedor del titulo de la ventana
              Container(
                width: 380,
                height: 60,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Inicia Sesion!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('mantente comunicado siempre con tu equipo',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
//contenedor de los inputs del formulario
              Container(
                width: 380,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 350,
                                child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  labelText: 'Correo',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0)
                                  )
                                ),
                              ),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                width: 350,
                                child: TextField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.password_outlined),
                                    labelText: 'Contraseña',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0)
                                    )
                                  ),
                                  obscureText: true,
                                ),
                              ),
                              SizedBox(height: 30,)
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
//contenedor para el boton de regiustrarse o ir a al login//contenedor para el boton de loguearse o ir a al registro
              Container(
                width: 380,
                height: 80,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async{
                            LoginController.fetchAuthToken(context,_emailController.text, _passwordController.text);
                            await FirebaseApi().initNotifications();
                          }, 
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(350, 50),
                            backgroundColor: Colors.black
                          ),
                          child: Text('Iniciar sesion', style: TextStyle(
                            fontSize: 20
                          ),)
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 15,),
                        Text('No tienes una cuenta? ', style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic
                        ),),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => Register(), transition: Transition.circularReveal, duration: Duration(seconds: 1));
                          },
                          child: Text(
                            'Registrate!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 247, 224, 22),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}