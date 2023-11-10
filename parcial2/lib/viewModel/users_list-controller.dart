import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:parcial2/models/user-model.dart';
import 'package:parcial2/views/list-view.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<UserModel> users = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  //obtener datos de la api
  Future<void> fetchData() async{
    try{
      final token = await getToken();
      http.Response response = await http.get(
        Uri.parse('http://192.168.56.1:8000/api/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token'
        }
      );
      var data = json.decode(response.body);
      data.forEach((us){
        UserModel user = UserModel(
          name: us['name'], 
          email: us['email'], 
          cargo: us['cargo'], 
          tel: us['tel'],
          img: us['img'],
          id: us['id']
        );
        users.add(user);
      });
      setState(() {
        users = users;
      });
      print('datos:$data');
    }catch(e){
      print(e);
    }
  }

  

  //Obtener token
  void logout() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'login_token');
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de usuarios'),backgroundColor: Colors.black, actions: [
        IconButton(
          onPressed: (){
            logout();
            Navigator.pushNamed(context, '/welcome');
          }, 
          icon: Icon(Icons.logout_outlined)
        )
      ],),
      body: ListView(
        children:
          users.map((e){
            return UserContainer(
              id: e.id,
              name: e.name, 
              email: e.email, 
              tel: e.tel,
              img: e.img,
              cargo: e.cargo);
          }).toList(),
      ),
    );
  }

  //Obtener token
  static Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'login_token');
  }
}