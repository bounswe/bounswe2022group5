// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bounswe5_mobile/screens/home.dart';
import 'package:bounswe5_mobile/screens/signup.dart';
import 'package:bounswe5_mobile/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../API_service.dart';

bool isEmail(String em) {
  //validator for email
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool isMember = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar at the top of the app
      appBar: myAppBar,
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            // To prevent an exception when using keyboard on phone
            child: Column(children: [
              // Text for Login
              Text(
                'Login',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 60,
                    color: Theme.of(context).primaryColorDark),
              ),
              Text(
                'for user benefits!',
                style: TextStyle(
                  fontSize: 40,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              SizedBox(height: 10),

              // E-mail field
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                    prefixIcon: Icon(Icons.email_rounded),
                  ),
                  // Error if user gives unwanted input
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!isEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),

              // Password field
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _pass,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    // Error if user gives unwanted input
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),

              // Login button below user information
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      int type;
                      String token =
                          await ApiService().login(_email.text, _pass.text);
                      if (token != 'Error') {
                        // If logged-in successfully, go to the Home page
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                    token: token,
                                    index: 0,
                                  )),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Could not log-in. Check your information.')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )),
                  ),
                ),
              ),

              // User can sign up if they don't have account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()),
                      );
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.orange[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text('!'),
                ],
              ),

              // A sized box for seperating texts
              SizedBox(height: 50),

              // continue without login button
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              token: '-1',
                              index: 0
                            )),
                  );
                },
                child: Text(
                  'Continue without logging in',
                  style: TextStyle(
                    color: Colors.black38,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
