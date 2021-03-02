import 'package:flutter/material.dart';

class AccountEdit extends StatefulWidget {
  static const String id = "AccountEdit";
  
  @override
  _AccountEditState createState() => _AccountEditState();
}

class _AccountEditState extends State<AccountEdit> {
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