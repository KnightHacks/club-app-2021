/// Wrapper class that stores the logged in user's information. 
/// 
/// Extends inherited widget so that it is accessible from anywhere in the 
/// widget tree. Stores the uid of the user in firebase auth, the id of their 
/// document in firestore, email, full name, street address, apartment, city, 
/// state, zipcode, and shirt size.

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
  final String shirtSize;

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
}