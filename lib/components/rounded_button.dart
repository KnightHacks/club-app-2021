import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    @required this.buttonText,
    @required this.buttonColor,
    @required this.buttonBehavior
  });
  final String buttonText;
  final Color buttonColor;
  final Function buttonBehavior;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: buttonColor,
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      child: MaterialButton(
        onPressed: buttonBehavior,
        minWidth: 200.0,
        height: 50.0,
        child: Text(
          buttonText,
        ),
      ),

    );


  }
}