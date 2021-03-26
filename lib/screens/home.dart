import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:club_app_2021/utility/getEvents.dart';
import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:club_app_2021/model/Event.dart';
import 'package:club_app_2021/constants.dart';
import 'package:club_app_2021/widgets/account_drawer.dart';

class Home extends StatefulWidget {
  static const String id = "Home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<KHEvent> events = List<KHEvent>();

  @override
  void initState() {
    super.initState();
    getEvents().then((value) {
      setState(() {
        events = value;
      });
    });
    //events = allEvents.map((e) => new KHEvent.from(e)).toList();
    print(events);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar,
      drawer: AccountDrawer(),
      body: SafeArea(
        child: ListView(
          children: [
            ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    // Toggle state on the callback
                    events[index].isExpanded = !isExpanded;
                  });
                },
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
        ),
      ),
    );
  }
}
