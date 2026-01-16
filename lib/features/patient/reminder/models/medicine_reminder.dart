import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

class MedicineReminder {
  final String id;

  final MedicineModel medicine;

  final TimeOfDay time;
  final int dose; // 1, 2, ...
  final DateTime startDate;
  final DateTime endDate;

  final List<int> days; // 1=Mon ... 7=Sun

  bool done;

  MedicineReminder({
    required this.id,
    required this.medicine,
    required this.time,
    required this.dose,
    required this.startDate,
    required this.endDate,
    required this.days,
    this.done = false,
  });
}
