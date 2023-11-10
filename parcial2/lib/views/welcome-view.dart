// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parcial2/views/login-view.dart';
import 'package:parcial2/views/register-view.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//contenedor del titulo de la aplicacion
              Container(
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Chat UPB', style: GoogleFonts.lobster(
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    )
                    )
                  ],
                ),
              ),
//contenedor de la imagen
              Container(
                width: double.infinity,
                height: 450,
                child: Image.asset('assets/welcome.gif', ),
              ),
//boton para ir a iniciar sesion
              ElevatedButton(
                onPressed: (){
                  Get.to(() => Login(), transition: Transition.upToDown, duration: Duration(seconds: 1));
                }, 
                child: Text('Iniciar Sesion',
                    style:  TextStyle(
                      fontSize: 20
                    ),
                  ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  fixedSize: Size(250,40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
              ),
              SizedBox(height: 10,),
//Boton para ir a registrarse
              ElevatedButton(
                onPressed: (){
                  Get.to(() => Register(), transition: Transition.downToUp, duration: Duration(seconds: 1));
                }, 
                child: Text('Registrarse',
                    style:  TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    ),
                  ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 247, 224, 22),
                  fixedSize: Size(250,40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.black, width: 2.0)
                  )
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 247, 224, 22),
    );
  }
}