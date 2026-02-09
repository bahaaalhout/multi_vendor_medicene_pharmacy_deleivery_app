import '../models/notification_item.dart';

abstract class NotificationsStates {}

class NotificationsInitialState extends NotificationsStates {}

class NotificationsLoadingState extends NotificationsStates {}

class NotificationsSuccessState extends NotificationsStates {
  final DateTime selectedDate;
  final NotificationCategory selectedCategory;
  final String sectionTitle;
  final List<NotificationItem> orderedItems;

  NotificationsSuccessState({
    required this.selectedDate,
    required this.selectedCategory,
    required this.sectionTitle,
    required this.orderedItems,
  });
}

class NotificationsErrorState extends NotificationsStates {
  final String errorMsg;
  NotificationsErrorState(this.errorMsg);
}
