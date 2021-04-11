import 'package:flutter/material.dart';
import 'package:club_app_2021/widgets/rounded_button.dart';

class Confirm extends StatelessWidget {
  static const id = "Confirm";
  final String? message;
  final String? destination;

  Confirm({this.message, this.destination});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  message ?? "",
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            RoundedButton(
              buttonColor: Colors.pinkAccent,
              onPressed: () => {
                Navigator.popAndPushNamed(context, destination ?? ""),
              },
              child: Text("Okay!"),
            ),
          ],
        )),
      ),
    );
  }
}
