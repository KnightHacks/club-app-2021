import 'package:club_app_2021/model/Prop.dart';
import 'package:club_app_2021/model/ShirtSize.dart';
import 'package:club_app_2021/screens/accountedit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';

class AccountDrawer extends StatefulWidget {
  final KnightHackUser khUser;  

  AccountDrawer({@required this.khUser});

  @override
  _AccountDrawerState createState() => _AccountDrawerState(khUser: khUser);
}

class _AccountDrawerState extends State<AccountDrawer> {

  final _auth = FirebaseAuth.instance;
  KnightHackUser khUser;

  _AccountDrawerState({@required this.khUser});

  void _goToEdit(BuildContext context) async{
    dynamic returnedInfo;

    returnedInfo = await Navigator.pushNamed(context, AccountEdit.id, arguments: Prop(khUser));

    if(returnedInfo != null)  
      setState(() {
      khUser = returnedInfo;
      });
  }

  void logout(BuildContext context) {
    _auth.signOut().then((value) => {
      // Move back to the Login page.
      Navigator.popAndPushNamed(context, "Login")
    });
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
              title: Text(khUser.fullName ?? "Knightro"),
              leading: Icon(Icons.account_circle),
            ),
            ListTile(
              title: Text(khUser.email ?? "email@email.com"),
              leading: Icon(Icons.email),
            ),
            ListTile(
              title: Text(khUser.street + (khUser.apartment.isEmpty ? "" : "\n " + khUser.apartment) ?? "123 Street St."),
              leading: Icon(Icons.home),
            ),
            ListTile(
              title: Text(khUser.city + ", " + khUser.state + ", " + khUser.zip ?? "No City Listed"),
              leading: Icon(Icons.location_city),
            ),
            ListTile(
              title: Text("Shirt size: " + khUser.shirtSize.displayName ?? "No Shirt Size Listed"),
              
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