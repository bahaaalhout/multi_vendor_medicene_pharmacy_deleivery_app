import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_selectable_card.dart';

/// list of selectable medication cards (matches figma)
class MedicationListSection extends StatelessWidget {
  final List<MedicineModel> items;

  ///  multi
  final Set<String> selectedIds;

  final ValueChanged<String> onToggleSelect;
  final ValueChanged<MedicineModel> onSetReminder;

  const MedicationListSection({
    super.key,
    required this.items,
    required this.selectedIds,
    required this.onToggleSelect,
    required this.onSetReminder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((m) {
        final bool isSelected = selectedIds.contains(m.id);

        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: MedicationSelectableCard(
            medicine: m,
            isSelected: isSelected,
            badgeText: m.requiresPrescription ? 'Prescription' : 'Ordered',

            ///  card tap toggles selection
            onTap: () => onToggleSelect(m.id),

            ///  button adds (or you can toggle too)
            onSetReminder: () => onSetReminder(m),
          ),
        );
      }).toList(),
    );
  }
}
