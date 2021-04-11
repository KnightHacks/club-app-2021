import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.child,
    this.buttonColor,
    this.height = 50.0,
    required this.onPressed
  });
  final Widget child;
  final Color? buttonColor;
  final Function()? onPressed;
  final double height;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      // If a color was not provided use the theme colors.
      color: buttonColor ?? Theme.of(context).buttonColor,
      onPressed: onPressed,
      minWidth: 200.0,
      height: height,
      child: child,
      elevation: 0,
      shape: RoundedRectangleBorder(
        // Why (height / 2)? We want a perfect
        // circular border. The only way to achieve
        // this is to get half of the height or...
        // the radius of circle the height of the button!
        borderRadius: BorderRadius.circular(height / 2)
      ),
    );
  }
}