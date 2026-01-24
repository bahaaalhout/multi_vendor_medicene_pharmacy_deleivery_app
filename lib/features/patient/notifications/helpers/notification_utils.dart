import '../models/notification_item.dart';

//get section title based on selected category
String getSectionTitle(NotificationCategory category) {
  switch (category) {
    case NotificationCategory.all:
      return 'All Notifications';
    case NotificationCategory.offer:
      return 'Offers';
    case NotificationCategory.medicineReminder:
      return 'Medicine Reminders';
    case NotificationCategory.rating:
      return 'Rating';
  }
}
