import 'package:flutter/material.dart';
import 'package:ical/serializer.dart';

class Event {
  String title;
  String description;
  String location;
  DateTime dateTime;
  String presenter;

  Event({
    this.title,
    this.description,
    this.location,
    this.dateTime,
    this.presenter
  });

  Event.from(Map<String, String> map) {
    title = map["title"];
    description = map["description"];
    location = map["location"];
    dateTime = DateTime.parse(map["dateTime"]);
    presenter = map["presenter"];
  }

  String toString() {
    return title+" "+presenter;
  }

  ICalendar addToCal() {
    ICalendar ical = ICalendar();
    ical.addElement(
      IEvent(
        start: this.dateTime,
        summary: this.title,
        description: this.description
      )
    );
    return ical;
  }
}