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
    this.timesPerDay = 1,
    this.frequency = 'Daily',
  });
}

//Unique key
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
