import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/day_item.dart';

List<DayItem> buildDaysStrip(DateTime centerDate, {int range = 3}) {
  final List<DayItem> days = [];

  for (int i = -range; i <= range; i++) {
    final date = centerDate.add(Duration(days: i));

    days.add(
      DayItem(
        dayLetter: getdayLetter(date.weekday),
        dayNumber: date.day,
        date: date,
      ),
    );
  }

  return days;
}

String getdayLetter(int weekday) {
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

String formatTime(DateTime time) {
  final now = DateTime.now();
  final diff = now.difference(time);

  if (diff.inMinutes < 1) {
    return 'Now';
  } else if (diff.inHours < 1) {
    return '${diff.inMinutes} min ago';
  } else if (diff.inHours < 24) {
    return '${diff.inHours}h ago';
  } else if (diff.inDays == 1) {
    return 'Yesterday';
  } else {
    return '${diff.inDays}d ago';
  }
}
