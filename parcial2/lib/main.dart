// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcial2/viewModel/users_list-controller.dart';
import 'package:parcial2/views/login-view.dart';
import 'package:parcial2/views/register-view.dart';
import 'package:parcial2/views/welcome-view.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/login':(context) => Login(),
        '/welcome':(context) => Welcome(),
        '/register':(context) => Register(),
        '/home':(context) => UserList()
      },
    );
  }
}
