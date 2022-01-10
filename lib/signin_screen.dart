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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(16.0),
          color: Colors.cyan[400],
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            reuseableTextField("Enter UserName", Icons.person_outline, false,
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
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                  .then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }).onError((error, stackTrace) {
                print("Error${error.toString()}");
              });
            }),
            signUpOption()
          ],
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
