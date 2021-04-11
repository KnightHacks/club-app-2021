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
  List<KHEvent>? events = [];

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

  /// Converting DateTime to date and 12 hour time string.
  String dateToString(DateTime dateTime) {
    String res = "";

    String amPm = dateTime.hour + 1 >= 12 ? "PM" : "AM";
    int hour12 = dateTime.hour % 12; // converts hour from 24 hour clock to 12
    String hourStr = hour12 == 0 ? "12" : hour12.toString();
    String minute = dateTime.minute == 0 ? dateTime.minute.toString() + "0" : dateTime.minute.toString();

    res += dateTime.month.toString() + "/"; // getting month
    res += dateTime.day.toString() + "/"; // getting day
    res += dateTime.year.toString() + " at "; // getting year
    res += hourStr + ":" + minute + " " + amPm;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    if (events == null) {
      // Events null, still retrieving them.
      return SpinKitThreeBounce(
        color: kGoldColor,
        size: 75.00,
      );
    } else if (events!.isEmpty) {
      // No events returned from request.
      return Center(child: Text("Events coming soon !", style: kCardTitleStyle,));
    } else {
      // Got events back.
      return ListView(
        children: [
          ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  // Toggle state on the callback
                  events![index].isExpanded = !isExpanded;
                });
              },
              dividerColor: Color(0xFF1A1843),
              children: events!
                  .map(
                    (e) => ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(e.title, style: kCardTitleStyle),
                          subtitle: Text(e.presenter != null ? "Presented by " + e.presenter! : "No Presenter", style: kGeneralTextStyle),
                        );
                      },
                      body: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            Text(e.description ?? "", style: kCardDescriptionStyle),
                            Text(dateToString(e.dateTime)),
                            SizedBox(height: 20),
                            TextButton.icon(
                              onPressed: () {
                                final Event event = Event(
                                  title: e.title,
                                  description: e.description ?? "",
                                  startDate: e.dateTime,
                                  endDate: e.dateTime,
                                );
                                Add2Calendar.addEvent2Cal(event);
                              },
                              icon: Icon(Icons.calendar_today_outlined),
                              label: Text(
                                'Add to Calendar',
                                style: kAddToCalStyle,
                              ),
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).accentColor),
                              ),
                            ),
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
