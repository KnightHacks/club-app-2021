import 'package:add_2_calendar/add_2_calendar.dart';
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

  static const allEvents = [
    {
      "title": "Alexa Stock Ticker",
      "description":
      "Learn how to make an Alexa skill with Knight Hacks! No coding experience is required. We will be making an Alexa skill that gets stock prices so you can ask your device what your favorite company is trading at. Along the way, we'll demonstrate some basic programming concepts for participants who are new to programming. We'll also be giving away an Amazon Echo device to a lucky workshop participant!",
      "dateTime": "2021-03-07T20:47:34+00:00",
      "location": "Zoom",
      "presenter": "Chris Feltner",
    },
    {
      "title": "What's the Point of Pointers?",
      "description":
      "Memory allocation is one of the more difficult parts of CS1, so this week we are going to do a review of the topic to help you succeed in your class! Knight Hacks President Chris Feltner will go over what pointers are, how to use them, and how to allocate and free memory. We'll be making a meal ordering system for the terminal in C to demonstrate these techniques.",
      "dateTime": "2021-03-07",
      "location": "Zoom",
      "presenter": "Chris Feltner",
    },
    {
      "title": "Vim and Vigor",
      "description":
      "Interested in a text editor included with nearly every Linux server and installation of MacOS? Ever typed `git commit` and gotten stuck in a strange program where the keys do seemingly random things? Curious about this `vim` thing you've seen Rob typing at `Hello, World!` ? Whatever your reason, this workshop is for you! We will learn the legendary Vim text editor, from basics like how to exit, to the powerful keybindings that have made it a popular choice for decades. No experience required!",
      "dateTime": "2021-03-07",
      "location": "Zoom",
      "presenter": "Robert Boyd",
    },
    {
      "title": "Career Development Panel",
      "description":
      "Join us for a panel with former students who have graduated and now work full time! You can listen and ask questions about their path into their current career and what they might have done differently. This panel is a great opportunity to learn about the reality of the job market and what you need to do to be successful!",
      "dateTime": "2021-03-07",
      "location": "Zoom",
      "presenter": "Someone",
    },
    {
      "title": "Rust",
      "description":
      'Rust has been the undisputed "most loved" programming language on the Stack Overflow Developer Survey for several years. Why? Come to this workshop and find out! Anthony will be returning to teach us the basics of Rust\'s unique memory management model and answer any questions about this innovative and promising new programming language.',
      "dateTime": "2021-03-07",
      "location": "Zoom",
      "presenter": "Anthony Hevia",
    },
  ];

  List<KHEvent> events = List<KHEvent>();

  @override
  void initState() {
    super.initState();
    events = allEvents.map((e) => new KHEvent.from(e)).toList();
    print(events);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar,
      drawer: AccountDrawer(),
      body: SafeArea(
        child: ListView(
          children: events.map((e) => Card(
            child: Column(
              children: <Widget>[
                Text(
                    e.title,
                    style: kCardTitleStyle
                ),
                Text(
                  e.description,
                  style: kCardDescriptionStyle
                ),
                FlatButton(
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
                    child: Text(
                  'Add to Calendar',
                  style: kAddToCalStyle
                ))
              ],
            ),
          )).toList(),
        ),
      ),
    );
  }
}