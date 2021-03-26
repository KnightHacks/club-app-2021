import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:club_app_2021/screens/register2.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/widgets/rounded_input.dart';
import 'package:club_app_2021/constants.dart';
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
      appBar: titleBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 20),
                  RoundedTextInput(
                    validator: _validate,
                    labelText: "Full Name",
                    controller: _fullNameController,
                  ),
                  SizedBox(height: 20),
                  RoundedTextInput(
                    validator: _validate,
                    labelText: "Street",
                    controller: _streetController,
                  ),
                  SizedBox(height: 20),
                  RoundedTextInput(
                    labelText: "Apartment",
                    controller: _aptController,
                  ),
                  SizedBox(height: 20),
                  RoundedTextInput(
                    validator: _validate,
                    labelText: "City",
                    controller: _cityController,
                  ),
                  SizedBox(height: 20),
                  RoundedTextInput(
                    validator: _validate,
                    labelText: "State",
                    controller: _stateController,
                  ),
                  SizedBox(height: 20),
                  RoundedTextInput(
                    validator: _validate,
                    labelText: "ZIP",
                    controller: _zipController,
                  ),
                  SizedBox(height: 20),
                  RoundedTextInput(
                    validator: _validate,
                    labelText: "Shirt",
                    controller: _shirtSizeController,
                  ),
                  SizedBox(height: 20),
                  RoundedButton(
                    child: Text("Continue"),
                    onPressed: () {
                      // Validate inputs
                      _formKey.currentState.validate();
                      _user = KnightHackUser(
                        fullName: _fullNameController.text,
                        street: _streetController.text,
                        apartment: _aptController.text,
                        city: _cityController.text,
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
                    buttonColor: Colors.amber,
                  ),
                  SizedBox(height: 10),
                  RoundedButton(
                    child: Text("Go Back"),
                    onPressed: () => Navigator.pop(context),
                    buttonColor: kPinkColor,
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}