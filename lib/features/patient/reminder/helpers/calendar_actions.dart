import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_formatters.dart';

/// Holds navigation result for current month and selected date.
class CalendarNavResult {
  final DateTime currentMonth;
  final DateTime selectedDate;

  const CalendarNavResult({
    required this.currentMonth,
    required this.selectedDate,
  });
}

/// Computes previous period based on current tab.
CalendarNavResult computePrevPeriod({
  required CalendarViewTab tab,
  required DateTime currentMonth,
  required DateTime selectedDate,
}) {
  if (tab == CalendarViewTab.month) {
    final newMonth = prevMonthStart(currentMonth);
    final newSelected = clampSelectedToMonth(selectedDate, newMonth);
    return CalendarNavResult(currentMonth: newMonth, selectedDate: newSelected);
  }

  if (tab == CalendarViewTab.week) {
    final newSelected = selectedDate.subtract(const Duration(days: 7));
    final newMonth = DateTime(newSelected.year, newSelected.month, 1);
    return CalendarNavResult(currentMonth: newMonth, selectedDate: newSelected);
  }

  final newSelected = selectedDate.subtract(const Duration(days: 1));
  final newMonth = DateTime(newSelected.year, newSelected.month, 1);
  return CalendarNavResult(currentMonth: newMonth, selectedDate: newSelected);
}

/// Computes next period based on current tab.
CalendarNavResult computeNextPeriod({
  required CalendarViewTab tab,
  required DateTime currentMonth,
  required DateTime selectedDate,
}) {
  if (tab == CalendarViewTab.month) {
    final newMonth = nextMonthStart(currentMonth);
    final newSelected = clampSelectedToMonth(selectedDate, newMonth);
    return CalendarNavResult(currentMonth: newMonth, selectedDate: newSelected);
  }

  if (tab == CalendarViewTab.week) {
    final newSelected = selectedDate.add(const Duration(days: 7));
    final newMonth = DateTime(newSelected.year, newSelected.month, 1);
    return CalendarNavResult(currentMonth: newMonth, selectedDate: newSelected);
  }

  final newSelected = selectedDate.add(const Duration(days: 1));
  final newMonth = DateTime(newSelected.year, newSelected.month, 1);
  return CalendarNavResult(currentMonth: newMonth, selectedDate: newSelected);
}

/// Computes today's navigation (reset selected date + current month).
CalendarNavResult computeToday() {
  final now = DateTime.now();
  final selected = DateTime(now.year, now.month, now.day);
  final month = DateTime(now.year, now.month, 1);
  return CalendarNavResult(currentMonth: month, selectedDate: selected);
}
