// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parcial2/viewModel/firebase-controller.dart';
import 'package:parcial2/viewModel/register-controller.dart';
import 'package:parcial2/views/login-view.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  //campos del formulario
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _telController = TextEditingController();
  final _cargoController = TextEditingController();
  XFile? _imagePath;
  final _passwordController = TextEditingController();

  //Seleccionar imagen
  Future<void> select() async{
    final pick = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pick != null){
      setState(() {
        _imagePath = pick;
        print("Selected image path: ${_imagePath?.path}");
      });
    }
  }

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
                        Text('Registrate!',
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
                        Text('Registrate para conectarte con el equipo',
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
                height: 500,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 350,
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person_outlined),
                                  labelText: 'Nombre Completo',
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
                                controller: _telController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone),
                                  labelText: 'Telefono',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0)
                                  )
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              width: 350,
                              child: TextField(
                                controller: _cargoController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.engineering),
                                  labelText: 'Cargo',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0)
                                  )
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              width: 350,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.photo),
                                    onPressed: select,
                                  )
                                ],
                              )
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
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
//contenedor para el boton de regiustrarse o ir a al login
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
                            await RegisterController.fetchAuthToken(
                              context,
                              _nameController.text, 
                              _emailController.text, 
                              _passwordController.text, 
                              int.parse(_telController.text), 
                              _cargoController.text, 
                              _imagePath!
                            );
                            await FirebaseApi().initNotifications();
                          }, 
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(350, 50),
                            backgroundColor: Colors.black
                          ),
                          child: Text('Registrate', style: TextStyle(
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
                        Text('Si ya tienes una cuenta ', style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic
                        ),),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => Login(), transition: Transition.zoom);
                          },
                          child: Text(
                            'Inicia sesión!',
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