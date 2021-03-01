import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:club_app_2021/components/rounded_button.dart';

class Register2 extends StatefulWidget {

  final String pathName = "/Register2";

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
            buttonText: 'Register',
            buttonColor: Colors.pinkAccent,
            buttonBehavior: () async {
              if(confirmPassword == password) {
                  await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  Navigator.popAndPushNamed(context, '/Login');
              }
            },
          ),
          // Creates button for Going Back to Register 1
          RoundedButton(
            buttonText: 'Go Back',
            buttonColor: Colors.blue,
            buttonBehavior: (){
              // Navigator.popAndPushNamed(context, 'Register1');
            },
          ),
        ],
      )
      ),

    );
  }

}
