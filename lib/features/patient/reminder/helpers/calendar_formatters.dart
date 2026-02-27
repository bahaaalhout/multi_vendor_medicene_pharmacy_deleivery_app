import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/helpers.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/day_item.dart';

/// Returns month label like "January 2025".
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

/// Builds 6 weeks (42 cells) for a month grid.
List<DateTime> buildCalendarDays(DateTime monthStart) {
  final firstDay = DateTime(monthStart.year, monthStart.month, 1);
  final startOffset = (firstDay.weekday - DateTime.monday) % 7;
  final start = firstDay.subtract(Duration(days: startOffset));
  return List.generate(42, (i) => start.add(Duration(days: i)));
}

/// Returns previous month start date (yyyy-mm-01).
DateTime prevMonthStart(DateTime monthStart) =>
    DateTime(monthStart.year, monthStart.month - 1, 1);

/// Returns next month start date (yyyy-mm-01).
DateTime nextMonthStart(DateTime monthStart) =>
    DateTime(monthStart.year, monthStart.month + 1, 1);

/// Clamps selected day into the provided month (handles months with fewer days).
DateTime clampSelectedToMonth(DateTime selected, DateTime monthStart) {
  final lastDay = DateTime(monthStart.year, monthStart.month + 1, 0).day;
  final day = selected.day.clamp(1, lastDay);
  return DateTime(monthStart.year, monthStart.month, day);
}

/// Builds a day strip around center date (range default 3 => 7 items).
List<DayItem> buildDaysStrip(DateTime centerDate, {int range = 3}) {
  final days = <DayItem>[];

  for (int i = -range; i <= range; i++) {
    final date = centerDate.add(Duration(days: i));
    days.add(
      DayItem(
        dayLetter: _dayLetter(date.weekday),
        dayNumber: date.day,
        date: date,
      ),
    );
  }

  return days;
}

/// Checks if two dates are the same calendar day (ignores time).
bool isSameCalendarDay(DateTime a, DateTime b) => isSameDay(a, b);

String _dayLetter(int weekday) {
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