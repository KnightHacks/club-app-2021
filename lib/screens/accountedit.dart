import 'package:club_app_2021/widgets/rounded_input.dart';
import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class AccountEdit extends StatefulWidget {
  static const String id = "AccountEdit";
  
  @override
  _AccountEditState createState() => _AccountEditState();
}

class _AccountEditState extends State<AccountEdit> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: SingleChildScrollView(
            child: Column(
            children: [
              SizedBox(height: 10),
              RoundedTextInput(
                labelText: "Full Name",
                autocorrect: false,
              ),
              SizedBox(height: 10),
              RoundedTextInput(
                labelText: "Street Address",
                autocorrect: false,
              ),
              SizedBox(height: 10),
              RoundedTextInput(
                labelText: "Apartment (Optional)",
                autocorrect: false,
              ),
              SizedBox(height: 10),
              RoundedTextInput(
                labelText: "Zipcode",
                autocorrect: false,
              ),
              SizedBox(height: 10),
              RoundedTextInput(
                labelText: "City",
                autocorrect: false,
              ),
              SizedBox(height: 10),
              RoundedTextInput(
                labelText: "State",
                autocorrect: false,
              ),
              SizedBox(height: 10),
              RoundedTextInput(
                labelText: "T-shirt Size (Unisex)",
                autocorrect: false,
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}