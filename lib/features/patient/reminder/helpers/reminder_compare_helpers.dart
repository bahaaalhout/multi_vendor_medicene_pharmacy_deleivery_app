import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

//----------------------------------
//compare schedules for multi adjust
//----------------------------------
bool haveSameSchedule({
  required List<MedicineModel> meds,
  required List<String> Function(MedicineModel) getTimes,
  required List<String> Function(MedicineModel) getDays,
  required String Function(MedicineModel) getFrequency,
}) {
  if (meds.length <= 1) return true;

  final baseTimes = getTimes(meds.first).join('|');
  final baseDays = getDays(meds.first).join('|');
  final baseFreq = getFrequency(meds.first);

  for (final m in meds.skip(1)) {
    if (getTimes(m).join('|') != baseTimes) return false;
    if (getDays(m).join('|') != baseDays) return false;
    if (getFrequency(m) != baseFreq) return false;
  }
  return true;
}
