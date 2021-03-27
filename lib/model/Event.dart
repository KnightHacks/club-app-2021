/// Wrapper class for event objects
/// 
/// This class is instantiated for the events retrieved from the notion api
/// hosted by KnightHacks. The attributes for this object are a title, description,
/// location, date time, and presenter.
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

  /// creates KHEvent objects for each key-value pair.
  KHEvent.from(Map<String, dynamic> map) {
    title = map["name"];
    description = map["description"];
    location = "Zoom";
    dateTime = DateTime.parse(map["date"]);
    presenter = map["presenter"];
  }

  /// Returns the title and presenter in a string.
  String toString() {
    return title + " " + presenter;
  }
}
