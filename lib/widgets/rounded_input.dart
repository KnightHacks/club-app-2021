import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedTextInput extends StatelessWidget {

  final bool autocorrect;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final bool obscureText;

  RoundedTextInput({
    this.autocorrect = false,
    this.validator,
    this.controller,
    this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      autocorrect: autocorrect,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30)
          ),
      ),
    );
  }
}
