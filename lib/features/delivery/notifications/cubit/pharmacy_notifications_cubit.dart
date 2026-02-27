import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/notifications/model/pharmacy_notification_item.dart';
import 'pharmacy_notifications_states.dart';

class PharmacyNotificationsCubit extends Cubit<PharmacyNotificationsStates> {
  //constructor(list of notifications) : super constructor takes intialState
  PharmacyNotificationsCubit(List<PharmacyNotificationItem> notifications)
    : super(PharmacyNotificationsInitialState()) {
    //create local copy (avoid modifying global data list)
    localNotifications = [...notifications];
  }

  //local list of notifications
  late List<PharmacyNotificationItem> localNotifications;

  //load notifications (no tabs - like figma)
  void loadNotifications() async {
    //loading state
    emit(PharmacyNotificationsLoadingState());
    try {
      //sort by latest first
      final ordered = [...localNotifications]
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      //return success state
      emit(PharmacyNotificationsSuccessState(items: ordered));
    } catch (e) {
      //or if there's a problem (error state)
      emit(PharmacyNotificationsErrorState(e.toString()));
    }
  }

  //mark all as read then reload
  void markAllAsRead() {
    for (final item in localNotifications) {
      item.isRead = true;
    }
    loadNotifications();
  }
}
