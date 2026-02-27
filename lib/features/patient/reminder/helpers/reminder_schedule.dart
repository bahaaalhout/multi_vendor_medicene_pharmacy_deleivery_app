import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_datetime.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/date_time_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

/// Converts a day code (Mon/Tue/...) to DateTime weekday int (Mon=1..Sun=7).
int dayCodeToWeekday(String d) {
  switch (d.trim()) {
    case 'Mon':
      return DateTime.monday;
    case 'Tue':
      return DateTime.tuesday;
    case 'Wed':
      return DateTime.wednesday;
    case 'Thu':
      return DateTime.thursday;
    case 'Fri':
      return DateTime.friday;
    case 'Sat':
      return DateTime.saturday;
    case 'Sun':
      return DateTime.sunday;
    default:
      return DateTime.sunday;
  }
}

/// Filters reminders by selected date:
/// - Must be within [startDate..endDate]
/// - Must match the selected weekday
List<ReminderItem> filterRemindersByDate(
  List<ReminderItem> reminders,
  DateTime date,
) {
  final d = dateOnly(date);
  final weekday = d.weekday;

  return reminders.where((r) {
    final start = dateOnly(r.startDate);
    final end = dateOnly(r.endDate);

    final inRange = !d.isBefore(start) && !d.isAfter(end);
    final matchesDay = r.days.contains(weekday);

    return inRange && matchesDay;
  }).toList();
}

/// Schedule result derived from existing reminders.
/// Used for displaying/labeling schedules and comparing schedules.
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

  ReminderScheduleResult copyWith({bool? sameSchedule}) {
    return ReminderScheduleResult(
      times: times,
      days: days,
      frequency: frequency,
      sameSchedule: sameSchedule ?? this.sameSchedule,
    );
  }
}

/// Effective schedule computed from overrides or existing reminders.
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

/// Returns schedule for a single medicine based on existing reminders.
ReminderScheduleResult getScheduleForOneMedicine({
  required MedicineModel medicine,
  required List<ReminderItem> reminders,
}) {
  final related = reminders.where((r) => r.medicine.id == medicine.id).toList();

  if (related.isEmpty) {
    return ReminderScheduleResult.empty();
  }

  related.sort((a, b) => _todMinutes(a.time).compareTo(_todMinutes(b.time)));

  final times = related
      .map((r) => ReminderDateTime.formatTime(r.time))
      .toSet()
      .toList()
    ..sort(compareTimeStrings);

  final daySet = <int>{};
  for (final r in related) {
    daySet.addAll(r.days);
  }

  final dayList = daySet.toList()..sort();
  final days = dayList.map(_weekdayToCode).toList();
  final freq = (dayList.length == 7) ? 'Daily' : 'Weekly';

  return ReminderScheduleResult(
    times: times,
    days: days,
    frequency: freq,
    sameSchedule: true,
  );
}

/// Returns combined schedule information for multiple medicines.
/// The schedule is marked as `sameSchedule=false` if the medicines do not match.
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

  final same = schedules.every((s) {
    return _sameList(s.times, base.times) &&
        _sameList(s.days, base.days) &&
        s.frequency == base.frequency;
  });

  return ReminderScheduleResult(
    times: base.times,
    days: base.days,
    frequency: base.frequency,
    sameSchedule: same,
  );
}

/// Resolves effective schedule using:
/// - multiOverride (highest priority)
/// - singleOverrides (if selection supports it)
/// - otherwise falls back to existing reminders schedule
EffectiveSchedule resolveEffectiveSchedule({
  required Set<String> selectedIds,
  required Map<String, AdjustedScheduleResult> singleOverrides,
  required AdjustedScheduleResult? multiOverride,
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

  if (selectedIds.length == 1) {
    final id = selectedIds.first;
    final ov = singleOverrides[id];

    if (ov != null) {
      return EffectiveSchedule(
        times: List<String>.from(ov.times),
        days: List<String>.from(ov.days),
        frequency: ov.frequency,
      );
    }

    final base = getScheduleForMedicines(
      medicines: selectedMeds,
      reminders: reminders,
    );

    return EffectiveSchedule(
      times: base.times,
      days: base.days,
      frequency: base.frequency,
    );
  }

  EffectiveSchedule? first;

  for (final id in selectedIds) {
    final ov = singleOverrides[id];

    if (ov == null) {
      final base = getScheduleForMedicines(
        medicines: selectedMeds,
        reminders: reminders,
      );
      return EffectiveSchedule(
        times: base.times,
        days: base.days,
        frequency: base.frequency,
      );
    }

    final current = EffectiveSchedule(
      times: List<String>.from(ov.times),
      days: List<String>.from(ov.days),
      frequency: ov.frequency,
    );

    first ??= current;

    if (!_sameEffective(first, current)) {
      final base = getScheduleForMedicines(
        medicines: selectedMeds,
        reminders: reminders,
      );
      return EffectiveSchedule(
        times: base.times,
        days: base.days,
        frequency: base.frequency,
      );
    }
  }

  return first ?? EffectiveSchedule.empty();
}

/// Parses both "8:00 AM" and "20:00" safely.
TimeOfDay parseTimeFlexible(String s) {
  return ReminderDateTime.parseTime(s);
}

/// Compares time strings by parsing to TimeOfDay.
int compareTimeStrings(String a, String b) {
  final ta = ReminderDateTime.parseTime(a);
  final tb = ReminderDateTime.parseTime(b);
  return ReminderDateTime.compareTime(ta, tb);
}

/// Builds reminders for selected medicines given:
/// - times (string list)
/// - days (Mon/Tue/...)
/// - date range
List<ReminderItem> buildRemindersForMedicines({
  required List<MedicineModel> medicines,
  required List<String> times,
  required List<String> days,
  required DateTime startDate,
  required DateTime endDate,
  int dose = 1,
}) {
  final result = <ReminderItem>[];
  final weekdayInts = days.map(dayCodeToWeekday).toList();

  for (final med in medicines) {
    for (final t in times) {
      final tod = parseTimeFlexible(t);

      result.add(
        ReminderItem(
          id: 'r_${med.id}_${tod.hour}_${tod.minute}',
          medicine: med,
          time: tod,
          dose: dose,
          days: weekdayInts,
          startDate: startDate,
          endDate: endDate,
          frequency: days.length == 7 ? 'Daily' : 'Weekly',
        ),
      );
    }
  }

  return result;
}

List<MedicineModel> _mapSelectedMedicines(
  Set<String> ids,
  List<MedicineModel> all,
) {
  final map = {for (final m in all) m.id: m};
  return ids.map((id) => map[id]).whereType<MedicineModel>().toList();
}

int _todMinutes(TimeOfDay t) => t.hour * 60 + t.minute;

String _weekdayToCode(int d) {
  switch (d) {
    case DateTime.monday:
      return 'Mon';
    case DateTime.tuesday:
      return 'Tue';
    case DateTime.wednesday:
      return 'Wed';
    case DateTime.thursday:
      return 'Thu';
    case DateTime.friday:
      return 'Fri';
    case DateTime.saturday:
      return 'Sat';
    case DateTime.sunday:
      return 'Sun';
    default:
      return 'Mon';
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

extension EffectiveScheduleX on EffectiveSchedule {
  bool get isValid =>
      times.isNotEmpty && days.isNotEmpty && frequency.trim().isNotEmpty;

  AdjustedScheduleResult toAdjusted() => AdjustedScheduleResult(
        times: List<String>.from(times),
        days: List<String>.from(days),
        frequency: frequency,
      );
}