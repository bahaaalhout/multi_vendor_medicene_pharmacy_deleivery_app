import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_reminder_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/adjust_bottom_sheet_widgets/adjust_reminder_bottom_sheet.dart';

/// Returns list of medicines based on active tab.
List<MedicineModel> getItemsByTab({
  required MedicationReminderTab tab,
  required List<MedicineModel> prescriptions,
  required List<MedicineModel> recents,
}) {
  return tab == MedicationReminderTab.prescriptions ? prescriptions : recents;
}

/// Returns selected medicines from two lists using ids.
List<MedicineModel> getSelectedMeds({
  required Set<String> selectedIds,
  required List<MedicineModel> listA,
  required List<MedicineModel> listB,
}) {
  final all = [...listA, ...listB];
  final map = {for (final m in all) m.id: m};
  return selectedIds.map((id) => map[id]).whereType<MedicineModel>().toList();
}

/// Updates tab state.
void changeTab({
  required void Function(VoidCallback fn) setState,
  required void Function(MedicationReminderTab v) setTab,
  required MedicationReminderTab newTab,
}) {
  setState(() => setTab(newTab));
}

/// Toggles selection state for an id.
void toggleSelect({
  required void Function(VoidCallback fn) setState,
  required Set<String> selectedIds,
  required String id,
}) {
  setState(() {
    selectedIds.contains(id) ? selectedIds.remove(id) : selectedIds.add(id);
  });
}

/// Adds medicine to selected ids.
void addToSelected({
  required void Function(VoidCallback fn) setState,
  required Set<String> selectedIds,
  required MedicineModel medicine,
}) {
  setState(() => selectedIds.add(medicine.id));
}

/// Removes one selected id.
void removeSelected({
  required void Function(VoidCallback fn) setState,
  required Set<String> selectedIds,
  required String id,
}) {
  setState(() => selectedIds.remove(id));
}

/// Clears all selected ids.
void clearAllSelected({
  required void Function(VoidCallback fn) setState,
  required Set<String> selectedIds,
}) {
  setState(() => selectedIds.clear());
}

/// Shows a quick snackbar toast message.
void showToast(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

/// Opens adjust reminder bottom sheet and returns AdjustedScheduleResult.
/// Opens adjust reminder bottom sheet and returns AdjustedScheduleResult.
Future<AdjustedScheduleResult?> openAdjustBottomSheet({
  required BuildContext context,
  required List<MedicineModel> selected,
  required String title,
  required String subtitle,
  required bool sameSchedule,
  required List<String> times,
  required List<String> days,
  required String frequency,

  // ✅ NEW (defaults for single)
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

/// Picks selected items from a source list using selectedIds set.
List<T> pickSelected<T>({
  required Set<String> selectedIds,
  required List<T> source,
  required String Function(T item) idOf,
}) {
  if (selectedIds.isEmpty) return <T>[];
  return source.where((item) => selectedIds.contains(idOf(item))).toList();
}

/// Removes a medicine and keeps overrides state consistent (restores remaining item schedule).
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

/// Clears all selected medicines and resets overrides.
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
