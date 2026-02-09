import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

/// Default schedule when a medicine has no reminders.
const List<String> _defaultTimes = ['08:00 AM'];
const List<String> _defaultDays = ['Every day'];
const String _defaultFrequency = 'Daily';

/// Schedule result used by UI (times, days, frequency + sameSchedule flag).
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

/// Final effective schedule after applying overrides.
class EffectiveSchedule {
  final List<String> times;
  final List<String> days;
  final String frequency;

  const EffectiveSchedule({
    required this.times,
    required this.days,
    required this.frequency,
  });

  /// Empty schedule when nothing exists yet.
  factory EffectiveSchedule.empty() {
    return const EffectiveSchedule(
      times: <String>[],
      days: <String>[],
      frequency: '',
    );
  }

  /// Default schedule fallback.
  factory EffectiveSchedule.defaultSchedule() {
    return const EffectiveSchedule(
      times: _defaultTimes,
      days: _defaultDays,
      frequency: _defaultFrequency,
    );
  }
}

/// Filters reminders by date range and weekday match.
List<ReminderItem> filterRemindersByDate(
  List<ReminderItem> reminders,
  DateTime date,
) {
  final weekday = date.weekday;

  return reminders.where((r) {
    final inRange = !date.isBefore(r.startDate) && !date.isAfter(r.endDate);
    final matchesDay = r.days.contains(weekday);
    return inRange && matchesDay;
  }).toList();
}

/// Builds schedule for a single medicine from reminders (falls back to default when missing).
ReminderScheduleResult getScheduleForOneMedicine({
  required MedicineModel medicine,
  required List<ReminderItem> reminders,
}) {
  final related = reminders.where((r) => r.medicine.id == medicine.id).toList();

  // If no reminders exist for this medicine, return a default schedule.
  if (related.isEmpty) {
    return const ReminderScheduleResult(
      times: _defaultTimes,
      days: _defaultDays,
      frequency: _defaultFrequency,
      sameSchedule: true,
    );
  }

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
    times: times.isEmpty ? _defaultTimes : times,
    days: days.isEmpty ? _defaultDays : days,
    frequency: freq.isEmpty ? _defaultFrequency : freq,
    sameSchedule: true,
  );
}

/// Builds schedule for multiple medicines and checks if they share the same schedule.
ReminderScheduleResult getScheduleForMedicines({
  required List<MedicineModel> medicines,
  required List<ReminderItem> reminders,
}) {
  // If nothing is selected, return default schedule.
  if (medicines.isEmpty) {
    return const ReminderScheduleResult(
      times: _defaultTimes,
      days: _defaultDays,
      frequency: _defaultFrequency,
      sameSchedule: true,
    );
  }

  // If only one medicine is selected, return its schedule (with fallback).
  if (medicines.length == 1) {
    return getScheduleForOneMedicine(
      medicine: medicines.first,
      reminders: reminders,
    );
  }

  final schedules = medicines
      .map((m) => getScheduleForOneMedicine(medicine: m, reminders: reminders))
      .toList();

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

/// Resolves effective schedule using overrides, otherwise falls back to reminders/default.
EffectiveSchedule resolveEffectiveSchedule({
  required Set<String> selectedIds,
  required Map<String, dynamic> singleOverrides,
  dynamic multiOverride, // AdjustedScheduleResult?
  required List<MedicineModel>
  allMedicines, // pass combined listA+listB from caller
  required List<ReminderItem> reminders,
}) {
  // Multi override wins.
  if (multiOverride != null) {
    return EffectiveSchedule(
      times: List<String>.from(multiOverride.times),
      days: List<String>.from(multiOverride.days),
      frequency: multiOverride.frequency,
    );
  }

  if (selectedIds.isEmpty) return EffectiveSchedule.empty();

  // If no single overrides exist for selection, fall back to schedule from reminders/default.
  final selectedMeds = _mapSelectedMedicines(selectedIds, allMedicines);
  final baseSchedule = getScheduleForMedicines(
    medicines: selectedMeds,
    reminders: reminders,
  );

  // If only one medicine is selected and no override exists, show its schedule (or default).
  if (selectedIds.length == 1) {
    final onlyId = selectedIds.first;
    final ov = singleOverrides[onlyId];
    if (ov == null) {
      return EffectiveSchedule(
        times: baseSchedule.times,
        days: baseSchedule.days,
        frequency: baseSchedule.frequency,
      );
    }
  }

  // If overrides are partial, also fall back to reminders/default.
  EffectiveSchedule? first;
  for (final id in selectedIds) {
    final override = singleOverrides[id];
    if (override == null) {
      return EffectiveSchedule(
        times: baseSchedule.times,
        days: baseSchedule.days,
        frequency: baseSchedule.frequency,
      );
    }

    final current = EffectiveSchedule(
      times: List<String>.from(override.times),
      days: List<String>.from(override.days),
      frequency: override.frequency,
    );

    first ??= current;

    if (!_sameEffective(first, current)) {
      return EffectiveSchedule(
        times: baseSchedule.times,
        days: baseSchedule.days,
        frequency: baseSchedule.frequency,
      );
    }
  }

  return first ??
      EffectiveSchedule(
        times: baseSchedule.times,
        days: baseSchedule.days,
        frequency: baseSchedule.frequency,
      );
}

/// Maps selected ids to MedicineModel list.
List<MedicineModel> _mapSelectedMedicines(
  Set<String> ids,
  List<MedicineModel> all,
) {
  final map = {for (final m in all) m.id: m};
  return ids.map((id) => map[id]).whereType<MedicineModel>().toList();
}

int _todMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

/// Formats TimeOfDay to readable string (e.g., 8:05am).
String _formatTime(TimeOfDay t) {
  final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
  final minute = t.minute.toString().padLeft(2, '0');
  final suffix = t.period == DayPeriod.am ? 'am' : 'pm';
  return '$hour:$minute$suffix';
}

/// Converts weekday number to day name.
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
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

bool _sameEffective(EffectiveSchedule a, EffectiveSchedule b) {
  return _sameList(a.times, b.times) &&
      _sameList(a.days, b.days) &&
      a.frequency == b.frequency;
}
