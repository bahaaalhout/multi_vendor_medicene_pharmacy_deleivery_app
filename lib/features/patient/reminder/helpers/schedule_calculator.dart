import 'package:flutter/material.dart';

class ScheduleCalculator {
  /// Calculates a list of times distributed evenly over 24 hours.
  /// 
  /// [startTime]: The time of the first dose.
  /// [frequency]: How many times per day (e.g. 1, 2, 3, 4).
  /// 
  /// Returns a list of formatted time strings "h:mm a" (e.g. "8:00 AM").
  static List<String> calculateTimes({
    required TimeOfDay startTime,
    required int frequency,
  }) {
    if (frequency <= 1) {
      return [_formatTimeOfDay(startTime)];
    }

    final times = <String>[];
    final startMinutes = startTime.hour * 60 + startTime.minute;
    
    // 24 hours = 1440 minutes
    // Interval = 1440 / frequency
    // NOTE: Usually for "3 times a day" spanning waking hours is preferred (e.g. every 8 hours or every 6 hours), 
    // but strict 24h division equals 24/frequency hours apart.
    // Example: 3 times -> every 8 hours.
    
    final intervalMinutes = (24 * 60) ~/ frequency;

    for (int i = 0; i < frequency; i++) {
      final currentMinutes = startMinutes + (i * intervalMinutes);
      
      // Normalize to 24h format
      var normalizedMinutes = currentMinutes % (24 * 60);
      
      final hour = normalizedMinutes ~/ 60;
      final minute = normalizedMinutes % 60;
      
      times.add(_formatTimeOfDay(TimeOfDay(hour: hour, minute: minute)));
    }
    
    return times;
  }

  static String _formatTimeOfDay(TimeOfDay t) {
    final hour = t.hour;
    final minute = t.minute;
    
    final h = (hour % 12 == 0) ? 12 : (hour % 12);
    final m = minute.toString().padLeft(2, '0');
    final a = (hour >= 12) ? 'PM' : 'AM';
    
    return '$h:$m $a';
  }
}
