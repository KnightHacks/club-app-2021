import 'package:club_app_2021/model/FAQListItem.dart';
import 'package:flutter/material.dart';
import 'package:club_app_2021/constants.dart';

class FAQList extends StatefulWidget {
  final List<FAQListItem> items;

  FAQList({Key key, this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FAQListState(items);
}

// Handles state changes for the items.
class _FAQListState extends State<FAQList> {
  List<FAQListItem> _items;

  _FAQListState(List<FAQListItem> items) {
    this._items = items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  // Toggle state on the callback
                  _items[index].isExpanded = !isExpanded;
                });
              },
              // Create an expansion panel for each item.
              children: _items.map<ExpansionPanel>((FAQListItem item) {
                return ExpansionPanel(
                    body: ListTile(
                      leading: Icon(Icons.format_quote, color: kIconColor,),
                      title: Text(
                        item.answer,
                        style: kGeneralTextStyle,
                      ),
                    ),
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        leading: Icon(Icons.question_answer_outlined, color: Colors.black,),
                        title: Text(item.question, style: kGeneralTextStyle),
                      );
                    },
                    isExpanded: item.isExpanded
                );
              }).toList(),
            ),
          ],
        )
    );
  }
}