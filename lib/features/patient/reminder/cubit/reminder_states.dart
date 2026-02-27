  import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/day_item.dart';
  import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

  abstract class ReminderStates {}

  class ReminderInitialState extends ReminderStates {}

  class ReminderLoadingState extends ReminderStates {}

  class ReminderSuccessState extends ReminderStates {
    final DateTime selectedDate;
    final List<DayItem> days;
    final List<ReminderItem> dayReminders;

    ReminderSuccessState({
      required this.selectedDate,
      required this.days,
      required this.dayReminders,
    });
  }

  class ReminderErrorState extends ReminderStates {
    final String errorMsg;
    ReminderErrorState(this.errorMsg);
  }
