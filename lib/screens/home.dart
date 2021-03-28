import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:club_app_2021/model/KnightHacksUser.dart';
import 'package:club_app_2021/utility/getEvents.dart';
import 'package:club_app_2021/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:club_app_2021/model/Event.dart';
import 'package:club_app_2021/constants.dart';
import 'package:club_app_2021/widgets/account_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_app_2021/model/ShirtSize.dart';

class Home extends StatefulWidget {
  static const String id = "Home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<KHEvent> events = List<KHEvent>();
  KnightHackUser khUser;

  /// Converts String to ShirtSize
  /// 
  /// Turns string returned from firestore into a ShirtSize so it can be stored
  /// in KhUser object and passed.
  ShirtSize stringToShirtSize (String size){

    ShirtSize res;
    try{
      switch(size){

        case "S":
          res = ShirtSize.S;
          break;

        case "M":
          res = ShirtSize.M;
          break;
        
        case "L":
          res = ShirtSize.L;
          break;

        case "XL":
          res = ShirtSize.XL;
          break;

        case "XXL":
          res = ShirtSize.XXL;
          break;
        
        default:
          res = null;
          break;
      }
    } catch(e){
      print(e.toString());
    }
    return res;
  }

  /// Creates KnightHackUser object for signed in user.
  /// 
  /// Creating the khUser object in home page since it doesnt work when
  /// created on login. This is because the navigator method used was
  /// popAndPushNamed. Since it pops first, we cannot access any arguments
  /// passed from the popped page in the pushed one. Recall that popping removes
  /// the page from the navigator stack. PopAndPushNamed makes the pushed page
  /// disconnected from the previous pages, essentially clearing the stack and
  /// pushing this page on. This behavior is desireable for when we do not want
  /// users to navigate to a previous page, like login. However, it is good to 
  /// recognize the consequences of using this method, in this case, not being
  /// able to use arguments passed from the previous page.
  Future<KnightHackUser> _getUser() async {
    Map<String, dynamic> data;
    KnightHackUser _khUser;
    try{
      
      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      String id = user.uid;
      final _firestore = Firestore.instance;

      await _firestore
          .collection('user')
          .where('uid', isEqualTo: id)
          .getDocuments()
          .then((value) {
        // always returns an array of documents
        // casting it as a Map
        data = value.documents[0].data;

        _khUser = new KnightHackUser(
          uid: data["uid"].toString(),
          docId: value.documents[0].documentID,
          email: user.email,
          fullName: data["fullName"].toString(),
          street: data["street"].toString(),
          apartment: data["apartment"].toString(),
          city: data["city"].toString(),
          state: data["state"].toString(),
          zip: data["zip"].toString(),
          shirtSize: stringToShirtSize(data["shirtSize"].toString()),
        );
      });
      print(_khUser.summary());
    } catch(e) {
      print(e.toString());
    }
    return _khUser;
  }

  @override
  void initState() {
    super.initState();

    _getUser().then((_khUser){
      khUser = _khUser;
    });

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
      drawer: AccountDrawer(khUser: khUser,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
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
                                    icon: Icon(
                                      Icons.calendar_today_outlined
                                    ),
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
      ),
    );
  }
}
