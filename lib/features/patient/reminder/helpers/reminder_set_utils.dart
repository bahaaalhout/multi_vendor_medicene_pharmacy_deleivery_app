import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/confirm_reminder_args.dart';

String safeFreqLabel(String freq) {
  final f = freq.trim();
  if (f.isEmpty) return 'daily';
  return f.toLowerCase();
}

DateTime estimateEndDateFromSchedule(ConfirmReminderArgs args) {
  final start = DateTime.now();
  final timesCount = args.schedule.times.length;
  if (timesCount <= 0) return start.add(const Duration(days: 1));

  final quantities = args.medicines.map((m) => m.quantity).toList()..sort();
  final minQty = quantities.isEmpty ? 1 : quantities.first;

  final freq = args.schedule.frequency.trim().toLowerCase();
  final daysCount = args.schedule.days.length;

  if (freq == 'weekly') {
    final perWeek = timesCount * (daysCount <= 0 ? 1 : daysCount);
    final weeks = (minQty / perWeek).floor();
    final totalDays = (weeks <= 0 ? 7 : weeks * 7);
    return start.add(Duration(days: totalDays));
  }

  final days = (minQty / timesCount).floor();
  final totalDays = (days <= 0 ? 1 : days);
  return start.add(Duration(days: totalDays));
}

String formatShortMonthDay(DateTime d) {
  const months = [
    'Jan','Feb','Mar','Apr','May','Jun',
    'Jul','Aug','Sep','Oct','Nov','Dec',
  ];
  final month = months[d.month - 1];
  final day = d.day.toString().padLeft(2, '0');
  return '$month $day';
}