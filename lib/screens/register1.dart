import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class Register1 extends StatefulWidget {
  static const String id = "Register1";
  
  @override
  _Register1State createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar,
      body: SafeArea(
        child: Column()
      ),
    );
  }
}