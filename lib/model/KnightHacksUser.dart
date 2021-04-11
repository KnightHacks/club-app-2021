import 'package:club_app_2021/model/ShirtSize.dart';

class KnightHackUser {

  late final String uid;
  late final String docId;
  late final String email;
  final String fullName;
  final String street;
  final String apartment;
  final String city;
  final String state;
  final String zip;
  final ShirtSize shirtSize;

  KnightHackUser({
    required this.fullName,
    required this.street,
    required this.apartment,
    required this.city,
    required this.state,
    required this.zip,
    required this.shirtSize,
  });

  String summary() {
    try{
      return "Name: " + fullName + ", email: " + email + ", address: " + street + " " + apartment + " " + city + " " + state + " " + zip + 
      ", shirt size: " + shirtSize.displayName;
    } catch(e){
      return "Some field was null.";
    }
  }
}