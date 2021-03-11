import 'package:flutter/material.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  static const id = 'ResetPassword';
  @override
  _ResetPassword createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30)
  );
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Reset Password')
    ),

    body: SafeArea(child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
         decoration: InputDecoration(
              labelText:"Enter Your Email",
              border:inputBorder,
            ),
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.center,
          onChanged: (value) {
            email = value;
          },
        ),
          SizedBox(height: 20),
          RoundedButton(
            child: Text('Send Request'),
            onPressed: () {
              _auth.sendPasswordResetEmail(email: email);
              Navigator.popAndPushNamed(context, Login.id);
            },
          ),

      ],
    ),

    )
    );
}
}
