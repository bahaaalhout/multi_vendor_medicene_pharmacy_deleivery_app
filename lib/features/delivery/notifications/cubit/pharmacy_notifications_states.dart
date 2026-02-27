import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/notifications/model/pharmacy_notification_item.dart';

abstract class PharmacyNotificationsStates {}

class PharmacyNotificationsInitialState extends PharmacyNotificationsStates {}

class PharmacyNotificationsLoadingState extends PharmacyNotificationsStates {}

class PharmacyNotificationsSuccessState extends PharmacyNotificationsStates {
  final List<PharmacyNotificationItem> items;

  PharmacyNotificationsSuccessState({required this.items});
}

class PharmacyNotificationsErrorState extends PharmacyNotificationsStates {
  final String errorMsg;
  PharmacyNotificationsErrorState(this.errorMsg);
}
