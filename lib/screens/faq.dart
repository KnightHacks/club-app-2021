import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:club_app_2021/model/FAQListItem.dart';
import 'package:club_app_2021/widgets/faq_list.dart';

class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {

  List<FAQListItem> _items = [];

  @override
  void initState() {
    super.initState();
    rootBundle.loadString("assets/faqs.json")
    .then((value) => json.decode(value))
    .then((values) {
      List<FAQListItem> list = new List();
      values.forEach((value) => list.add(FAQListItem.fromJson(value)));
      return list;
    })
    .then((value) => setState(() => _items = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: SafeArea(
        child: FAQList(key: UniqueKey(), items: _items),
      ),
    );
  }
}