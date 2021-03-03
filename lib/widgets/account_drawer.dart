import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              "Header",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.deepPurple
            ),
          ),
          ListTile(
            title: Text(
                "Suneet Tipirneni",
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
          FlatButton(
              onPressed: () {},
              child: Text("Logout", textAlign: TextAlign.left,)
          )
        ],
      ),
    );
  }
}
