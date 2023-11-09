import 'package:chat_app_project/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String apiUrl = 'https://dev1.bo-l.com/';

//log in user.........................

Future<void> loginUser(
    String username, String password, BuildContext context) async {
  print('username $username');
  try {
    final response = await http.post(
      Uri.parse('$apiUrl/login2_flutter'),
      body: jsonEncode({
        'user_email': username,
        //'email': email,
        'user_password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Log in successful: ${response.body}');
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      print('Log in failed: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e);
  }
}

//register user.............................

Future<void> registerUser(String username, String email, String password,
    BuildContext context) async {
  print('username $password');
  try {
    final response = await http.post(
      Uri.parse('$apiUrl/register_flutter'),
      body: jsonEncode({
        'user_name': username,
        'user_email': email,
        'user_password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Registration successful: ${response.body}');
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      print('Registration failed: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e);
  }
}

//fetch all user.....................................

Future<List<UserList>> fetchRegisteredUsers() async {
  try {
    final response = await http.get(
      Uri.parse('$apiUrl/user_list'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      //var users = json.decode(response.body);
      List<dynamic> userJson = json.decode(response.body);
      List<UserList> users =
          userJson.map((data) => UserList.fromJson(data)).toList();
      //var alluser = UserList.fromJson(users);
      print(users);
      return users;
    } else {
      print('Failed to fetch users: ${response.reasonPhrase}');
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}

//fetch massage.........................................................

Future<List<Message>> fetchMessages(int loginId, chatPersonId) async {
  try {
    final response = await http.get(Uri.parse('$apiUrl/chat_flutter'));

    if (response.statusCode == 200) {
      print('success');
      List<dynamic> data = json.decode(response.body);
      List<Message> receivedMessages =
          data.map((messageData) => Message.fromJson(messageData)).toList();
      print(receivedMessages);
      return receivedMessages;
    } else {
      throw Exception('Failed to load messages');
    }
  } catch (e) {
    print(e);

    return [];
  }
}
