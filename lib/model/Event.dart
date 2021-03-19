class KHEvent {
  String title;
  String description;
  String location;
  DateTime dateTime;
  String presenter;
  bool isExpanded = false;

  KHEvent({
    this.title,
    this.description,
    this.location,
    this.dateTime,
    this.presenter
  });

  KHEvent.from(Map<String, String> map) {
    title = map["title"];
    description = map["description"];
    location = map["location"];
    dateTime = DateTime.parse(map["dateTime"]);
    presenter = map["presenter"];
  }

  String toString() {
    return title+" "+presenter;
  }
}