import 'package:chat_app_project/screen/contact.dart';
import 'package:chat_app_project/screen/drawer.dart';
import 'package:chat_app_project/screen/home.dart';
import 'package:chat_app_project/screen/login.dart';
import 'package:chat_app_project/screen/registrationScreen.dart';
import 'package:chat_app_project/screen/splashScreen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter(MessageBoxAdapter());
  // await Hive.openBox<Message_Box>('messagesBox');

  runApp(MaterialApp(
    initialRoute: '/splashScreen',
    routes: {
      '/home': (context) => Home(),
      '/registrationScreen': (context) => regScreen(),
      '/drawer': (context) => drawerpage(),
      '/login': (context) => LoginScreen(),
      '/splashScreen': (context) => splashScreen(),
      //'/contact': (context) => ContactListScreen()
    },
  ));
}
