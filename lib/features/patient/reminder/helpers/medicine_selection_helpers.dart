import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

//merge 2 lists to one map (id -> model) then return selected list
List<MedicineModel> getSelectedMedicinesFromTwoLists({
  required Set<String> selectedIds,
  required List<MedicineModel> listA,
  required List<MedicineModel> listB,
}) {
  final all = [...listA, ...listB];
  final map = {for (final m in all) m.id: m};

  //return only existing ids (safe)
  return selectedIds.map((id) => map[id]).whereType<MedicineModel>().toList();
}

//toggle selected id (add/remove)
void toggleSelectedId(Set<String> selectedIds, String id) {
  if (selectedIds.contains(id)) {
    selectedIds.remove(id);
  } else {
    selectedIds.add(id);
  }
}
