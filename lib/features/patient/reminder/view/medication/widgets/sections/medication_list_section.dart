import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_schedule.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/sections/selectable_cards/medication_selectable_card.dart';

/// list of selectable medication cards (matches figma)
class MedicationListSection extends StatelessWidget {
  final List<MedicineModel> items;
  final Set<String> selectedIds;

  final List<ReminderItem> reminders;

  final ValueChanged<String> onToggleSelect;
  final ValueChanged<MedicineModel> onSetReminder;
  final double bottomPadding;

  const MedicationListSection({
    super.key,
    required this.items,
    required this.selectedIds,
    required this.reminders,
    required this.onToggleSelect,
    required this.onSetReminder,
    this.bottomPadding = 16
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return ListView.builder(
      padding: EdgeInsets.only(bottom: bottomPadding),
      itemCount: items.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final m = items[index];

        final bool isSelected = selectedIds.contains(m.id);

        final related = reminders.where((r) => r.medicine.id == m.id).toList();

        final sch = getScheduleForOneMedicine(
          medicine: m,
          reminders: reminders,
        );

        final int? dose = related.isEmpty
            ? null
            : related.map((e) => e.dose).reduce((a, b) => a > b ? a : b);

        final String? doseText = related.isEmpty ? null : 'Dose: $dose';

        final timesPerDay = related
            .map((r) => (r.time.hour * 60) + r.time.minute)
            .toSet()
            .length;

        final String? scheduleText = related.isEmpty
            ? null
            : 'Schedule: $timesPerDay times/day';

        final String? frequencyText = related.isEmpty
            ? null
            : 'Frequency: ${sch.frequency}';

        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: MedicationSelectableCard(
            medicine: m,
            isSelected: isSelected,
            badgeText: m.requiresPrescription ? 'Prescription' : 'Ordered',
            doseText: doseText,
            scheduleText: scheduleText,
            frequencyText: frequencyText,
            onTap: () => onToggleSelect(m.id),
            onSetReminder: () => onSetReminder(m),
          ),
        );
      },
    );
  }
}
