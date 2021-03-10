import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:club_app_2021/widgets/account_drawer.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  static const String id = "AccountView";
  KnightHackUser kh;

  AccountView({this.kh});

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {

  KnightHackUser kh;

  _AccountViewState({this.kh});

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