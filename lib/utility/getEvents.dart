import 'package:http/http.dart' as http;
import 'package:club_app_2021/model/Event.dart';
import "package:club_app_2021/constants.dart";
import 'dart:convert';

Future<List<KHEvent>> getEvents() async {
  http.Response response = await http.get(eventsURL);

  String data = response.body;
  Iterable decoded = jsonDecode(data)["events"];

  List<KHEvent> events =
      List<KHEvent>.from(decoded.map((value) => KHEvent.from(value)));

  return events;
}
