import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/time_formatters.dart';

class ScheduleCalculator {
  /// Distributes dose times evenly across 24 hours.
  /// The user selects only the start time and frequency.
  /// The system calculates the remaining times automatically.
  static List<String> calculateTimes({
    required TimeOfDay startTime,
    required int frequency,
  }) {
    if (frequency <= 1) {
      return [formatTime(startTime)];
    }

    final startMinutes = _toMinutes(startTime);
    final intervalMinutes = 1440 ~/ frequency;

    final minutesList = <int>[];

    for (int i = 0; i < frequency; i++) {
      final minutes = (startMinutes + (i * intervalMinutes)) % 1440;
      minutesList.add(minutes);
    }

    // Keep schedule ordered for consistent UI
    minutesList.sort();

    return minutesList.map((m) => formatTime(_fromMinutes(m))).toList();
  }

  static int _toMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

  static TimeOfDay _fromMinutes(int totalMinutes) {
    final hour = totalMinutes ~/ 60;
    final minute = totalMinutes % 60;
    return TimeOfDay(hour: hour, minute: minute);
  }
}
