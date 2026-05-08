class DocumentEntity {
  final String id;
  final String title;
  final String category;
  final String content;
  final bool isFavorite;

  const DocumentEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.content,
    this.isFavorite = false,
  });
}
