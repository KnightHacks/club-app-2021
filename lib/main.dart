import 'package:flutter/material.dart';
import 'package:club_app_2021/screens/login.dart';
import 'package:club_app_2021/screens/register1.dart';
import 'package:club_app_2021/screens/register2.dart';
import 'package:club_app_2021/screens/home.dart';
import 'package:club_app_2021/screens/accountview.dart';
import 'package:club_app_2021/screens/accountedit.dart';
import 'package:club_app_2021/screens/error.dart';
import 'package:club_app_2021/screens/faq.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: "/",
      routes: {
        "/" : (context) => FAQ(),
        "/Login" : (context) => Login(),
        "/Register1" : (context) => Register1(),
        "/Register2" : (context) => Register2(),
        "/Home" : (context) => Home(),
        "/AccountView" : (context) => AccountView(),
        "/AccountEdit" : (context) => AccountEdit(),
        "/FAQ" : (context) => FAQ(),
        "/Error" : (context) => Error()
      },
    );
  }
}