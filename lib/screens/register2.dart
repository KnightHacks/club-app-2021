import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/screens/login.dart';
import 'package:club_app_2021/screens/register1.dart';
import 'package:club_app_2021/screens/confirm.dart';

class Register2 extends StatefulWidget {
  static const String id = "Register2";

  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String email;
  String password;
  String confirmPassword;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // contains email
          TextField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            onChanged: (value){
              email = value;
            },
            // TODO hint Text "Enter Your Email"
          ),
          // contains password
          TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value){
              password = value;
            },
          ),

          // contains confirmation of password
          TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value){
              confirmPassword = value;
            },
          ),
          // Creates button for Registration
          RoundedButton(
            child: Text("Register"),
            buttonColor: Colors.pinkAccent,
            onPressed: () async {
              if(confirmPassword == password) {
                  AuthResult res = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  FirebaseUser user = res.user;

                  try{
                    await user.sendEmailVerification();
                  }
                  catch(e){
                    print("Something went wrong while sending your email verification.");
                    print(e.message);
                  }

                  Navigator.popAndPushNamed(context, Confirm.id);
              }
            },
          ),
          // Creates button for Going Back to Register 1
          RoundedButton(
            child: Text("Go Back"),
            buttonColor: Colors.blue,
            onPressed: (){
              Navigator.popAndPushNamed(context, Register1.id);
            },
          ),
        ],
      )
      ),
    );
  }

}
