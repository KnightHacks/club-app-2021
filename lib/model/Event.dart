class Event {
  String title;
  String description;
  String time;
  String location;
  String date;
  String month;
  String presenter;

  Event({
    this.title,
    this.description,
    this.time,
    this.location,
    this.date,
    this.month,
    this.presenter
  });

  Event.from(Map<String, String> map) {
    title = map["title"];
    description = map["description"];
    time = map["time"];
    location = map["location"];
    date = map["date"];
    month = map["month"];
    presenter = map["presenter"];
  }

  String toString() {
    return title+" "+presenter;
  }
}