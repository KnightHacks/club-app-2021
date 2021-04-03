import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:club_app_2021/utility/getEvents.dart';
import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:club_app_2021/model/Event.dart';
import 'package:club_app_2021/widgets/account_drawer.dart';
import 'package:club_app_2021/widgets/event_list.dart';

/// Home page
/// 
/// This home page widget renders a scaffold with the Knight Hacks logo appbar
/// and drawer. Below is a tab switcher that allows the user to see upcoming
/// events and an FAQ page.
class Home extends StatefulWidget {
  static const String id = "Home";


  final KnightHackUser khUser;

  Home({@required this.khUser});

  @override
  _HomeState createState() => _HomeState(khUser: khUser);
}

class _HomeState extends State<Home> {
  List<KHEvent> events = List<KHEvent>();
  KnightHackUser khUser;

  _HomeState({@required this.khUser});

  @override
  void initState() {
    super.initState();
    getEvents().then((value) {
      setState(() {
        events = value;
        print(events.toString());
      });
    });
    print(khUser.summary());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar,
      drawer: AccountDrawer(khUser: khUser,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: EventList(events: events),
        ),
      ),
    );
  }
}
