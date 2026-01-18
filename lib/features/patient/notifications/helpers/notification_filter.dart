import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/models/notification_item.dart';

List<NotificationItem> filterNotificationsByCategory(
  List<NotificationItem> items,
  NotificationCategory category,
) {
  if (category == NotificationCategory.all) {
    return items;
  }
  return items.where((n) => n.category == category).toList();
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
