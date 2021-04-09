class FAQListItem {
  late final String question;
  late final String answer;
  bool isExpanded = false;

  FAQListItem({required this.question, required this.answer});

  /// Converts JSON Map into a ListItem
  FAQListItem.fromJson(Map<String, dynamic> json) {
    question = json["question"];
    answer = json["answer"];
  }
}