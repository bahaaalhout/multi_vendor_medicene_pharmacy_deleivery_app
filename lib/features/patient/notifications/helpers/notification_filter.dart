import '../models/notification_item.dart';

//filter notifications by category
List<NotificationItem> filterNotificationsByCategory(
  List<NotificationItem> items,
  NotificationCategory category,
) {
  if (category == NotificationCategory.all) {
    return items;
  }
  return items.where((n) => n.category == category).toList();
}
