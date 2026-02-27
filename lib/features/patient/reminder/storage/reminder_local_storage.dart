import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

class ReminderLocalStorage {
  static const _kKey = 'reminders_v1';

  // Persists reminders as a list of JSON strings.
  Future<void> saveReminders(List<ReminderItem> list) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = list.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_kKey, encoded);
  }

  // Loads reminders and resolves medicine objects from the provided list.
  Future<List<ReminderItem>> loadReminders({
    required List<MedicineModel> allMedicines,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_kKey);
    if (raw == null || raw.isEmpty) return [];

    final medMap = {for (final m in allMedicines) m.id: m};

    final out = <ReminderItem>[];
    for (final s in raw) {
      final map = jsonDecode(s) as Map<String, dynamic>;
      final medId = map['medicineId']?.toString();
      final med = medId == null ? null : medMap[medId];
      if (med == null) continue;

      out.add(ReminderItem.fromJson(map, medicine: med));
    }

    return out;
  }

  // Clears stored reminders.
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kKey);
  }
}