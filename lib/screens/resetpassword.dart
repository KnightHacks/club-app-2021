import 'package:flutter/material.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:club_app_2021/screens/error.dart';
import 'package:club_app_2021/screens/confirm.dart';

/// Password reset page.
///
/// Takes in an input for email and sends a reset email to the entered email.
class ResetPassword extends StatefulWidget {
  /// Static page id.
  static const id = 'ResetPassword';
  @override
  _ResetPassword createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final inputBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(30));
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Reset Password')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    //TextField to enter the email
                    labelText: "Enter Your Email",
                    border: inputBorder,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(height: 20),
                RoundedButton(
                  //This button is to send the reset password email
                  child: Text('Send Request'),
                  onPressed: () async {
                    try {
                      //When button is pressed this sends password reset email
                      await _auth.sendPasswordResetEmail(email: email);
                      Navigator.popAndPushNamed(context, Confirm.id);
                    } catch (e) {
                      //if the email does not exist or there is some error
                      Navigator.pushNamed(context, Error.id);
                    }
                  },
                  buttonColor: Colors.amber,
                ),
              ],
            ),
          ),
        ));
  }
}
