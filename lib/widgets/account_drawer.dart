import 'package:club_app_2021/model/Prop.dart';
import 'package:club_app_2021/screens/accountedit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';

class AccountDrawer extends StatefulWidget {  
  @override
  _AccountDrawerState createState() => _AccountDrawerState();
}

class _AccountDrawerState extends State<AccountDrawer> {

  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  KnightHackUser khUser;
  Map<String, dynamic> data;

  void _goToEdit(BuildContext context) async {
    try{
      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      String id = user.uid;
      final _firestore = Firestore.instance;

      await _firestore
          .collection('user')
          .where('uid', isEqualTo: id)
          .getDocuments()
          .then((value) {
        // always returns an array of documents
        // casting it as a Map
        data = value.documents[0].data;

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

      // print(khUser.toString());
      Navigator.pushNamed(context, AccountEdit.id, arguments: Prop(khUser));
    } catch(e){

      print(e.toString());
    }
  }


  void logout(BuildContext context) {
    _auth.signOut().then((value) => {
      // Move back to the Login page.
      Navigator.popAndPushNamed(context, "Login")
    });
  }

  @override
  void initState() {
    super.initState();
    try {
      _auth.currentUser()
          .then((user) => setState(() => _user = user));
    } catch(e) {
      print(e);
    }
  }

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