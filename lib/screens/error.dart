import 'package:flutter/material.dart';

class Error extends StatefulWidget {
  static String id = "Error";

  @override
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: SafeArea(
        child: Column()
      ),
    );
  }
}