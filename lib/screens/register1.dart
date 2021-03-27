import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:club_app_2021/screens/register2.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';
import 'package:club_app_2021/widgets/rounded_input.dart';
import 'package:club_app_2021/constants.dart';
import 'package:flutter/material.dart';

/// Part one of the register page
/// 
/// Register was split up so that the register process would not seem as long.
/// Part one handles input for full name, street address, apartment, city,
/// state, zip code, and shirt size. At the end of the page, the continue button
/// navigates the user to the second part of the register process.
class Register1 extends StatefulWidget {
  /// Static page id
  static const String id = "Register1";
  
  @override
  _Register1State createState() => _Register1State();
}

class _Register1State extends State<Register1> {

  /// Form key and text controllers.
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _streetController = TextEditingController();
  final _aptController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  final _shirtSizeController = TextEditingController();
  KnightHackUser _user;

  /// Validates the field.
  /// 
  /// Checks that the field is not empty when the continue button is pushed.
  String _validate(String value) {
    if (value.isEmpty) {
      return "Please fill out this field.";
    }
    return null;
  }

  /// Renders all of the input fields and navigation buttons.
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