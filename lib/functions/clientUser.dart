import 'package:chat_app_project/models/usermodel.dart';
import 'package:chat_app_project/screen/login.dart';
import 'package:chat_app_project/screen/registrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//log in user.........................

Future<void> loginUser(
    String username, String password, BuildContext context) async {
  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
            child: SpinKitThreeBounce(
          color: Colors.blue,
          size: 50.0,
        ));
      },
    );
    final String apiUrl = 'https://dev1.bo-l.com/';

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
      final Map<String, dynamic> responseData = json.decode(response.body);

      final String userNameFromServer = responseData['username'];
      final int userIdFromServer = responseData['userid'];
      var logedPersonRoom = responseData['room_id'];
      var token = responseData['token'];

      // print(token);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);

      SharedPreferences room = await SharedPreferences.getInstance();
      room.setString('room_id', logedPersonRoom);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: {'userName': userNameFromServer, 'userId': userIdFromServer},
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Log in failed: ${response.reasonPhrase}'),
          backgroundColor: Colors.red,
        ),
      );

      print('Log in failed: ${response.reasonPhrase}');
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login');
    }
  } catch (e) {
    print(e);
  }
}

// store to shered preferences

Future<String> getTokenFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('token') ?? '';
}

Future<String> getRoomId() async {
  SharedPreferences room = await SharedPreferences.getInstance();

  return room.getString('room_id') ?? '';
}
//register user.............................

Future<void> registerUser(String username, String email, String password,
    BuildContext context) async {
  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: SpinKitThreeBounce(
            color: Colors.blue,
            size: 50.0,
          ),
        );
      },
    );
    const String apiUrl = 'https://dev1.bo-l.com/';
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
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: ${response.reasonPhrase}'),
          backgroundColor: Colors.red,
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => regScreen()),
      );

      print('Registration failed: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e);
  }
}

//fetch all user.....................................

Future<List<UserList>> fetchRegisteredUsers() async {
  try {
    String token = await getTokenFromSharedPreferences();
    final String apiUrl = 'https://dev1.bo-l.com/';
    final response = await http.get(
      Uri.parse('$apiUrl/user_list'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
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
    // print(e);
    return [];
  }
}

//msg receive fun................

Future<List<ChatMessage>> fetchMessages(int loginId, chatPersonId) async {
  try {
    print(loginId);
    print(chatPersonId);

    final String apiUrl = 'https://dev1.bo-l.com/';
    String token = await getTokenFromSharedPreferences();
    final response = await http.post(
      Uri.parse('$apiUrl/chat_flutter'),
      body: jsonEncode({
        'login_Id': loginId,
        'chat_PersonId': chatPersonId,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<ChatMessage> receivedMessages =
          data.map((messageData) => ChatMessage.fromJson(messageData)).toList();
      print(receivedMessages);

      return receivedMessages;
    } else {
      throw Exception('Failed to load messages ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e);
    return [];
  }
}

//log out ...........................
Future<void> logoutUser(BuildContext context) async {
  try {
    // Show loading screen
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: SpinKitThreeBounce(
            color: Colors.blue,
            size: 50.0,
          ),
        );
      },
    );
    final String apiUrl = 'https://dev1.bo-l.com/';
    String token = await getTokenFromSharedPreferences();
    final response = await http.get(
      Uri.parse('$apiUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      SharedPreferences room = await SharedPreferences.getInstance();
      await room.clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    } else {
      print('Logout failed: ${response.reasonPhrase}');
    }
  } catch (e) {
    print(e);
  }
}
