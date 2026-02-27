import 'package:flutter/material.dart';

class ReminderDateTime {
  // Date-only (strips time)
  static DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  // Combines a date with a TimeOfDay
  static DateTime combine(DateTime day, TimeOfDay t) =>
      DateTime(day.year, day.month, day.day, t.hour, t.minute);

  // Same calendar day (ignores time)
  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  // Day navigation (1 day)
  static DateTime nextDay(DateTime d) => d.add(const Duration(days: 1));
  static DateTime prevDay(DateTime d) => d.subtract(const Duration(days: 1));

  // Week navigation (7 days)
  static DateTime nextWeek(DateTime d) => d.add(const Duration(days: 7));
  static DateTime prevWeek(DateTime d) => d.subtract(const Duration(days: 7));

  // Time helpers
  static int timeToMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

  static int compareTime(TimeOfDay a, TimeOfDay b) =>
      timeToMinutes(a).compareTo(timeToMinutes(b));

  // Formatting
  static String formatTime(TimeOfDay t) {
    final hour12 = (t.hour % 12 == 0) ? 12 : (t.hour % 12);
    final ampm = (t.hour >= 12) ? 'PM' : 'AM';
    return '$hour12:${t.minute.toString().padLeft(2, '0')} $ampm';
  }

  // Parses "8:05 AM" or "08:05" robustly
  static TimeOfDay parseTime(String input) {
    final raw = input.trim();
    if (raw.isEmpty) return const TimeOfDay(hour: 0, minute: 0);

    final lower = raw.toLowerCase();

    // 24-hour (no AM/PM)
    if (!lower.contains('am') && !lower.contains('pm')) {
      final parts = raw.split(':');
      if (parts.length != 2) return const TimeOfDay(hour: 0, minute: 0);

      final h = int.tryParse(parts[0].trim()) ?? 0;
      final m = int.tryParse(parts[1].trim()) ?? 0;

      return TimeOfDay(
        hour: h.clamp(0, 23),
        minute: m.clamp(0, 59),
      );
    }

    // 12-hour (AM/PM)
    final cleaned = lower.replaceAll(' ', '');
    final isPm = cleaned.endsWith('pm');
    final isAm = cleaned.endsWith('am');

    final timePart = cleaned.replaceAll('am', '').replaceAll('pm', '');
    final parts = timePart.split(':');
    if (parts.length != 2) return const TimeOfDay(hour: 0, minute: 0);

    int hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;

    if (isPm && hour < 12) hour += 12;
    if (isAm && hour == 12) hour = 0;

    return TimeOfDay(
      hour: hour.clamp(0, 23),
      minute: minute.clamp(0, 59),
    );
  }
}