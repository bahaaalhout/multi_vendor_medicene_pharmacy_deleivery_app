import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/date_time_utils.dart';
import '../helpers/notification_filter.dart';
import '../helpers/notification_sort.dart';
import '../helpers/notification_utils.dart';
import '../models/notification_item.dart';
import 'notifications_states.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  //constructor(list of notifications) : super constructor takes intialState
  NotificationsCubit(List<NotificationItem> notifications)
    : super(NotificationsInitialState()) {
    //create local copy (avoid modifying global data list)
    localNotifications = [...notifications];
  }

  //local list of notifications
  late List<NotificationItem> localNotifications;

  //load notifications based on date + selected category
  void loadNotifications({
    DateTime? date,
    NotificationCategory? category,
  }) async {
    //loading state
    emit(NotificationsLoadingState());
    try {
      //if you give me date (use it), if not set newdate(now)
      final selectedDate = date ?? DateTime.now();

      //if you give me category (use it), if not set all
      final selectedCategory = category ?? NotificationCategory.all;

      //get notifications for selected day only
      final itemsForDate = localNotifications
          .where((n) => isSameDay(n.createdAt, selectedDate))
          .toList();

      //filter by selected tab
      final filtered = filterNotificationsByCategory(
        itemsForDate,
        selectedCategory,
      );

      //sort notifications (rating first)
      final orderedItems = sortNotifications(filtered);

      //get section title based on selected category
      final sectionTitle = getSectionTitle(selectedCategory);

      //return success state
      emit(
        NotificationsSuccessState(
          selectedDate: selectedDate,
          selectedCategory: selectedCategory,
          sectionTitle: sectionTitle,
          orderedItems: orderedItems,
        ),
      );
    } catch (e) {
      //or if there's a problem (error state)
      emit(NotificationsErrorState(e.toString()));
    }
  }

  //when user click on next day icon -> load next day notifications
  void nextDayPressed(
    DateTime currentDate,
    NotificationCategory currentCategory,
  ) {
    loadNotifications(date: nextDay(currentDate), category: currentCategory);
  }

  //when user click on prev day icon -> load previous day notifications
  void prevDayPressed(
    DateTime currentDate,
    NotificationCategory currentCategory,
  ) {
    loadNotifications(date: prevDay(currentDate), category: currentCategory);
  }

  //when user change tab -> reload notifications with same date but new category
  void changeCategory(DateTime currentDate, NotificationCategory newCategory) {
    loadNotifications(date: currentDate, category: newCategory);
  }

  //when user click mark as read -> mark only notifications for selected day + selected category then reload
  void markCurrentAsRead(
    DateTime currentDate,
    NotificationCategory currentCategory,
  ) {
    for (final item in localNotifications) {
      //match selected day
      if (isSameDay(item.createdAt, currentDate)) {
        if (currentCategory == NotificationCategory.all ||
            item.category == currentCategory) {
          item.isRead = true;
        }
      }
    }

    //reload after update
    loadNotifications(date: currentDate, category: currentCategory);
  }
}
