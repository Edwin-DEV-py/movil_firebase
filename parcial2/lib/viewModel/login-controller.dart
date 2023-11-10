// ignore_for_file: prefer_const_constructors

import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class LoginController{
  static Future<String> fetchAuthToken(BuildContext context,String email, String password) async {
    final Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    //mandamos la peticion a la API
    final response = await http.post(
      Uri.parse('http://192.168.56.1:8000/api/token/'), //esta ip se utiliza para que flutter pueda acceder al servidor django. (ip d ela maquina local)
        headers: <String, String>{
          'Content-Type': 'application/json'
        },
        //serializar el cuerpo
        body: json.encode(requestBody),
      );

      //evaluamos la respuesta
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['access'];

        //Guardamos el token
        await saveToken(token);
        print(data);
        if (token != null){
          Navigator.pushNamed(context, '/home');
        }
        return data['access']; //obtenemos el token
      } else {
        throw Exception('Failed to authenticate');
      }
    }

  //Guardar token
  static Future<void> saveToken(String token) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'login_token', value: token);
  }
}
