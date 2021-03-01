import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    @required this.child,
    this.buttonColor = Colors.blue,
    this.height = 50.0,
    @required this.onPressed
  });
  final Widget child;
  final Color buttonColor;
  final Function onPressed;
  final double height;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: buttonColor,
      onPressed: onPressed,
      minWidth: 200.0,
      height: height,
      child: child,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(height / 2)
      ),
    );
  }
}