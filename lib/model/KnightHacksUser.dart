import 'package:club_app_2021/model/ShirtSize.dart';
import 'package:flutter/material.dart';

class KnightHackUser extends InheritedWidget {

  final String uid;
  final String docId;
  final String email;
  final String fullName;
  final String street;
  final String apartment;
  final String city;
  final String state;
  final String zip;
  final ShirtSize shirtSize;

  KnightHackUser({
    this.uid,
    this.docId,
    this.email,
    this.fullName,
    this.street,
    this.apartment,
    this.city,
    this.state,
    this.zip,
    this.shirtSize
  });

  static KnightHackUser of(BuildContext context) {
    final KnightHackUser result = context
        .dependOnInheritedWidgetOfExactType<KnightHackUser>();
    assert(result != null, "Could not fetch user from context!");
    return result;
  }

  @override
  bool updateShouldNotify(KnightHackUser oldUser) {
    return fullName != oldUser.fullName;
  }

  String summary() {
    try{
      return "Name: " + fullName + ", email: " + email + ", address: " + street + " " + apartment + " " + city + " " + state + " " + zip + 
      "shirt size: " + shirtSize.displayName;
    } catch(e){
      return "Some field was null.";
    }
  }
}