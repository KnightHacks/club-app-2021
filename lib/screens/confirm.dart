import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/screens/login.dart';

/// Confirmation page.
/// 
/// Navigated to after successful registration or account editing. Contains
/// A success message and a button that navigates to login.
/// 
/// Changes to be made:
/// * Allow for a custom navigation parameter so that the "okay" button can 
///   navigate to a different page so that the page is more modular.
/// * Allow for a custom message to be displayed as a parameter for the page.
///   This should allow for the page to be more modular and adaptable in 
///   where it can be used.
class Confirm extends StatefulWidget {
  static const id = "Confirm";

  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "A  email has been sent!",
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
          ),
        ],
      )),
    );
  }
}
