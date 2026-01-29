import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_selectable_card.dart';

/// list of selectable medication cards (matches figma)
class MedicationListSection extends StatelessWidget {
  final List<MedicineModel> items;
  final String? selectedId;
  final ValueChanged<String> onSelect;
  final ValueChanged<MedicineModel> onSetReminder;

  const MedicationListSection({
    super.key,
    required this.items,
    required this.selectedId,
    required this.onSelect,
    required this.onSetReminder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((m) {
        final bool isSelected = m.id == selectedId;

        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: MedicationSelectableCard(
            medicine: m,
            isSelected: isSelected,
            badgeText: m.requiresPrescription ? 'Prescription' : 'Ordered',
            onTap: () => onSelect(m.id),
            onSetReminder: () => onSetReminder(m),
          ),
        );
      }).toList(),
    );
  }
}
