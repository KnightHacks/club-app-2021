import 'package:club_app_2021/model/Prop.dart';
import 'package:club_app_2021/model/ShirtSize.dart';
import 'package:club_app_2021/screens/accountedit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';

class AccountDrawer extends StatefulWidget {
  final KnightHackUser khUser;  

  AccountDrawer({required this.khUser});

  @override
  _AccountDrawerState createState() => _AccountDrawerState(khUser: khUser);
}

class _AccountDrawerState extends State<AccountDrawer> {

  final _auth = FirebaseAuth.instance;
  KnightHackUser khUser;

  _AccountDrawerState({required this.khUser});

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
              title: Text(khUser.fullName),
              leading: Icon(Icons.account_circle),
            ),
            ListTile(
              title: Text(khUser.email),
              leading: Icon(Icons.email),
            ),
            ListTile(
              title: Text(khUser.street + (khUser.apartment.isEmpty ? "" : "\n " + khUser.apartment)),
              leading: Icon(Icons.home),
            ),
            ListTile(
              title: Text(khUser.city + ", " + khUser.state + ", " + khUser.zip),
              leading: Icon(Icons.location_city),
            ),
            ListTile(
              title: Text("Shirt size: " + khUser.shirtSize.displayName),
              
            ),
            TextButton(
              onPressed: () => _goToEdit(context),
              child: Text("Edit"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1A1843)),
              ),
            ),
            TextButton(
                onPressed: () => logout(context),
                child: Text("Logout", textAlign: TextAlign.left),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1A1843)),
                ),
            )
          ],
        ),
      ),
    );
  }
}