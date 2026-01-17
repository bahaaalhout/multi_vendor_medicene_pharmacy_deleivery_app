import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

class ReminderItem {
  final String id;
  final MedicineModel medicine;
  final TimeOfDay time;
  final int dose;
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
  });
}
