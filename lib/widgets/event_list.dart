import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:club_app_2021/model/Event.dart';
import 'package:flutter/material.dart';
import 'package:club_app_2021/constants.dart';

class EventList extends StatefulWidget {
  // We dont pass events into the state widget.
  // this is because the state widget is only rendered once and since we call
  // set state in the home page/ the parent widget, the events variable wont
  // be updated on setState() calls. To access events in the state widget below
  // we use widget.events.
  final List<KHEvent> events;

  EventList({this.events});

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                // Toggle state on the callback
                widget.events[index].isExpanded = !isExpanded;
              });
            },
            dividerColor: Color(0xFF1A1843),
            children: widget.events
                .map(
                  (e) => ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(e.title, style: kCardTitleStyle),
                      );
                    },
                    body: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Text(e.description, style: kCardDescriptionStyle),
                          SizedBox(height: 20),
                          FlatButton.icon(
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                final Event event = Event(
                                  title: e.title,
                                  description: e.description,
                                  startDate: e.dateTime,
                                  endDate: e.dateTime,
                                );
                                Add2Calendar.addEvent2Cal(event);
                              },
                              icon: Icon(Icons.calendar_today_outlined),
                              label: Text(
                                'Add to Calendar',
                                style: kAddToCalStyle,
                              )),
                        ],
                      ),
                    ),
                    isExpanded: e.isExpanded,
                  ),
                )
                .toList())
      ],
    );
  }
}
