import 'package:flutter/material.dart';
import 'package:club_app_2021/screens/login.dart';
import 'package:club_app_2021/screens/register1.dart';
import 'package:club_app_2021/screens/register2.dart';
import 'package:club_app_2021/screens/home.dart';
import 'package:club_app_2021/screens/accountview.dart';
import 'package:club_app_2021/screens/accountedit.dart';
import 'package:club_app_2021/screens/error.dart';
import 'package:club_app_2021/screens/faq.dart';
import 'package:club_app_2021/screens/confirm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: Login.id,
      routes: {
        Login.id : (context) => Login(),
        Register1.id : (context) => Register1(),
        Register2.id : (context) => Register2(),
        Home.id : (context) => Home(),
        AccountView.id : (context) => AccountView(),
        AccountEdit.id : (context) => AccountEdit(),
        FAQ.id : (context) => FAQ(),
        Error.id : (context) => Error(),
        Confirm.id: (context) => Confirm(),
      },
    );
  }
}