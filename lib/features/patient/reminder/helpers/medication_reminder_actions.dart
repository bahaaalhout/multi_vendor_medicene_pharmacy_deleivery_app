import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_reminder_tabs.dart';

//----------------------------------
//get list by tab
//----------------------------------
List<MedicineModel> getItemsByTab({
  required MedicationReminderTab tab,
  required List<MedicineModel> prescriptions,
  required List<MedicineModel> recents,
}) {
  return tab == MedicationReminderTab.prescriptions ? prescriptions : recents;
}

//----------------------------------
//get selected meds from two lists
//----------------------------------
List<MedicineModel> getSelectedMeds({
  required Set<String> selectedIds,
  required List<MedicineModel> listA,
  required List<MedicineModel> listB,
}) {
  final all = [...listA, ...listB];
  final map = {for (final m in all) m.id: m};

  return selectedIds.map((id) => map[id]).whereType<MedicineModel>().toList();
}

//----------------------------------
//change tab
//----------------------------------
void changeTab({
  required void Function(VoidCallback fn) setState,
  required void Function(MedicationReminderTab v) setTab,
  required MedicationReminderTab newTab,
}) {
  setState(() => setTab(newTab));
}

//----------------------------------
//toggle select (tap on card)
//----------------------------------
void toggleSelect({
  required void Function(VoidCallback fn) setState,
  required Set<String> selectedIds,
  required String id,
}) {
  setState(() {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
  });
}

//----------------------------------
//add to selected (Set reminder button)
//----------------------------------
void addToSelected({
  required void Function(VoidCallback fn) setState,
  required Set<String> selectedIds,
  required MedicineModel medicine,
}) {
  setState(() => selectedIds.add(medicine.id));
}

//----------------------------------
//remove one selected
//----------------------------------
void removeSelected({
  required void Function(VoidCallback fn) setState,
  required Set<String> selectedIds,
  required String id,
}) {
  setState(() => selectedIds.remove(id));
}

//----------------------------------
//clear all selected
//----------------------------------
void clearAllSelected({
  required void Function(VoidCallback fn) setState,
  required Set<String> selectedIds,
}) {
  setState(() => selectedIds.clear());
}

//----------------------------------
//toast helper
//----------------------------------
void showToast(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
