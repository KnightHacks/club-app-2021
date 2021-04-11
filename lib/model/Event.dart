class KHEvent {
  late final String title;
  late final String? description;
  late final String location;
  late final DateTime dateTime;
  late final String? presenter;
  bool isExpanded = false;

  KHEvent(
      {required this.title,
      required this.description,
      required this.location,
      required this.dateTime,
      required this.presenter});

  KHEvent.from(Map<String, dynamic> map) {
    title = map["name"];
    description = map["description"];
    location = "Zoom";
    dateTime = DateTime.parse(map["date"]);
    presenter = map["presenter"];
  }

  String toString() {
    return title + " with " + (presenter ?? "NA");
  }
}
