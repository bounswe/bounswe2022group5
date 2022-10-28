// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bounswe5_mobile/screens/home.dart';
import 'package:bounswe5_mobile/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar at the top of the app
      appBar: AppBar(
        title: const Center(
          child: Text('Logo',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        elevation: 0.0,

      ),
      body: Center(
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
                  color: Colors.blue[900]),
            ),
            Text(
              'for user benefits!',
              style: TextStyle(
                fontSize: 40,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 10),

            // E-mail field
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                  decoration: InputDecoration(
                hintText: 'E-mail',
              )),
            ),

            // Password field
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  )),
            ),

            // Login button below user information
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: Text(
                  'Login',
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                )),
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
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupPage()),
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
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
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
    );
  }
}
