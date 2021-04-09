import 'package:club_app_2021/model/ShirtSize.dart';
import 'package:flutter/material.dart';

class TShirtSelector extends StatefulWidget {

  final Function(ShirtSize?) onChange;
  final ShirtSize value;

  TShirtSelector({
    required this.onChange,
    this.value = ShirtSize.M,
  });

  @override
  _TShirtSelectorState createState() => _TShirtSelectorState(changeHandler: this.onChange, currentValue: this.value);
}

class _TShirtSelectorState extends State<TShirtSelector> {

  ShirtSize currentValue;
  Function(ShirtSize?) changeHandler;

  _TShirtSelectorState({required this.currentValue, required this.changeHandler});

  void onChanged(ShirtSize? value) {
    setState(() {
      this.currentValue = value!;
    });

    // Forward handler.
    changeHandler(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<ShirtSize>(
        onChanged: onChanged,
        value: currentValue,
        items: ShirtSize.values.map<DropdownMenuItem<ShirtSize>>((ShirtSize size) {
          return DropdownMenuItem<ShirtSize>(
            child: Text(size.displayName),
            value: size
          );
        }
      ).toList(),
    ));
  }
}
