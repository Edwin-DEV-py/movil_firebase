// ignore_for_file: prefer_const_constructors

import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class MessageController{
  static Future<String> fetchMessage(String title, String body, int addressee) async{
    final Map<String, dynamic> requestBody = {
      'title':title,
      'body':body,
      'addressee':addressee
    };

    final token = await getToken();
    //mandamos la peticion a la API
    final response = await http.post(
      Uri.parse('http://192.168.56.1:8000/api/message/'),
      headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token'
        },
      //serializar el cuerpo
      body: json.encode(requestBody),
    );

    //evaluamos la respuesta
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        print(data);
        return "mensaje enviado";
      } else {
        throw Exception('Failed to authenticate');
      }
  }

  //Obtener token
  static Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'login_token');
  }
}

class MessageController2{
  static Future<List<Map<String, dynamic>>>fetchMessage(int addressee) async{

    final token = await getToken();
    //mandamos la peticion a la API
    final response = await http.get(
      Uri.parse('http://192.168.56.1:8000/api/message/?addressee=$addressee'),
      headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token'
        },
    );

    //evaluamos la respuesta
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> messages = List<Map<String, dynamic>>.from(data);
        print(data);
        return messages;
      } else {
        throw Exception('Failed to authenticate');
      }
  }

  //Obtener token
  static Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'login_token');
  }
}