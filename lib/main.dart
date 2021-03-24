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
import 'package:club_app_2021/screens/resetpassword.dart';

/// Entry point to the club app.
///
/// This file contains all of the routes for the application and the color
/// palette used throughout the app. This is the root of the widget tree.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /// Creating a copy of the default dark theme and defining routes.
  ///
  /// Changing primary, scaffold background, accent and toggleable active
  /// color to conform to the color palette used in the KnightHacks club site.
  /// Changes may be made in the future so that the app can conform better.    
  /// Calling each page route with the class's static id. This removes
  /// confusion on how to name routes. Use the props widget to pass
  /// parameters to other pages when pushing.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF1A1843),
        scaffoldBackgroundColor: Color(0xFF1A1843),
        accentColor: Color(0xFFb7517c),
        toggleableActiveColor: Color(0xFF36328B),
        //cardColor: Colors.white,
        //inactive color
      ),
      initialRoute: Login.id,
      routes: {
        Login.id: (context) => Login(),
        Register1.id: (context) => Register1(),
        Register2.id: (context) => Register2(),
        Home.id: (context) => Home(),
        AccountView.id: (context) => AccountView(),
        AccountEdit.id: (context) => AccountEdit(),
        FAQ.id: (context) => FAQ(),
        Error.id: (context) => Error(),
        Confirm.id: (context) => Confirm(),
        ResetPassword.id: (context) => ResetPassword(),
      },
    );
  }
}
