import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';

String formatFullDate(DateTime d) {
  const months = [
    'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
  ];
  final day = d.day.toString().padLeft(2, '0');
  final month = months[d.month - 1];
  return '$day $month ${d.year}';
}

String dayCodeToFull(String code) {
  switch (code) {
    case 'Sun': return 'Sunday';
    case 'Mon': return 'Monday';
    case 'Tue': return 'Tuesday';
    case 'Wed': return 'Wednesday';
    case 'Thu': return 'Thursday';
    case 'Fri': return 'Friday';
    case 'Sat': return 'Saturday';
    default: return 'Sunday';
  }
}

String frequencyToSub(String freq) {
  final f = freq.trim().toLowerCase();
  if (f == 'weekly') return 'weekly';
  return 'daily';
}

DateTime estimateEndDateForMedicine({
  required int quantity,
  required int dosePerTime,
  required List<String> times,
  required List<String> days,
  required String frequency,
  required DateTime start,
}) {
  final timesCount = times.length;
  final freq = frequency.trim().toLowerCase();

  if (timesCount <= 0) return start.add(const Duration(days: 1));
  if (quantity <= 0) return start.add(const Duration(days: 1));

  // Weekly: doses only happen on selected days
  final daysCount = days.isEmpty ? 7 : days.length;

  final averageDailyDoses = (freq == 'weekly')
      ? ((timesCount * daysCount) / 7.0) * dosePerTime
      : (timesCount * dosePerTime).toDouble();

  if (averageDailyDoses <= 0) return start.add(const Duration(days: 1));

  final totalDays = (quantity / averageDailyDoses).ceil();
  return start.add(Duration(days: totalDays));
}

Map<String, DateTime> estimateEndDatesForSelectedMeds({
  required List<MedicineModel> meds,
  required AdjustedScheduleResult schedule,
  required DateTime start,
  int dosePerTime = 1,
}) {
  final result = <String, DateTime>{};

  final times = schedule.times;
  final days = schedule.days;
  final frequency = schedule.frequency;

  for (final m in meds) {
    result[m.id] = estimateEndDateForMedicine(
      quantity: m.quantity,
      dosePerTime: dosePerTime,
      times: times,
      days: days,
      frequency: frequency,
      start: start,
    );
  }

  return result;
}