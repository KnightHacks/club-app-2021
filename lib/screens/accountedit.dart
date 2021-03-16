import 'package:club_app_2021/widgets/rounded_input.dart';
import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class AccountEdit extends StatefulWidget {
  static const String id = "AccountEdit";
  
  @override
  _AccountEditState createState() => _AccountEditState();
}

/*
Map <String, Dynamic> data;
String id = user.uid;
        final _firestore = Firestore.instance;
        KnightHackUser khUser;

        await _firestore
            .collection('user')
            .where('uid', isEqualTo: id)
            .getDocuments()
            .then((value) {
          // always returns an array of documents
          // casting it as a Map
          data = Map.from(value.documents[0].data);
        });

        khUser = new KnightHackUser(
          uid: data["uid"].toString(),
          fullName: data["fullName"].toString(),
          street: data["street"].toString(),
          apartment: data["apartment"].toString(),
          city: data["city"].toString(),
          state: data["state"].toString(),
          zip: data["zip"].toString(),
          shirtSize: data["shirtSize"].toString(),
        );

  use this to hit db
*/



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