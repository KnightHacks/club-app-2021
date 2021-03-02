import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class Login extends StatefulWidget {
  static const String id = "Login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: LoginForm(),
        )
      ),
    );
  }
}