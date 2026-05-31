class AppNotification {
  final String title;
  final String description;
  final String date;
  final bool unread;

  const AppNotification({
    required this.title,
    required this.description,
    required this.date,
    this.unread = false,
  });
}
