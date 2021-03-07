import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:club_app_2021/model/Event.dart';

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
      "time": "7:30 p.m.",
      "location": "Zoom",
      "date": "25",
      "month": "Feb",
      "presenter": "Chris Feltner",
    },
    {
      "title": "What's the Point of Pointers?",
      "description":
      "Memory allocation is one of the more difficult parts of CS1, so this week we are going to do a review of the topic to help you succeed in your class! Knight Hacks President Chris Feltner will go over what pointers are, how to use them, and how to allocate and free memory. We'll be making a meal ordering system for the terminal in C to demonstrate these techniques.",
      "time": "7:30 p.m.",
      "location": "Zoom",
      "date": "02",
      "month": "Mar",
      "presenter": "Chris Feltner",
    },
    {
      "title": "Vim and Vigor",
      "description":
      "Interested in a text editor included with nearly every Linux server and installation of MacOS? Ever typed `git commit` and gotten stuck in a strange program where the keys do seemingly random things? Curious about this `vim` thing you've seen Rob typing at `Hello, World!` ? Whatever your reason, this workshop is for you! We will learn the legendary Vim text editor, from basics like how to exit, to the powerful keybindings that have made it a popular choice for decades. No experience required!",
      "time": "7:30 p.m.",
      "location": "Zoom",
      "date": "04",
      "month": "Mar",
      "presenter": "Robert Boyd",
    },
    {
      "title": "Career Development Panel",
      "description":
      "Join us for a panel with former students who have graduated and now work full time! You can listen and ask questions about their path into their current career and what they might have done differently. This panel is a great opportunity to learn about the reality of the job market and what you need to do to be successful!",
      "time": "7:30 p.m.",
      "location": "Zoom",
      "date": "11",
      "month": "Mar",
      "presenter": "",
    },
    {
      "title": "Rust",
      "description":
      'Rust has been the undisputed "most loved" programming language on the Stack Overflow Developer Survey for several years. Why? Come to this workshop and find out! Anthony will be returning to teach us the basics of Rust\'s unique memory management model and answer any questions about this innovative and promising new programming language.',
      "time": "7:30 p.m.",
      "location": "Zoom",
      "date": "18",
      "month": "Mar",
      "presenter": "Anthony Hevia",
    },
  ];

  List<Event> events = List<Event>();

  @override
  void initState() {
    super.initState();
    events = allEvents.map((e) => Event.from(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar,
      body: SafeArea(
        child: ListView(
          children: events.map((e) => ListTile(
            title: Text(e.title),
            subtitle: Text(e.description),
          )).toList(),
        ),
      ),
    );
  }
}