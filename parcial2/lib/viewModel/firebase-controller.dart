import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token fcm: $fCMToken');
    if (fCMToken != null) {
      final Map<String, dynamic> requestBody = {
        'token': fCMToken,
      };

      final token = await getToken();
      http.Response response = await http.post(
        Uri.parse('http://192.168.56.1:8000/api/fcm/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token'
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
      } else {
        print('Failed to send FCM token');
      }
    } else {
      print('Token FCM is null. Cannot send to the server.');
    }
  }

  //Obtener token
  static Future<String?> getToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'login_token');
  }
}