import 'package:chat_app_project/screen/chatScreen.dart';
import 'package:chat_app_project/screen/drawer.dart';
import 'package:chat_app_project/screen/home.dart';
import 'package:chat_app_project/screen/login.dart';
import 'package:chat_app_project/screen/registrationScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/home': (context) => Home(),
      '/registrationScreen': (context) => regScreen(),
      '/drawer': (context) => drawerpage(),
      '/login': (context) => LoginScreen(),
      '/chatscreen': (context) => chatScreen()
    },
  ));
}
