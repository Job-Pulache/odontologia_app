class HistoryItem {
  final String title;
  final String category;
  final String pdfUrl;

  HistoryItem({
    required this.title,
    required this.category,
    required this.pdfUrl,
  });

  Map<String, dynamic> toMap() {
    return {'title': title, 'category': category, 'pdfUrl': pdfUrl};
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      title: map['title'],
      category: map['category'],
      pdfUrl: map['pdfUrl'],
    );
  }
}
