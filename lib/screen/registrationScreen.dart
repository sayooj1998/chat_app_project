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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  String? _usernameValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter your User Name';
    }
    return null;
  }

  String? _emailValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter your Email Id';
    }
    return null;
  }

  String? _passwordValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter your User Password';
    }
    return null;
  }

  String? _cpasswordValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Confirm Password ';
    }

    return null;
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
        title: const Text('Chat App'),
        backgroundColor: Color.fromARGB(255, 28, 168, 25),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 40, 8, 30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/chatapplogo.png',
                      height: 200,
                      width: 300,
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
                    validator: _usernameValidate,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your Email ID',
                      border: OutlineInputBorder(),
                    ),
                    validator: _emailValidate,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Create a Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: _passwordValidate,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Your Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: _cpasswordValidate,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            if (_passwordController.text ==
                                _confirmPasswordController.text) {
                              String username = _usernameController.text;
                              String email = _emailController.text;
                              String password = _passwordController.text;

                              _confirmPasswordController.text;

                              registerUser(username, email, password, context);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Center(
                                          child: Text('Warning...')),
                                      content: const Text(
                                          'Passsword does not match'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  });
                            }
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
