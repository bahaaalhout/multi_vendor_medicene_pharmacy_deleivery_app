import '../models/notification_item.dart';

//get priority for notification sorting
int notificationPriority(NotificationItem item) {
  return item.category == NotificationCategory.rating ? 0 : 1;
}

//sort notifications (rating first)
List<NotificationItem> sortNotifications(List<NotificationItem> items) {
  final list = [...items];
  list.sort(
    (a, b) => notificationPriority(a).compareTo(notificationPriority(b)),
  );
  return list;
}
