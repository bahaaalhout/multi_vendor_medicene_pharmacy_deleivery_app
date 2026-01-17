import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/day_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

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

List<DayItem> buildDaysStrip(DateTime centerDate, {int range = 3}) {
  final List<DayItem> days = [];

  for (int i = -range; i <= range; i++) {
    final date = centerDate.add(Duration(days: i));
    days.add(
      DayItem(
        dayLetter: _getDayLetter(date.weekday),
        dayNumber: date.day,
        date: date,
      ),
    );
  }

  return days;
}

String _getDayLetter(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'M';
    case DateTime.tuesday:
      return 'T';
    case DateTime.wednesday:
      return 'W';
    case DateTime.thursday:
      return 'T';
    case DateTime.friday:
      return 'F';
    case DateTime.saturday:
      return 'S';
    case DateTime.sunday:
      return 'S';
    default:
      return '';
  }
}
