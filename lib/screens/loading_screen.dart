import 'package:club_app_2021/constants.dart';
import 'package:flutter/material.dart';
// Needs to be updated with flutter 2 when dev team upgrades
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app_2021/model/ShirtSize.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:club_app_2021/screens/home.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = "Loading";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  /// Converts String to ShirtSize
  ///
  /// Turns string returned from firestore into a ShirtSize so it can be stored
  /// in KhUser object and passed.
  ShirtSize stringToShirtSize(String size) {
    ShirtSize? res;
    try {
      switch (size) {
        case "S":
          res = ShirtSize.S;
          break;

        case "M":
          res = ShirtSize.M;
          break;

        case "L":
          res = ShirtSize.L;
          break;

        case "XL":
          res = ShirtSize.XL;
          break;

        case "XXL":
          res = ShirtSize.XXL;
          break;

        default:
          res = null;
          break;
      }
    } catch (e) {
      print(e.toString());
    }
    return res!;
  }

  /// Creates KnightHackUser object for signed in user.
  ///
  /// Creating the khUser object in home page since it doesnt work when
  /// created on login. This is because the navigator method used was
  /// popAndPushNamed. Since it pops first, we cannot access any arguments
  /// passed from the popped page in the pushed one. Recall that popping removes
  /// the page from the navigator stack. PopAndPushNamed makes the pushed page
  /// disconnected from the previous pages, essentially clearing the stack and
  /// pushing this page on. This behavior is desireable for when we do not want
  /// users to navigate to a previous page, like login. However, it is good to
  /// recognize the consequences of using this method, in this case, not being
  /// able to use arguments passed from the previous page.
  Future<KnightHackUser> _getUser() async {
    Map<String, dynamic> data;
    KnightHackUser? _khUser;
    try {
      User user = FirebaseAuth.instance.currentUser!;

      String id = user.uid;
      final _firestore = FirebaseFirestore.instance;

      await _firestore
          .collection('user')
          .where('uid', isEqualTo: id)
          .get()
          .then((value) {
        // always returns an array of documents
        // casting it as a Map
        data = value.docs[0].data();

        _khUser = new KnightHackUser(
          fullName: data["fullName"].toString(),
          street: data["street"].toString(),
          apartment: data["apartment"].toString(),
          city: data["city"].toString(),
          state: data["state"].toString(),
          zip: data["zip"].toString(),
          shirtSize: stringToShirtSize(data["shirtSize"].toString()),
        );

        _khUser!.uid = data["uid"].toString();
        _khUser!.docId = value.docs[0].id;
        _khUser!.email = user.email!;
      });
      // print(_khUser!.summary());
    } catch (e) {
      print(e.toString());
    }
    return _khUser!;
  }

  void getInfo() async {

    KnightHackUser khUser = await _getUser();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(khUser: khUser)));
  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitThreeBounce(
          color: kGoldColor,
          size: 100.0,
        ),
      ),
    );
  }
}
