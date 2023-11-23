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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isHiden = true;
  @override
  void initState() {
    super.initState();
    useremailController = TextEditingController();
    passwordController = TextEditingController();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    return null;
  }

  void passwordHider() {
    setState(() {
      isHiden = !isHiden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Log In with Details',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 22),
                  Image.asset('assets/chatapplogo.png'),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: useremailController,
                    decoration: const InputDecoration(
                      labelText: 'User Email',
                      hintText: 'Enter Email ID',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isHiden,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter Your Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: passwordHider,
                          child: Icon(
                            isHiden ? Icons.visibility_off : Icons.visibility,
                          ),
                        )),
                    validator: _validatePassword,
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          String username = useremailController.text;
                          String password = passwordController.text;
                          loginUser(username, password, context);
                        } // buildLoginUserFutureBuilder();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          fixedSize: Size(150, 50)),
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => regScreen()),
                      );
                    },
                    child: const Center(
                        child: Text('For Register please click here...')),
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
