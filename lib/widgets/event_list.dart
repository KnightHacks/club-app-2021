import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:club_app_2021/model/Event.dart';
import 'package:flutter/material.dart';
import 'package:club_app_2021/constants.dart';
import 'package:club_app_2021/utility/getEvents.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EventList extends StatefulWidget {
  static const String id = "Event List";
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  List<KHEvent> events;

  @override
  void initState() {
    super.initState();
    getEvents().then((value) {
      setState(() {
        events = value;
        print(events.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (events == null) {
      // Events null, still retrieving them.
      return SpinKitThreeBounce(
        color: kGoldColor,
        size: 75.00,
      );
    } else if (events.isEmpty) {
      // No events returned from request.
      return Center(child: Text("Events coming soon !"));
    } else {
      // Got events back.
      return ListView(
        children: [
          ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  // Toggle state on the callback
                  events[index].isExpanded = !isExpanded;
                });
              },
              dividerColor: Color(0xFF1A1843),
              children: events
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
}
