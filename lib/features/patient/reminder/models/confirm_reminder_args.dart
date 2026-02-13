import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';

class ConfirmReminderArgs {
  final List<MedicineModel> medicines;
  final AdjustedScheduleResult schedule;

  const ConfirmReminderArgs({required this.medicines, required this.schedule});
}
