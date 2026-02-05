import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

//=============================
// DATA RESULT MODEL
//=============================
class ReminderScheduleResult {
  final List<String> times;
  final List<String> days;
  final String frequency;
  final bool sameSchedule;

  const ReminderScheduleResult({
    required this.times,
    required this.days,
    required this.frequency,
    required this.sameSchedule,
  });
}

//=============================
// SINGLE MEDICINE HELPER
//=============================
ReminderScheduleResult getScheduleForOneMedicine({
  required MedicineModel medicine,
  required List<ReminderItem> reminders,
}) {
  final related = reminders.where((r) => r.medicine.id == medicine.id).toList();

  related.sort((a, b) => _todMinutes(a.time).compareTo(_todMinutes(b.time)));

  final times = related.map((r) => _formatTime(r.time)).toSet().toList();

  final daySet = <int>{};
  for (final r in related) {
    daySet.addAll(r.days);
  }

  final dayList = daySet.toList()..sort();
  final days = dayList.map(_dayName).toList();

  final freq = (dayList.length == 7) ? 'Daily' : 'Weekly';

  return ReminderScheduleResult(
    times: times,
    days: days,
    frequency: freq,
    sameSchedule: true, // دواء واحد دايمًا
  );
}

//=============================
// MULTI MEDICINES COMPARISON
//=============================
ReminderScheduleResult getScheduleForMedicines({
  required List<MedicineModel> medicines,
  required List<ReminderItem> reminders,
}) {
  if (medicines.isEmpty) {
    return const ReminderScheduleResult(
      times: [],
      days: [],
      frequency: 'Daily',
      sameSchedule: true,
    );
  }

  final schedules = medicines.map((m) {
    final one = getScheduleForOneMedicine(medicine: m, reminders: reminders);
    return _MedSchedule(
      times: one.times,
      days: one.days,
      frequency: one.frequency,
    );
  }).toList();

  final base = schedules.first;

  final same = schedules.every(
    (s) =>
        _sameList(s.times, base.times) &&
        _sameList(s.days, base.days) &&
        s.frequency == base.frequency,
  );

  return ReminderScheduleResult(
    times: base.times,
    days: base.days,
    frequency: base.frequency,
    sameSchedule: same,
  );
}

//=============================
// INTERNAL
//=============================
class _MedSchedule {
  final List<String> times;
  final List<String> days;
  final String frequency;

  _MedSchedule({
    required this.times,
    required this.days,
    required this.frequency,
  });
}

int _todMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

String _formatTime(TimeOfDay t) {
  final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
  final minute = t.minute.toString().padLeft(2, '0');
  final suffix = t.period == DayPeriod.am ? 'am' : 'pm';
  return '$hour:$minute$suffix';
}

String _dayName(int d) {
  switch (d) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return '--';
  }
}

bool _sameList(List<String> a, List<String> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
