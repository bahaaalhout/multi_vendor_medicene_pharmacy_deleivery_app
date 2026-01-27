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

/// days for month grid (35 or 42 cells)
List<DateTime> buildCalendarDays(DateTime monthStart) {
  final firstDay = DateTime(monthStart.year, monthStart.month, 1);
  final lastDay = DateTime(monthStart.year, monthStart.month + 1, 0);

  // Sunday-based index: Sunday->0, Monday->1...
  final startOffset = firstDay.weekday % 7;
  final start = firstDay.subtract(Duration(days: startOffset));

  final totalCells = ((startOffset + lastDay.day) <= 35) ? 35 : 42;
  return List.generate(totalCells, (i) => start.add(Duration(days: i)));
}

DateTime clampSelectedToMonth(DateTime selected, DateTime monthStart) {
  final lastDay = DateTime(monthStart.year, monthStart.month + 1, 0).day;
  final day = selected.day.clamp(1, lastDay);
  return DateTime(monthStart.year, monthStart.month, day);
}
