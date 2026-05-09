class DocumentEntity {
  final String title;
  final String category;
  final String type;
  final String description;
  final String filePath;
  final bool isDownloaded;
  final bool isFavorite;

  const DocumentEntity({
    required this.title,
    required this.category,
    required this.type,
    required this.description,
    required this.filePath,
    this.isDownloaded = false,
    this.isFavorite = false,
  });
}
