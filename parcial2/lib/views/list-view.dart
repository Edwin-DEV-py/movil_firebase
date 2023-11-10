// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:parcial2/viewModel/message-controller.dart';
import 'package:parcial2/views/profile-view.dart';

class UserContainer extends StatelessWidget{

  //datos a mostrar en la lista
  final int id;
  final String name;
  final String email;
  final String tel;
  final String cargo;
  final String img;
  const UserContainer({
    Key? key,
    required this.id,
    required this.name,
    required this.email,
    required this.tel,
    required this.cargo,
    required this.img
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: (){
          Navigator.push(context, 
            MaterialPageRoute(builder: (context)=> Profile(
              id: id,
              name: name, 
              email: email, 
              tel: tel, 
              cargo: cargo, 
              img: img)
            )
          );
          MessageController2.fetchMessage(id);
        },
        style:  ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 255, 232, 26),fixedSize: Size(400, 120)),
        child: Container(
        width: double.infinity,
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
//contenido de la imagen
            Column(
              children: [
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:  ClipOval(
                    child: Image(image: NetworkImage('http://192.168.56.1:8000$img'), width: 120, height: 120, fit: BoxFit.cover,),
                  ),
                )
              ],
            ),
            SizedBox(width: 10,),
//contenido del nombre y correo
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
      )
    );
  }
}