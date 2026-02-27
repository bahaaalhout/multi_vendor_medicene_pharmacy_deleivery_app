library;

import 'package:flutter/material.dart' show TimeOfDay;
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_datetime.dart';

// Human-readable "time ago"
String timeAgo(DateTime time) {
  final now = DateTime.now();
  final diff = now.difference(time);

  if (diff.inMinutes < 1) return 'Now';
  if (diff.inHours < 1) return '${diff.inMinutes} min ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays == 1) return 'Yesterday';
  return '${diff.inDays}d ago';
}

// Date navigation
DateTime dateOnly(DateTime d) => ReminderDateTime.dateOnly(d);
DateTime nextDay(DateTime d) => ReminderDateTime.nextDay(d);
DateTime prevDay(DateTime d) => ReminderDateTime.prevDay(d);
DateTime nextWeek(DateTime d) => ReminderDateTime.nextWeek(d);
DateTime prevWeek(DateTime d) => ReminderDateTime.prevWeek(d);

// Time helpers
int timeToMinutes(TimeOfDay t) => ReminderDateTime.timeToMinutes(t);
DateTime combineDateTime(DateTime day, TimeOfDay t) => ReminderDateTime.combine(day, t);

// Date comparison
bool isSameDay(DateTime a, DateTime b) => ReminderDateTime.isSameDay(a, b);
bool isToday(DateTime date) => isSameDay(date, DateTime.now());

bool isBeforeDay(DateTime a, DateTime b) {
  final da = dateOnly(a);
  final db = dateOnly(b);
  return da.isBefore(db);
}

bool isAfterDay(DateTime a, DateTime b) {
  final da = dateOnly(a);
  final db = dateOnly(b);
  return da.isAfter(db);
}

// Labels
String weekdayLabel(DateTime d) {
  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return days[d.weekday - 1];
}

// Parsing
TimeOfDay parseTime(String t) => ReminderDateTime.parseTime(t);

int dayToIndex(String d) {
  const map = {
    'Sunday': 0,
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6,
  };
  return map[d] ?? 0;
}