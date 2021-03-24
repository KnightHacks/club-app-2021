/// Account editing page
/// 
/// Upon rendering, the text input fields should be prefilled with information
/// retrieved from the account drawer widget. This allows for the user to see 
/// all of their information and edit the fields they have to. Afterwards, 
/// pressing the submit changes button will update the user's document in 
/// firestore with all of the information entered, including the prefilled 
/// inputs. Afterwards, the user should be navigated to the confirmation page.
/// Editable fields are full name, street address, apartment, state, zipcode,
/// shirt size, and password. We will not allow email changes since only users
/// with knights emails should have accounts. Furthermore, changing a knights
/// email is a process handled by the University of Central Florida. If a user
/// does have their knights email changed, contact a member of the KnightHacks
/// Mobile Development Team who has access to the Firebase console to either
/// delete their account have have them re-register, or edit their email
/// which may or may not be possible.

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
  /// Static page id
  static const String id = "AccountEdit";

  @override
  _AccountEditState createState() => _AccountEditState();
}

class _AccountEditState extends State<AccountEdit> {

  /// Creating the controllers for each user and the KnightHackUser object.
  final _fullNameController = TextEditingController();
  final _streetController = TextEditingController();
  final _aptController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _shirtSizeController = TextEditingController();
  KnightHackUser khUser;

  /// Prepopulating the text fields.
  void _presetText() {
    try {

      /// Retrieving the KnightHack user object passed in as a parameter.
      final Prop prop = ModalRoute.of(context).settings.arguments;
      khUser = prop.knightHackUser;

      /// Setting the text
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

  /// Called when submit changes is pressed.
  /// 
  /// Updates the user's document in firestore with the current input text.
  void _submitChanges(BuildContext context) async {
    final _firestore = Firestore.instance;

    /// Using docId to find the document that belongs to the current user.
    /// updating the document in firestore.
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

  /// Called when reset password is pressed.
  /// 
  /// Sends the current user an email to the email stored in firestore that
  /// will allow them to reset their password.
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
                /// All of the text fields and custom buttons
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
