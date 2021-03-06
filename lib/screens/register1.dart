import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:club_app_2021/screens/login.dart';
import 'package:club_app_2021/screens/register2.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/widgets/rounded_input.dart';
import 'package:flutter/material.dart';

class Register1 extends StatefulWidget {
  static const String id = "Register1";
  
  @override
  _Register1State createState() => _Register1State();
}

class _Register1State extends State<Register1> {

  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _streetController = TextEditingController();
  final _aptController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _shirtSizeController = TextEditingController();

  KnightHackUser _user;

  String _validate(String value) {
    if (value.isEmpty) {
      return "Please fill out this field.";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RoundedTextInput(
                  validator: _validate,
                  labelText: "Full Name",
                  controller: _fullNameController,
                ),
                RoundedTextInput(
                  validator: _validate,
                  labelText: "Street",
                  controller: _streetController,
                ),
                RoundedTextInput(
                  labelText: "Apartment",
                  controller: _aptController,
                ),
                RoundedTextInput(
                  validator: _validate,
                  labelText: "City",
                  controller: _cityController,
                ),
                RoundedTextInput(
                  validator: _validate,
                  labelText: "State",
                  controller: _stateController,
                ),
                RoundedTextInput(
                  validator: _validate,
                  labelText: "ZIP",
                  controller: _zipController,
                ),
                RoundedTextInput(
                  validator: _validate,
                  labelText: "Shirt",
                  controller: _shirtSizeController,
                ),
                RoundedButton(
                  child: Text("Continue"),
                  onPressed: () {
                    // Validate inputs
                    _formKey.currentState.validate();
                    _user = KnightHackUser(
                      fullName: _fullNameController.text,
                      street: _streetController.text,
                      apartment: _aptController.text,
                      state: _stateController.text,
                      zip: _zipController.text,
                      shirtSize: _shirtSizeController.text
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register2(
                          user: _user,
                        )
                      )
                    );
                  },
                ),
                RoundedButton(
                  child: Text("Go Back"),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}