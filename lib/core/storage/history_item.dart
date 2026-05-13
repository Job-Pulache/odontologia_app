class HistoryItem {
  final String title;
  final String category;

  HistoryItem({required this.title, required this.category});

  Map<String, dynamic> toJson() {
    return {'title': title, 'category': category};
  }

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(title: json['title'], category: json['category']);
  }
}
