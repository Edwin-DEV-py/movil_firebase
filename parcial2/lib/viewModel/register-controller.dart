import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RegisterController{
  static Future<String> fetchAuthToken(BuildContext context,String name, String email, String password, int tel, String cargo, XFile img) async{
    final Map<String, String> requestBody = {
      'name': name,
      'email': email,
      'password':password,
      'tel':tel.toString(),
      'cargo':cargo
    };

    //mandamos la peticion a la API
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.56.1:8000/api/register/'),
    );

    request.fields.addAll(requestBody);

    //agregar la magen a la respuesta
    request.files.add( await http.MultipartFile.fromPath(
      'img', img.path
    ));

    //enviamos los datos a la API
    final response = await http.Response.fromStream(await request.send());
    

    //evaluamos la respuesta
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        Navigator.pushNamed(context,'/home');
        print(data);
        return data['message'];
      } else {
        throw Exception('Failed to authenticate');
      }
  }
}