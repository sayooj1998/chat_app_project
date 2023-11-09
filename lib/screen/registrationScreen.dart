import 'package:chat_app_project/functions/clientUser.dart';
import 'package:chat_app_project/screen/login.dart';
import 'package:flutter/material.dart';

class regScreen extends StatefulWidget {
  const regScreen({Key? key}) : super(key: key);

  @override
  State<regScreen> createState() => _regScreenState();
}

class _regScreenState extends State<regScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        backgroundColor: Color.fromARGB(255, 28, 168, 25),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 40, 8, 30),
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Center(
                      child: Text(
                        'Register with Details',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Image.asset(
                      'assets/msg.png',
                      height: 120,
                      width: 150,
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'User Name',
                      hintText: 'create a User Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your Email ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Create a Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Your Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          if (_passwordController.text ==
                              _confirmPasswordController.text) {
                            String username = _usernameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;

                            _confirmPasswordController.text;

                            registerUser(username, email, password, context);
                          } else {
                            print('password does not match');
                          }
                        },
                        child: const Text('Register',
                            style: TextStyle(fontSize: 22)),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        )),
                  ),
                  const SizedBox(height: 1),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Already have an account? Log In'),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
