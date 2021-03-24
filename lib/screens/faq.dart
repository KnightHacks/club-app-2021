/// FAQ page.
///
/// Displays the FAQ expandable panels. FAQ items are parsed from json and uses
/// the FAQListItem in models to be passed to the FAQList widget

import 'dart:convert';
import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:club_app_2021/model/FAQListItem.dart';
import 'package:club_app_2021/widgets/faq_list.dart';

class FAQ extends StatefulWidget {
  /// Static page id
  static const String id = "FAQ";

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  List<FAQListItem> _items = [];

  /// Load the list items from json.
  @override
  void initState() {
    super.initState();
    rootBundle
        .loadString("assets/faqs.json")
        .then((value) => json.decode(value))
        .then((values) {
      List<FAQListItem> list = new List();
      values.forEach((value) => list.add(FAQListItem.fromJson(value)));
      return list;
    }).then((value) => setState(() => _items = value));
  }

  /// Render the FAQListItem list in the FAQList widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FAQList(
            key: UniqueKey(),
            items: _items
          ),
        ),
      ),
    );
  }
}
