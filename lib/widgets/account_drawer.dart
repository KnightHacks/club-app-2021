import 'package:club_app_2021/model/Prop.dart';
import 'package:club_app_2021/screens/accountedit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';

/// Custom account drawer widget
/// 
/// The account drawer widget will contain the signed in user's information. 
/// Upon initializing state, the current user is retrieved from the firebase 
/// auth instance. The current user's email is retrieved and displayed. The
/// user object is also used to retrieve the signed in user's information
/// from firestore. That information is stored in the KnightHack user object.
/// The object is passed to the edit account page. At the moment, only the 
/// user's email is displayed but an issue has been made for displaying more 
/// user information.
class AccountDrawer extends StatefulWidget {  
  @override
  _AccountDrawerState createState() => _AccountDrawerState();
}

class _AccountDrawerState extends State<AccountDrawer> {

  /// Properties used to retrieve the user data via the current user from 
  /// auth and from firestore.
  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  KnightHackUser khUser;
  Map<String, dynamic> data;

  /// This method is used to navigate to the edit page.
  /// 
  /// This is called when the edit button is pressed in the account drawer.
  /// First, the current user's information is retrieved from firestore. Then
  /// the querysnapshot is parsed for properties and stored in the KnightHackUser
  /// object. The object is then placed inside of the Prop widget and passed
  /// as a parameter to the edit page.
  void _goToEdit(BuildContext context) async {
    try{
      // Getting the signed in user and firestore instance
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      String id = user.uid;
      final _firestore = Firestore.instance;

      // Querying firestore for a document containing the current user's info.
      await _firestore
          .collection('user')
          .where('uid', isEqualTo: id)
          .getDocuments()
          .then((value) {

        // always returns an array of documents
        data = value.documents[0].data;

        // Instantiating a KnightHackUser with the retrieved values.
        khUser = new KnightHackUser(
          uid: data["uid"].toString(),
          docId: value.documents[0].documentID,
          email: _user.email,
          fullName: data["fullName"].toString(),
          street: data["street"].toString(),
          apartment: data["apartment"].toString(),
          city: data["city"].toString(),
          state: data["state"].toString(),
          zip: data["zip"].toString(),
          shirtSize: data["shirtSize"].toString(),
        );
      });

      // Navigating to the edit page and passing the user object as a parameter
      Navigator.pushNamed(context, AccountEdit.id, arguments: Prop(khUser));
    } catch(e){

      print(e.toString());
    }
  }

  /// Called when the logout button is pressed.
  /// 
  /// Logs the user out and navigates back to the login page.
  void logout(BuildContext context) {
    _auth.signOut().then((value) => {
      // Move back to the Login page.
      Navigator.popAndPushNamed(context, "Login")
    });
  }

  @override
  void initState() {
    super.initState();
    /// Retrieving the current user and setting it to the user variable.
    try {
      _auth.currentUser()
          .then((user) => setState(() => _user = user));
    } catch(e) {
      print(e);
    }
  }

  /// Renders the account drawer.
  /// 
  /// Contains the logo image, signed in user's information, edit button, and
  /// log out button.
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Image.asset("assets/knightHacksLogoGold.png"),
            decoration: BoxDecoration(
                color: Colors.deepPurple
            ),
          ),
          ListTile(
            title: Text(_user?.email ?? "email@email.com"),
            leading: Icon(Icons.email),
          ),
          FlatButton(
            onPressed: () => _goToEdit(context),
            child: Text("Edit"),
            color: Colors.amber,
          ),
          FlatButton(
              onPressed: () => logout(context),
              child: Text("Logout", textAlign: TextAlign.left,)
          )
        ],
      ),
    );
  }
}