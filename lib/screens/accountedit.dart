import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:club_app_2021/model/ShirtSize.dart';
import 'package:club_app_2021/screens/confirm.dart';
import 'package:club_app_2021/screens/error.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/widgets/rounded_input.dart';
import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:club_app_2021/widgets/tshirt_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:club_app_2021/model/Prop.dart';
import 'package:sentry/sentry.dart';

class AccountEdit extends StatefulWidget {
  static const String id = "AccountEdit";

  @override
  _AccountEditState createState() => _AccountEditState();
}

class _AccountEditState extends State<AccountEdit> {
  final _fullNameController = TextEditingController();
  final _streetController = TextEditingController();
  final _aptController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  ShirtSize _shirtSize = ShirtSize.M;
  late KnightHackUser khUser;

  void _presetText() async {
    try {
      final Prop prop = ModalRoute.of(context)!.settings.arguments as Prop;
      khUser = prop.knightHackUser;

      _fullNameController.text = khUser.fullName;
      _streetController.text = khUser.street;
      _aptController.text = khUser.apartment;
      _cityController.text = khUser.city;
      _stateController.text = khUser.state;
      _zipController.text = khUser.zip;
      _shirtSize = khUser.shirtSize;
    } catch (exception, stacktrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stacktrace,
      );
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Unable to load account info."),
            actions: <Widget>[
              new TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Close"))
            ],
          );
        },
      );
    }
  }

  void onTShirtChange(ShirtSize? value) {
    _shirtSize = value!;
  }

  void _submitChanges(BuildContext context) async {
    final _firestore = FirebaseFirestore.instance;

    await _firestore
        .collection('user')
        .doc(khUser.docId)
        .update({
          'fullName': _fullNameController.text,
          'street': _streetController.text,
          'apartment': _aptController.text,
          'city': _cityController.text,
          'state': _stateController.text,
          'zip': _zipController.text,
          'shirtSize': _shirtSize.displayName,
        })
        .then((value) {
          KnightHackUser updatedUser = new KnightHackUser(
            fullName: _fullNameController.text,
            street: _streetController.text,
            apartment: _aptController.text,
            city: _cityController.text,
            state: _stateController.text,
            zip: _zipController.text,
            shirtSize: _shirtSize,
            email: khUser.email,
          );
          print(updatedUser.summary());
          Navigator.pop(context, updatedUser);
        })
        .catchError((exception, stacktrace) async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Unable to update account info, try again later."),
                actions: <Widget>[
                  new TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Close"))
                ],
              );
            },
          );
          Sentry.captureException(
            exception,
            stackTrace: stacktrace,
          );
        });
  }

  void _resetPassword(BuildContext context) async{
    
    FirebaseAuth _auth = FirebaseAuth.instance;
    
    _auth.sendPasswordResetEmail(email: khUser.email)
    .then((value) => Navigator.pushNamed(context, Confirm.id))
    .catchError((e) => Navigator.pushNamed(context, Error.id));
  }

  @override
  Widget build(BuildContext context) {
    _presetText();

    return Scaffold(
      appBar: titleBar,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                RoundedTextInput(
                  labelText: "Full Name",
                  autocorrect: false,
                  controller: _fullNameController,
                ),
                SizedBox(height: 30),
                RoundedTextInput(
                  labelText: "Street Address",
                  autocorrect: false,
                  controller: _streetController,
                ),
                SizedBox(height: 30),
                RoundedTextInput(
                  labelText: "Apartment (Optional)",
                  autocorrect: false,
                  controller: _aptController,
                ),
                SizedBox(height: 30),
                RoundedTextInput(
                  labelText: "Zipcode",
                  autocorrect: false,
                  controller: _zipController,
                ),
                SizedBox(height: 30),
                RoundedTextInput(
                  labelText: "City",
                  autocorrect: false,
                  controller: _cityController,
                ),
                SizedBox(height: 30),
                RoundedTextInput(
                  labelText: "State",
                  autocorrect: false,
                  controller: _stateController,
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Shirt Size:"),
                    SizedBox(width: 50,),
                    TShirtSelector(
                      onChange: onTShirtChange,
                      value: khUser.shirtSize,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                RoundedButton(
                  buttonColor: Colors.amber,
                  child: Text("Submit Changes"),
                  onPressed: () => _submitChanges(context),
                ),
                SizedBox(height: 10),
                RoundedButton(
                  buttonColor: Color(0xFFb7517c),
                  child: Text("Reset Password"),
                  onPressed: () => _resetPassword(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
