import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const String id = "Home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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