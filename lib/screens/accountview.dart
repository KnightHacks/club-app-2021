import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:club_app_2021/widgets/account_drawer.dart';
import 'package:flutter/material.dart';

/// Account view page.
/// 
/// Unused, under consideration for deletion.
class AccountView extends StatefulWidget {
  /// Static page id.
  static const String id = "AccountView";
  final KnightHackUser kh;

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