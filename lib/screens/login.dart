import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

/// Login page
/// 
/// Page that contains the KnightHacks sword logo and the LoginForm widget.
class Login extends StatefulWidget {
  /// Static page id.
  static const String id = "Login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              Expanded(child: Image.asset("assets/sword.png")),
              Expanded(child:
                SingleChildScrollView(child:
                  LoginForm()
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}