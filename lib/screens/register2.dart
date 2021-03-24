/// Second part of registering.
/// 
/// This part handles input for email and password. The user must confirm their
/// password before being able to register. Furthermore, after registering, a
/// confirmation email is sent to the email they entered to verify their account.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/screens/confirm.dart';
import '../widgets/title_bar.dart';
import 'package:club_app_2021/constants.dart';
import 'package:email_validator/email_validator.dart';

class Register2 extends StatefulWidget {
  /// Static page id.
  static const String id = "Register2";
  final KnightHackUser user;

  Register2({this.user});

  @override
  _Register2State createState() => _Register2State(user);
}

class _Register2State extends State<Register2> {
  /// Need firebase auth and firestore instances.
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  KnightHackUser _user;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _Register2State(KnightHackUser user) {
    this._user = user;
  }

  /// Validates the entered email.
  /// 
  /// Checks in entered email is blank or if it is not a knights email.
  final String Function(String) _validateEmail = (String value) {
    if (value.isEmpty) {
      return "Please enter Email";
    }
    if (!EmailValidator.validate(value) || !value.contains(knightsEmail)) {
      return "Please enter valid knights email";
    }
    return null;
  };

  /// Validates the entered password.
  /// 
  /// Checks that the entered passwords match.
  Object _passwordValidator(String value){
    return _passwordController.text == value ? null : "Passwords don't match";
  }

  /// Registers the user.
  /// 
  /// Takes in the entered information and attempts to create a user. After 
  /// creating a user with firebase auth, a document containing the registration
  /// details is created in firestore to be used later. Assuming successful 
  /// registration, the user is navigated to the confirmation page where they
  /// are notified to check their email and are navigated back to login.
  void _register() async{
    print(_formKey);
    if (_formKey.currentState.validate()) {
      AuthResult res =
          await _auth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      FirebaseUser user = res.user;
      _firestore.collection("user").add({
        'fullName': _user.fullName,
        'uid': user.uid,
        'street': _user.street,
        'apartment': _user.apartment,
        'city': _user.city,
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
    else {
      print("Passwords don't match or enter knights email");
    }                 
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderRadius: BorderRadius.circular(30));
    return Scaffold(
        appBar: titleBar,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      //contains email
                      decoration: InputDecoration(
                          labelText: "Knights Email", border: inputBorder),
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: false,
                      autocorrect: false,
                      textAlign: TextAlign.center,
                      validator: _validateEmail,
                      controller: _emailController
                    ),
                    SizedBox(height: 10),
                    // contains password
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Password", border: inputBorder),
                      obscureText: true,
                      textAlign: TextAlign.center,
                      controller: _passwordController
                    ),
                    SizedBox(height: 10),
                    // contains confirmation of password
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Confirm Password", border: inputBorder),
                      obscureText: true,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        return _passwordValidator(value);
                      },
                    ),
                    SizedBox(height: 20),
                    // Creates button for Registration
                    RoundedButton(
                      child: Text("Register"),
                      buttonColor: Color(0xFFb7517c),
                      onPressed: () => _register(),
                    ),
                    SizedBox(height: 20),
                    // Creates button for Going Back to Register 1
                    RoundedButton(
                      child: Text("Go Back"),
                      buttonColor: Colors.amber,
                      onPressed: () =>
                          Navigator.pop(context),
                    ),
                    SizedBox(height: 20),
                  ],
                )
              ),
          ),
        )
      );
   }
}
