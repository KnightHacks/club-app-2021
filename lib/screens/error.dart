import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:flutter/material.dart';

/// Error page
/// 
/// Under consideration for deletion in favor of using dialogue boxes.
class Error extends StatefulWidget {
  /// Static page id
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