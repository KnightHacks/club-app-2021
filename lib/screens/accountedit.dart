import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:club_app_2021/screens/confirm.dart';
import 'package:club_app_2021/screens/error.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/widgets/rounded_input.dart';
import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:club_app_2021/model/Prop.dart';

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
  final _shirtSizeController = TextEditingController();
  KnightHackUser khUser;

  void _presetText() {
    try {
      final Prop prop = ModalRoute.of(context).settings.arguments;
      khUser = prop.knightHackUser;

      _fullNameController.text = khUser.fullName;
      _streetController.text = khUser.street;
      _aptController.text = khUser.apartment;
      _cityController.text = khUser.city;
      _stateController.text = khUser.state;
      _zipController.text = khUser.zip;
      _shirtSizeController.text = khUser.shirtSize;
    } catch (e) {
      print(e.toString());
      Navigator.pushNamed(context, Error.id);
    }
  }

  void _submitChanges(BuildContext context) async {
    final _firestore = Firestore.instance;

    // need to change khUser.uid to the document id
    await _firestore
        .collection('user')
        .document(khUser.docId)
        .updateData({
          'fullName': _fullNameController.text,
          'street': _streetController.text,
          'apartment': _aptController.text,
          'city': _cityController.text,
          'state': _stateController.text,
          'zip': _zipController.text,
          'shirtSize': _shirtSizeController.text,
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => print(error.toString()));
  }

  void _resetPassword(BuildContext context) async{
    
    print('Implementing soon.');

    // FirebaseAuth _auth = FirebaseAuth.instance;
    
    // _auth.sendPasswordResetEmail(email: null)
    // .then((value) => Navigator.pushNamed(context, Confirm.id))
    // .catchError((e) => Navigator.pushNamed(context, Error.id));
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
                RoundedTextInput(
                  labelText: "T-shirt Size (Unisex)",
                  autocorrect: false,
                  controller: _shirtSizeController,
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
