import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/sections/calendar_tabs.dart';
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

/// Computes previous period based on the active tab.
///
/// Month: previous month, selected day clamped to month length.
/// Week : move selected date back 7 days.
/// Day  : move selected date back 1 day.
CalendarNavResult computePrevPeriod({
  required CalendarViewTab tab,
  required DateTime currentMonth,
  required DateTime selectedDate,
}) {
  return _computePeriodDelta(
    tab: tab,
    currentMonth: currentMonth,
    selectedDate: selectedDate,
    direction: -1,
  );
}

/// Computes next period based on the active tab.
///
/// Month: next month, selected day clamped to month length.
/// Week : move selected date forward 7 days.
/// Day  : move selected date forward 1 day.
CalendarNavResult computeNextPeriod({
  required CalendarViewTab tab,
  required DateTime currentMonth,
  required DateTime selectedDate,
}) {
  return _computePeriodDelta(
    tab: tab,
    currentMonth: currentMonth,
    selectedDate: selectedDate,
    direction: 1,
  );
}

/// Computes today's navigation (reset selected date + current month).
CalendarNavResult computeToday() {
  final now = DateTime.now();
  final selected = DateTime(now.year, now.month, now.day);
  final month = DateTime(now.year, now.month, 1);
  return CalendarNavResult(currentMonth: month, selectedDate: selected);
}

CalendarNavResult _computePeriodDelta({
  required CalendarViewTab tab,
  required DateTime currentMonth,
  required DateTime selectedDate,
  required int direction,
}) {
  // Normalize selected date to a date-only value to keep navigation stable.
  final selected = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

  if (tab == CalendarViewTab.month) {
    final newMonth = direction < 0 ? prevMonthStart(currentMonth) : nextMonthStart(currentMonth);
    final newSelected = clampSelectedToMonth(selected, newMonth);
    return CalendarNavResult(currentMonth: newMonth, selectedDate: newSelected);
  }

  final deltaDays = (tab == CalendarViewTab.week) ? 7 : 1;
  final newSelected = selected.add(Duration(days: direction * deltaDays));
  final newMonth = DateTime(newSelected.year, newSelected.month, 1);

  return CalendarNavResult(currentMonth: newMonth, selectedDate: newSelected);
}