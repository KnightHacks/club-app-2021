import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:club_app_2021/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/screens/confirm.dart';
import '../widgets/title_bar.dart';
import 'package:club_app_2021/constants.dart';
import 'package:email_validator/email_validator.dart';
import '../model/ShirtSize.dart';
import 'package:sentry/sentry.dart';

class Register2 extends StatefulWidget {
  static const String id = "Register2";

  final KnightHackUser? user;

  Register2({this.user});

  @override
  _Register2State createState() => _Register2State(user);
}

class _Register2State extends State<Register2> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  late KnightHackUser? _user;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _Register2State(KnightHackUser? user) {
    this._user = user;
  }

  final String? Function(String?) _validateEmail = (String? value) {
    if (value != null && value.isEmpty) {
      return "Please enter Email";
    }
    if (!EmailValidator.validate(value!) ||
        !(value.contains(knightsEmail) || value.contains(ucfEmail))) {
      return "Please enter valid knights or UCF email";
    }
    return null;
  };

  String? _passwordValidator(String? value) {
    return _passwordController.text == value ? null : "Passwords don't match";
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
                            labelText: "Knights Or UCF Email",
                            border: inputBorder),
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: false,
                        autocorrect: false,
                        validator: _validateEmail,
                        controller: _emailController),
                    SizedBox(height: 10),

                    // contains password
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "Password", border: inputBorder),
                        obscureText: true,
                        autocorrect: false,
                        controller: _passwordController),
                    SizedBox(height: 10),
                    // contains confirmation of password
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Confirm Password", border: inputBorder),
                      obscureText: true,
                      autocorrect: false,
                      validator: (value) {
                        return _passwordValidator(value);
                      },
                    ),
                    SizedBox(height: 20),
                    // Creates button for Registration
                    RoundedButton(
                      child: Text("Register"),
                      buttonColor: kGoldColor,
                      onPressed: () async {
                        print(_formKey);
                        if (_formKey.currentState!.validate()) {
                          UserCredential res =
                              await _auth.createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                          User user = res.user!;
                          _firestore.collection("user").add({
                            'fullName': _user!.fullName,
                            'uid': user.uid,
                            'street': _user!.street,
                            'apartment': _user!.apartment,
                            'city': _user!.city,
                            'state': _user!.state,
                            'zip': _user!.zip,
                            'shirtSize': _user!.shirtSize.displayName,
                          });
                          try {
                            await user.sendEmailVerification();
                          } catch (exception, stacktrace) {
                            await Sentry.captureException(
                              exception,
                              stackTrace: stacktrace,
                            );
                          }

                          //Navigator.popAndPushNamed(context, Confirm.id);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Confirm(
                                      message: "An email has been sent.",
                                      destination: Login.id)));
                        } else {
                          print("Passwords don't match or enter knights email");
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    // Creates button for Going Back to Register 1
                    RoundedButton(
                      child: Text("Go Back"),
                      buttonColor: kPinkColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(height: 20),
                  ],
                )),
          ),
        ));
  }
}
