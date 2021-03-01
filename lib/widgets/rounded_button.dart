import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    @required this.child,
    this.buttonColor = Colors.blue,
    this.borderRadius = 20.0,
    this.height = 50.0,
    @required this.onPressed
  });
  final Widget child;
  final Color buttonColor;
  final Function onPressed;
  final double borderRadius;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: buttonColor,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(borderRadius),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 50.0,
          child: child,
        ),
      ),
    );




  }
}