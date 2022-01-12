import 'dart:html';

import 'package:fire_base/home_screen.dart';
import 'package:fire_base/reuseable_widget.dart';
import 'package:fire_base/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fire_base/reuseable_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  String err = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Sign In",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )),
      body: Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(16.0),
          color: Colors.blueGrey[600],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 350),
          child: Column(children: <Widget>[
            SizedBox(
              height: 30,
            ),
            reuseableTextField("Enter Email ID", Icons.person_outline, false,
                _emailTextController),
            SizedBox(
              height: 20,
            ),
            reuseableTextField("Enter Password", Icons.lock_outline, true,
                _passwordTextController),
            SizedBox(
              height: 20,
            ),
            signInSignupButton(context, true, () {
              err = "";
              if (_emailTextController.text.length > 10 &&
                  _emailTextController.text.contains('@') &&
                  _passwordTextController.text.length >= 6) {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }).onError((error, stackTrace) {
                  print("Error${error.toString()}");

                  setState(() {
                    err = error.toString();
                  });
                });
              } else {
                String err1 = '';
                if (_emailTextController.text.length <= 10 ||
                    _emailTextController.text.contains('@') == false) {
                  err1 = err1 +
                      "\n Email must have more than 10 characters & must have @ symbol";
                }
                if (_passwordTextController.text.length < 6) {
                  err1 = err1 + "\n Password must have at least 6 characters";
                }
                setState(() {
                  err = err1;
                });
              }
            }),
            signUpOption(),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                err,
                style: const TextStyle(color: Colors.red),
              )
            ])
          ]),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Dont have an Account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
