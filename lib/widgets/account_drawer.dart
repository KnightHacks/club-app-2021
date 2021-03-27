import 'package:club_app_2021/model/Prop.dart';
import 'package:club_app_2021/screens/accountedit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';











/// IMPORTANT
/// I think we will have to make the KhUser in login as originally planned, and pass it to home and the login drawer.
/// this is because we can load the user info into the account drawer, but since its async, there will be an error flash
/// when you open it first but after half a second, everything is fine. Therefore, we should probably just make the khUser
/// object on login and pass it since its fast to get the current user's email, but takes time to hit firestore and get the
/// user's info. Screens that need the khUser are account drawer and account edit which warrants this action.
/// 

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
          //shirtSize: data["shirtSize"].toString(),
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
      child: Container(
        color: Color(0xFF1A1843),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Image.asset("assets/knightHacksLogoGold.png"),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0,
                  color: Color(0xFF1A1843),
                ),
              ),
            ),
            ListTile(
              title: Text(_user?.email ?? "email@email.com"),
              leading: Icon(Icons.email),
            ),
            FlatButton(
              onPressed: () => _goToEdit(context),
              child: Text("Edit"),
              color: Color(0xFF36328B),
            ),
            FlatButton(
                onPressed: () => logout(context),
                child: Text("Logout", textAlign: TextAlign.left),
                color: Color(0xFF36328B)
            )
          ],
        ),
      ),
    );
  }
}