import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/screens/register1.dart';
import 'package:club_app_2021/screens/confirm.dart';
import '../widgets/title_bar.dart';

class Register2 extends StatefulWidget {
  static const String id = "Register2";

  final KnightHackUser user;

  Register2({this.user});

  @override
  _Register2State createState() => _Register2State(user);
}

class _Register2State extends State<Register2> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  String email;
  String password;
  String confirmPassword;
  KnightHackUser _user;

  _Register2State(KnightHackUser user) {
    this._user = user;
  }
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderRadius: BorderRadius.circular(30));
    return Scaffold(
        appBar: titleBar,
        body: SafeArea(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // contains knighthacks logo
                  // Image.asset(
                  //   "assets/sword.png",
                  //   width: 50,
                  // ),
                  // SizedBox(height: 20),
                  TextFormField(
                    //contains email
                    decoration: InputDecoration(
                        labelText: "Email", border: inputBorder),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: 10),

                  // contains password
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Password", border: inputBorder),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(height: 10),
                  // contains confirmation of password
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Confirm Password", border: inputBorder),
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                  ),
                  SizedBox(height: 20),
                  // Creates button for Registration
                  RoundedButton(
                    child: Text("Register"),
                    buttonColor: Color(0xFFb7517c),
                    onPressed: () async {
                      if (confirmPassword == password) {
                        AuthResult res =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        FirebaseUser user = res.user;
                        _firestore.collection("user").add({
                          'fullName': _user.fullName,
                          'uid': user.uid,
                          'street': _user.street,
                          'apartment': _user.apartment,
                          'state': _user.state,
                          'zip': _user.zip,
                          'shirtSize': _user.shirtSize
                        });

                        try {
                          await user.sendEmailVerification();
                        } catch (e) {
                          print(
                              "Something went wrong while sending your email verification.");
                          print(e.message);
                        }

                        Navigator.popAndPushNamed(context, Confirm.id);
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  // Creates button for Going Back to Register 1
                  RoundedButton(
                    child: Text("Go Back"),
                    buttonColor: Colors.amber,
                    onPressed: () =>
                        Navigator.popAndPushNamed(context, Register1.id),
                  ),
                  SizedBox(height: 20),
                ],
              )
            ),
        )
      );
   }
}
