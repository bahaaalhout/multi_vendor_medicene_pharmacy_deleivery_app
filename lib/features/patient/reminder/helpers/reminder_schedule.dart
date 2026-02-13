import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

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

  factory ReminderScheduleResult.empty() {
    return const ReminderScheduleResult(
      times: <String>[],
      days: <String>[],
      frequency: '',
      sameSchedule: true,
    );
  }
}

class EffectiveSchedule {
  final List<String> times;
  final List<String> days;
  final String frequency;

  const EffectiveSchedule({
    required this.times,
    required this.days,
    required this.frequency,
  });

  factory EffectiveSchedule.empty() {
    return const EffectiveSchedule(
      times: <String>[],
      days: <String>[],
      frequency: '',
    );
  }
}

List<ReminderItem> filterRemindersByDate(
  List<ReminderItem> reminders,
  DateTime date,
) {
  final weekday = date.weekday; // 1..7 (Mon..Sun)

  return reminders.where((r) {
    final inRange = !date.isBefore(r.startDate) && !date.isAfter(r.endDate);
    final matchesDay = r.days.contains(weekday);
    return inRange && matchesDay;
  }).toList();
}

ReminderScheduleResult getScheduleForOneMedicine({
  required MedicineModel medicine,
  required List<ReminderItem> reminders,
}) {
  final related = reminders.where((r) => r.medicine.id == medicine.id).toList();

  if (related.isEmpty) {
    return ReminderScheduleResult.empty();
  }

  related.sort((a, b) => _todMinutes(a.time).compareTo(_todMinutes(b.time)));

  final times = related.map((r) => _formatTime12(r.time)).toSet().toList()
    ..sort(_timeTextCompare);

  final daySet = <int>{};
  for (final r in related) {
    daySet.addAll(r.days);
  }
  final dayList = daySet.toList()..sort();
  final days = dayList.map(_dayNameShort).toList();

  final freq = (dayList.length == 7) ? 'Daily' : 'Weekly';

  return ReminderScheduleResult(
    times: times,
    days: days,
    frequency: freq,
    sameSchedule: true,
  );
}

ReminderScheduleResult getScheduleForMedicines({
  required List<MedicineModel> medicines,
  required List<ReminderItem> reminders,
}) {
  if (medicines.isEmpty) return ReminderScheduleResult.empty();

  if (medicines.length == 1) {
    return getScheduleForOneMedicine(
      medicine: medicines.first,
      reminders: reminders,
    );
  }

  final schedules = medicines
      .map((m) => getScheduleForOneMedicine(medicine: m, reminders: reminders))
      .toList();

  if (schedules.any(
    (s) => s.times.isEmpty || s.days.isEmpty || s.frequency.isEmpty,
  )) {
    return ReminderScheduleResult.empty().copyWith(sameSchedule: false);
  }

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

EffectiveSchedule resolveEffectiveSchedule({
  required Set<String> selectedIds,
  required Map<String, dynamic> singleOverrides,
  dynamic multiOverride,
  required List<MedicineModel> allMedicines,
  required List<ReminderItem> reminders,
}) {
  if (multiOverride != null) {
    return EffectiveSchedule(
      times: List<String>.from(multiOverride.times),
      days: List<String>.from(multiOverride.days),
      frequency: multiOverride.frequency,
    );
  }

  if (selectedIds.isEmpty) return EffectiveSchedule.empty();

  final selectedMeds = _mapSelectedMedicines(selectedIds, allMedicines);

  final baseSchedule = getScheduleForMedicines(
    medicines: selectedMeds,
    reminders: reminders,
  );

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

List<MedicineModel> _mapSelectedMedicines(
  Set<String> ids,
  List<MedicineModel> all,
) {
  final map = {for (final m in all) m.id: m};
  return ids.map((id) => map[id]).whereType<MedicineModel>().toList();
}

int _todMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

String _formatTime12(TimeOfDay t) {
  final hour12 = (t.hour % 12 == 0) ? 12 : (t.hour % 12);
  final minute = t.minute.toString().padLeft(2, '0');
  final suffix = (t.hour >= 12) ? 'PM' : 'AM';
  return '$hour12:$minute $suffix';
}

int _timeTextCompare(String a, String b) {
  final am = _timeTextToMinutes(a);
  final bm = _timeTextToMinutes(b);
  return am.compareTo(bm);
}

int _timeTextToMinutes(String s) {
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

String _dayNameShort(int d) {
  switch (d) {
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thu';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
    default:
      return '--';
  }
}

bool _sameList(List<String> a, List<String> b) {
  if (a.length != b.length) return false;
  final sa = a.toSet();
  final sb = b.toSet();
  return sa.length == sb.length && sa.containsAll(sb);
}

bool _sameEffective(EffectiveSchedule a, EffectiveSchedule b) {
  return _sameList(a.times, b.times) &&
      _sameList(a.days, b.days) &&
      a.frequency == b.frequency;
}

extension _Copy on ReminderScheduleResult {
  ReminderScheduleResult copyWith({bool? sameSchedule}) {
    return ReminderScheduleResult(
      times: times,
      days: days,
      frequency: frequency,
      sameSchedule: sameSchedule ?? this.sameSchedule,
    );
  }
}
