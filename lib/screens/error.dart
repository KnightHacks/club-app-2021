import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class Error extends StatefulWidget {
  static const String id = "Error";

  @override
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
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