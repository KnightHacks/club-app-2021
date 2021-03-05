import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountDrawer extends StatefulWidget {
  @override
  _AccountDrawerState createState() => _AccountDrawerState();
}

class _AccountDrawerState extends State<AccountDrawer> {

  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;

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
              onPressed: () => logout(context),
              child: Text("Logout", textAlign: TextAlign.left,)
          )
        ],
      ),
    );
  }
}