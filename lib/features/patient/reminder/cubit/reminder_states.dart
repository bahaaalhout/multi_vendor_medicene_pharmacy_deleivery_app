import '../models/day_item.dart';
import '../models/reminder_item.dart';

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
