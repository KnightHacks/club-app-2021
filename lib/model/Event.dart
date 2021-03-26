class KHEvent {
  String title;
  String description;
  String location;
  DateTime dateTime;
  String presenter;
  bool isExpanded = false;

  KHEvent(
      {this.title,
      this.description,
      this.location,
      this.dateTime,
      this.presenter});

  KHEvent.from(Map<String, dynamic> map) {
    title = map["name"];
    description = "Description";
    location = "Zoom";
    dateTime = DateTime.parse(map["date"]);
    presenter = map["presenter"];
  }

  String toString() {
    return title + " " + presenter;
  }
}
