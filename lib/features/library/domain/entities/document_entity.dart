class DocumentEntity {
  final String title;
  final String category;
  final String type;
  final String description;
  final bool isDownloaded;
  final bool isFavorite;

  const DocumentEntity({
    required this.title,
    required this.category,
    required this.type,
    required this.description,
    this.isDownloaded = false,
    this.isFavorite = false,
  });
}
