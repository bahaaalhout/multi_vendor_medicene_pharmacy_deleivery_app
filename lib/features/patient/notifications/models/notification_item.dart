enum NotificationCategory { all, offer, medicineReminder, rating }

class NotificationItem {
  final String id;
  final NotificationCategory category;
  final String title;
  final String description;
  final DateTime createdAt;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.createdAt,
    this.isRead = false,
  });
}
