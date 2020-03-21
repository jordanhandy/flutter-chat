import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Firebase Auth instance
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  // Spinner
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Hero animation widgetzzx;c
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                // Obscure text because password field
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  buttonColor: Colors.lightBlueAccent,
                  buttonText: 'Log In',
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      // Try to authenticate existing user
                      // Await resul before continuing to chat screen
                      final existingUser =
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                      if (existingUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                      // Catch exceptions
                    } catch (e) {
                      print(e);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
