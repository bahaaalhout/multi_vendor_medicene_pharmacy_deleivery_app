import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

///----------------------------
/// REMINDER FILTER
///----------------------------

//filter reminders by date range + weekday
List<ReminderItem> filterRemindersByDate(
  List<ReminderItem> reminders,
  DateTime date,
) {
  final weekday = date.weekday;

  return reminders.where((r) {
    final inRange = !date.isBefore(r.startDate) && !date.isAfter(r.endDate);
    final matchesDay = r.days.contains(weekday);
    return inRange && matchesDay;
  }).toList();
}
