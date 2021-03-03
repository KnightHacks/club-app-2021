import 'package:flutter/material.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/screens/login.dart';

class Confirm extends StatefulWidget {
  static const id = "Confirm";

  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "A verification email has been sent!",
                style: TextStyle(
                  fontSize: 32.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          RoundedButton(
            buttonColor: Colors.pinkAccent,
            onPressed: () => {
              Navigator.popAndPushNamed(context, Login.id),
            },
            child: Text(
              "Okay!"
            ),
          )
        ],
      )),
    );
  }
}
