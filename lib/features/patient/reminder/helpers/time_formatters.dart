import 'package:flutter/material.dart';

/// Formats TimeOfDay to readable string (e.g. "8:05 AM").
/// ✅ Unified format across the project: "h:mm AM/PM"
String formatTime(TimeOfDay t) {
  final hour12 = (t.hour % 12 == 0) ? 12 : (t.hour % 12);
  final minute = t.minute.toString().padLeft(2, '0');
  final suffix = (t.hour >= 12) ? 'PM' : 'AM';
  return '$hour12:$minute $suffix';
}

/// Compares two formatted time strings like "8:15 AM" for sorting.
int compareTimeStrings(String a, String b) {
  int toMinutes(String s) {
    final cleaned = s.toLowerCase().replaceAll(' ', '');
    final isPm = cleaned.endsWith('pm');
    final isAm = cleaned.endsWith('am');

    final timePart = cleaned.replaceAll('am', '').replaceAll('pm', '');
    final parts = timePart.split(':');

    var hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0;

    if (isPm && hour != 12) hour += 12;
    if (isAm && hour == 12) hour = 0;

    return hour * 60 + minute;
  }

  return toMinutes(a).compareTo(toMinutes(b));
}
