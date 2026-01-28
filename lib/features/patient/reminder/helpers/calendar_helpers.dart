import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/date_time_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/day_item.dart';

///----------------------------
/// MONTH LABEL
///----------------------------

//return month label like: January 2025
String monthYearLabel(DateTime d) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return '${months[d.month - 1]} ${d.year}';
}

///----------------------------
/// MONTH GRID DAYS (42 CELLS)
///----------------------------

//build 6 weeks (42 cells) to match figma layout
//monday-based header: M T W T F S S
List<DateTime> buildCalendarDays(DateTime monthStart) {
  final firstDay = DateTime(monthStart.year, monthStart.month, 1);

  //monday-based index: Monday->0 ... Sunday->6
  final startOffset = (firstDay.weekday - DateTime.monday) % 7;
  final start = firstDay.subtract(Duration(days: startOffset));

  return List.generate(42, (i) => start.add(Duration(days: i)));
}

///----------------------------
/// MONTH NAVIGATION
///----------------------------

//return previous month start date (yyyy-mm-01)
DateTime prevMonthStart(DateTime monthStart) {
  return DateTime(monthStart.year, monthStart.month - 1, 1);
}

//return next month start date (yyyy-mm-01)
DateTime nextMonthStart(DateTime monthStart) {
  return DateTime(monthStart.year, monthStart.month + 1, 1);
}

///----------------------------
/// MONTH CLAMP
///----------------------------

//if selected day not exists in new month -> clamp it
DateTime clampSelectedToMonth(DateTime selected, DateTime monthStart) {
  final lastDay = DateTime(monthStart.year, monthStart.month + 1, 0).day;
  final day = selected.day.clamp(1, lastDay);
  return DateTime(monthStart.year, monthStart.month, day);
}

///----------------------------
/// DAYS STRIP
///----------------------------

//build days strip around selected date (M T W T F S S)
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

//convert weekday to strip letter
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

///----------------------------
/// DATE SHORTCUTS
///----------------------------

//check if two dates are the same day (ignore time)
bool isSameCalendarDay(DateTime a, DateTime b) {
  return isSameDay(a, b);
}
