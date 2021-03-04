import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountDrawer extends StatelessWidget {

  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  void logout(FirebaseUser user) {
    _auth.signOut();

    // Move back to the Login page.
  }

  @override
  Widget build(BuildContext context) {


    try {
      _auth.currentUser()
          .then((user) => _user);
    } catch(e) {
      print(e);
    }

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
            title: Text(_user?.displayName ?? "Display Name",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text("email@email.com"),
            leading: Icon(Icons.email),
          ),
          FlatButton( // Left Justify
              onPressed: () {
                // Log the user out.
              },
              child: Text("Logout", textAlign: TextAlign.left,)
          )
        ],
      ),
    );
  }
}
