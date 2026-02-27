import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_datetime.dart';

/// Formats a TimeOfDay for UI display.
String formatTime(TimeOfDay time) {
  return ReminderDateTime.formatTime(time);
}

/// Compares two time strings by parsing them into TimeOfDay.
int compareTimeStrings(String a, String b) {
  final ta = ReminderDateTime.parseTime(a);
  final tb = ReminderDateTime.parseTime(b);
  return ReminderDateTime.compareTime(ta, tb);
}