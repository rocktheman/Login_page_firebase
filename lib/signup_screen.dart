import 'package:fire_base/reuseable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  String err = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )),
      body: Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(16.0),
          color: Colors.blueGrey[600],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 350),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              reuseableTextField("Enter UserName", Icons.person_outline, false,
                  _userNameTextController),
              SizedBox(
                height: 20,
              ),
              reuseableTextField("Enter Email ID", Icons.person_outline, false,
                  _emailTextController),
              SizedBox(
                height: 20,
              ),
              reuseableTextField("Enter Password", Icons.lock_outline, true,
                  _passwordTextController),
              signInSignupButton(context, false, () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
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
              }),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  err,
                  style: const TextStyle(color: Colors.red),
                )
              ])


            ],
          ),
        ),
      ),
    );
  }
}
