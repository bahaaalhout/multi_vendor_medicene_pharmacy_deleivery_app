import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_schedule.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_panel_widgets/selected_medication_panel.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_section_widgets/adjust_link.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_section_widgets/create_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_section_widgets/different_schedule_note.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_section_widgets/selected_section_title_row.dart';

class SelectedMedicationsSection extends StatelessWidget {
  final List<MedicineModel> medicines;

  final ValueChanged<List<MedicineModel>> onCreateReminders;
  final VoidCallback onClearAll;

  final ValueChanged<MedicineModel> onAdjustSingle;
  final ValueChanged<List<MedicineModel>> onAdjustMulti;

  final ValueChanged<String> onRemoveMedicine;

  final String frequencyHint;
  final bool sameSchedule;

  final Map<String, AdjustedScheduleResult> singleOverrides;

  final List<String> groupTimes;
  final List<String> groupDays;
  final String groupFrequency;
  final Widget? footer;

  const SelectedMedicationsSection({
    super.key,
    required this.medicines,
    required this.onCreateReminders,
    required this.onClearAll,
    required this.onAdjustSingle,
    required this.onAdjustMulti,
    required this.onRemoveMedicine,
    required this.sameSchedule,
    required this.singleOverrides,
    required this.groupTimes,
    required this.groupDays,
    required this.groupFrequency,
    this.frequencyHint = 'until you finish the tablet',
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    if (medicines.isEmpty) return const SizedBox.shrink();

    final count = medicines.length;
    final isDifferent = count > 1 && !sameSchedule;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.neutralNormal, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectedSectionTitleRow(onClearAll: onClearAll),
          SizedBox(height: 12.h),

          if (isDifferent) ...[DifferentScheduleNote(), SizedBox(height: 12.h)],

          Column(
            children: medicines.map((medicine) {
              // default from fake_data per medicine
              final base = getScheduleForOneMedicine(
                medicine: medicine,
                reminders: reminders,
              );

              // single override if exists
              final ov = singleOverrides[medicine.id];

              // if sameSchedule and multi group is provided, you can show group for all
              final showGroup = !isDifferent && count > 1;

              final times = ov?.times ?? (showGroup ? groupTimes : base.times);
              final days = ov?.days ?? (showGroup ? groupDays : base.days);
              final freq =
                  ov?.frequency ??
                  (showGroup ? groupFrequency : base.frequency);

              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: SelectedMedicationPanel(
                  medicine: medicine,
                  times: times,
                  days: days,
                  frequency: freq,
                  frequencyHint: frequencyHint,
                  color: AppColors.secondaryLight,
                  compact: isDifferent,
                  disableAdjust: isDifferent,

                  onRemove: () => onRemoveMedicine(medicine.id),
                  onAdjust: isDifferent
                      ? () {}
                      : () => onAdjustSingle(medicine),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 6.h),

          CreateButton(
            count: count,
            isDifferent: isDifferent,
            onTap: () => onCreateReminders(medicines),
          ),

          SizedBox(height: 10.h),

          AdjustLink(
            count: count,
            disabled: isDifferent,
            onTap: () {
              if (isDifferent) return;

              if (count == 1) {
                onAdjustSingle(medicines.first);
                return;
              }

              onAdjustMulti(medicines);
            },
          ),

          if (footer != null) footer!,
        ],
      ),
    );
  }
}
