import 'package:flutter/material.dart';

class KnightHackUser extends InheritedWidget {
  final String fullName;
  final String street;
  final String apartment;
  final String city;
  final String state;
  final String zip;
  final String shirtSize;

  KnightHackUser({
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