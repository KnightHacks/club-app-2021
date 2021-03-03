import 'package:club_app_2021/widgets/account_drawer.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  static const String id = "AccountView";

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      drawer: AccountDrawer(),
      body: SafeArea(
        child: Column()
      ),
    );
  }
}