//this file contains shared date & time utility functions
//used across the app (notifications, reminders, logs, etc)

///----------------------------
/// TIME FORMATTING
///----------------------------
library;


//format time into human readable text
//example: Now, 5 min ago, 2h ago, Yesterday, 3d ago
String formatTimeAgo(DateTime time) {
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

///----------------------------
/// DATE NAVIGATION
///----------------------------

//return next day from given date
DateTime nextDay(DateTime currentDate) {
  return currentDate.add(const Duration(days: 1));
}

//return previous day from given date
DateTime prevDay(DateTime currentDate) {
  return currentDate.subtract(const Duration(days: 1));
}

///----------------------------
/// DATE COMPARISON
///----------------------------

//check if two dates are the same day (ignore time)
bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

//check if given date is today (real current day)
bool isToday(DateTime date) {
  final now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}
