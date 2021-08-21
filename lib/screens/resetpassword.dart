import 'package:flutter/material.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:club_app_2021/screens/error.dart';
import 'package:sentry/sentry.dart';

class ResetPassword extends StatefulWidget {
  static const id = 'ResetPassword';
  @override
  _ResetPassword createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final inputBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(30));
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String email;

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
                      showDialog(
                     context: context,
                     builder: (BuildContext context) {
                       return AlertDialog(
                         title: Text("Check your email for a reset link."),
                         actions: <Widget>[
                           new TextButton(onPressed: () => Navigator.of(context).pop(),
                               child: Text("Close"))
                         ],
                       );
                     },
                   );
                    } catch (exception, stacktrace) {
                      await Sentry.captureException(
                        exception,
                        stackTrace: stacktrace
                      );
                      
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
