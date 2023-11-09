import 'package:chat_app_project/functions/clientUser.dart';
import 'package:chat_app_project/screen/registrationScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController useremailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    useremailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Log In with Details',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 18),
              TextFormField(
                controller: useremailController,
                decoration: InputDecoration(
                  labelText: 'User Email',
                  hintText: 'Enter Email ID',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter Your Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    String username = useremailController.text;
                    String password = passwordController.text;
                    loginUser(username, password, context);
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(fontSize: 22),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => regScreen()),
                  );
                },
                child: Center(child: Text('For Register please click here...')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
