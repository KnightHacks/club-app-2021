import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:club_app_2021/screens/faq.dart';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // Have to use a custom app bar since we have a tab bar
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            "assets/knightHacksLogoGold.png",
            width: 150,
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.event),),
              Tab(icon: Icon(Icons.question_answer),)
            ],
          ),
        ),
        drawer: AccountDrawer(
          khUser: khUser,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TabBarView(
              children: [
                EventList(events: events),
                FAQ(),
              ],
            )
          ),
        ),
      ),
    );
  }
}
