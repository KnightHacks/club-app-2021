/// Wrapper class for FAQ items.
/// 
/// Used when retrieving the FAQ from http request. The returned json is parsed
/// and the questions and answers are stored in objects of this class.

class FAQListItem {
  String question;
  String answer;
  bool isExpanded = false;

  FAQListItem(String title, String description) {
    this.question = title;
    this.answer = description;
  }

  /// Converts JSON Map into a ListItem
  FAQListItem.fromJson(Map<String, dynamic> json) {
    question = json["question"];
    answer = json["answer"];
  }
}