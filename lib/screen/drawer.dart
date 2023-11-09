import 'package:chat_app_project/screen/chatScreen.dart';
import 'package:chat_app_project/screen/login.dart';
import 'package:chat_app_project/screen/registrationScreen.dart';
import 'package:flutter/material.dart';

class drawerpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 28, 168, 25),
            ),
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'Chat App',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.app_registration_outlined,
              color: Colors.blue,
            ),
            title: const Text('Register'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => regScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.login,
              color: Colors.blue,
            ),
            title: const Text('LogIn'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.chat,
          //     color: Colors.blue,
          //   ),
          //   title: const Text('chat'),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => chatScreen()));
          //   },
          // ),
        ],
      ),
    );
  }
}
