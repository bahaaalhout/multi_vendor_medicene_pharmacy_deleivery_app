import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/time_formatters.dart';

class ScheduleCalculator {
  /// Distribute dose times evenly across 24 hours starting from [startTime].
  /// frequency: times per day (1..n)
  /// Returns times formatted as "h:mm AM/PM" and sorted.
  static List<String> calculateTimes({
    required TimeOfDay startTime,
    required int frequency,
  }) {
    if (frequency <= 1) {
      return [formatTime(startTime)];
    }

    final startMinutes = _toMinutes(startTime);
    final interval = 1440 ~/ frequency;

    final minutesList = <int>[];

    for (int i = 0; i < frequency; i++) {
      final m = (startMinutes + (i * interval)) % 1440;
      minutesList.add(m);
    }

    // ✅ Sort to keep UI consistent (even with wrap-around)
    minutesList.sort();

    // ✅ Map to formatted strings + remove duplicates just in case
    final result = <String>[];
    int? last;
    for (final m in minutesList) {
      if (last == m) continue;
      last = m;

      result.add(formatTime(_fromMinutes(m)));
    }

    return result;
  }

  static int _toMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

  static TimeOfDay _fromMinutes(int total) {
    final h = total ~/ 60;
    final m = total % 60;
    return TimeOfDay(hour: h, minute: m);
  }
}
