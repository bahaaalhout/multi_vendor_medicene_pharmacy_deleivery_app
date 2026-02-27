import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/selected/bottomsheet/adjust_reminder_bottom_sheet.dart';

List<MedicineModel> getSelectedMeds({
  required Set<String> selectedIds,
  required List<MedicineModel> listA,
  required List<MedicineModel> listB,
}) {
  final all = [...listA, ...listB];
  final map = {for (final m in all) m.id: m};
  return selectedIds.map((id) => map[id]).whereType<MedicineModel>().toList();
}

void removeMedicineWithOverrides({
  required void Function(VoidCallback fn) setState,
  required Set<String> selectedIds,
  required Map<String, AdjustedScheduleResult> singleOverrides,
  required AdjustedScheduleResult? multiOverride,
  required ValueSetter<AdjustedScheduleResult?> setMultiOverride,
  required String id,
}) {
  setState(() {
    selectedIds.remove(id);
    singleOverrides.remove(id);

    if (selectedIds.isEmpty) {
      singleOverrides.clear();
      setMultiOverride(null);
      return;
    }

    if (selectedIds.length == 1 && multiOverride != null) {
      final remainingId = selectedIds.first;
      singleOverrides[remainingId] = multiOverride;
      setMultiOverride(null);
      return;
    }

    if (selectedIds.length <= 1) {
      setMultiOverride(null);
    }
  });
}

void clearAllWithOverrides({
  required void Function(VoidCallback fn) setState,
  required Set<String> selectedIds,
  required Map<String, AdjustedScheduleResult> singleOverrides,
  required ValueSetter<AdjustedScheduleResult?> setMultiOverride,
}) {
  setState(() {
    selectedIds.clear();
    singleOverrides.clear();
    setMultiOverride(null);
  });
}

Future<AdjustedScheduleResult?> openAdjustBottomSheet({
  required BuildContext context,
  required List<MedicineModel> selected,
  required String title,
  required String subtitle,
  required bool sameSchedule,
  required List<String> times,
  required List<String> days,
  required String frequency,
  bool showRemoveInSelectedCard = true,
  bool showDaysInSelectedCard = true,
}) {
  return showModalBottomSheet<AdjustedScheduleResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => AdjustReminderBottomSheet(
      selected: selected,
      title: title,
      subtitle: subtitle,
      sameSchedule: sameSchedule,
      times: times,
      days: days,
      frequency: frequency,
      showRemoveInSelectedCard: showRemoveInSelectedCard,
      showDaysInSelectedCard: showDaysInSelectedCard,
    ),
  );
}