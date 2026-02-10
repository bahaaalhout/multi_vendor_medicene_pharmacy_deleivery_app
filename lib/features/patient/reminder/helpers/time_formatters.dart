import 'package:flutter/material.dart';

/// Formats TimeOfDay to readable string (e.g. 8:05am).
String formatTime(TimeOfDay t) {
  final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
  final minute = t.minute.toString().padLeft(2, '0');
  final suffix = t.period == DayPeriod.am ? 'am' : 'pm';
  return '$hour:$minute$suffix';
}

/// Compares two formatted time strings like "8:15am" for sorting.
int compareTimeStrings(String a, String b) {
  int toMinutes(String s) {
    final lower = s.toLowerCase().trim();
    final isPm = lower.endsWith('pm');

    final timePart = lower.replaceAll('am', '').replaceAll('pm', '');
    final parts = timePart.split(':');

    var h = int.parse(parts[0]);
    final m = int.parse(parts[1]);

    if (h == 12) h = 0;
    var total = h * 60 + m;
    if (isPm) total += 12 * 60;

    return total;
  }

  return toMinutes(a).compareTo(toMinutes(b));
}
