import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

class ReminderItem {
  final String id;
  final MedicineModel medicine;

  final TimeOfDay time;
  final int dose;

  final int timesPerDay;
  final String frequency;

  final DateTime startDate;
  final DateTime endDate;
  final List<int> days;

  bool isEnabled;
  bool done;

  ReminderItem({
    required this.id,
    required this.medicine,
    required this.time,
    required this.dose,
    required this.startDate,
    required this.endDate,
    required this.days,
    this.done = false,
    this.isEnabled = true,
    this.timesPerDay = 1,
    this.frequency = 'Daily',
  });

  // Single source of truth for storage
  Map<String, dynamic> toJson() => {
        'id': id,
        'medicineId': medicine.id,
        'timeHour': time.hour,
        'timeMinute': time.minute,
        'dose': dose,
        'timesPerDay': timesPerDay,
        'frequency': frequency,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'days': days,
        'done': done,
        'isEnabled': isEnabled,
      };

  factory ReminderItem.fromJson(
    Map<String, dynamic> json, {
    required MedicineModel medicine,
  }) {
    return ReminderItem(
      id: json['id'].toString(),
      medicine: medicine,
      time: TimeOfDay(
        hour: (json['timeHour'] as num).toInt(),
        minute: (json['timeMinute'] as num).toInt(),
      ),
      dose: (json['dose'] as num).toInt(),
      timesPerDay: (json['timesPerDay'] as num?)?.toInt() ?? 1,
      frequency: (json['frequency'] as String?) ?? 'Daily',
      startDate: DateTime.parse(json['startDate'].toString()),
      endDate: DateTime.parse(json['endDate'].toString()),
      days: List<int>.from(
        (json['days'] as List).map((e) => (e as num).toInt()),
      ),
      done: (json['done'] as bool?) ?? false,
      isEnabled: (json['isEnabled'] as bool?) ?? true,
    );
  }
}

// Unique key for "same reminder" detection
extension ReminderItemKeyX on ReminderItem {
  String get uniqueKey {
    final t =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    final d = [...days]..sort();
    final s =
        '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
    final e =
        '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';

    return '${medicine.id}|$t|${d.join(",")}|$s|$e';
  }
}