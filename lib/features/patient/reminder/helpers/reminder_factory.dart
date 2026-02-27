import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/date_time_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_schedule.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

List<ReminderItem> buildReminderItems({
  required List<MedicineModel> medicines,
  required List<String> times,
  required List<String> days,
  required String frequency,
  required DateTime startDate,
  required DateTime endDate,
  int dose = 1,
}) {
  final now = DateTime.now();

  final dayIndexes = days.isEmpty
      ? const [1, 2, 3, 4, 5, 6, 7] // Mon..Sun
      : days.map(dayCodeToWeekday).toSet().toList();

  final start = dateOnly(startDate);
  final end = dateOnly(endDate);

  final List<ReminderItem> result = [];

  for (final med in medicines) {
    for (final t in times) {
      result.add(
        ReminderItem(
          id: '${med.id}_${t}_${now.microsecondsSinceEpoch}',
          medicine: med,
          time: parseTimeFlexible(t),
          dose: dose,
          startDate: start,
          endDate: end,
          days: dayIndexes,
          done: false,
          timesPerDay: times.length,
          frequency: frequency,
        ),
      );
    }
  }

  return result;
}
