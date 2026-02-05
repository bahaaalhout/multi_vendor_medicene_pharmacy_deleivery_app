import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_panel.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_schedule_helper.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';

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
          _TitleRow(onClearAll: onClearAll),
          SizedBox(height: 12.h),

          if (isDifferent) ...[
            _DifferentScheduleNote(),
            SizedBox(height: 12.h),
          ],

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

          _CreateButton(
            count: count,
            isDifferent: isDifferent,
            onTap: () => onCreateReminders(medicines),
          ),

          SizedBox(height: 10.h),

          _AdjustLink(
            count: count,
            disabled: isDifferent,
            onTap: () => onAdjustMulti(medicines),
          ),
        ],
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  final VoidCallback onClearAll;
  const _TitleRow({required this.onClearAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Selected medication',
          style: AppTextStyles.medium14.copyWith(
            color: AppColors.neutralDarkActive,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: onClearAll,
          child: Text(
            'Clear',
            style: AppTextStyles.semiBold12.copyWith(
              color: AppColors.primaryNormal,
            ),
          ),
        ),
      ],
    );
  }
}

class _DifferentScheduleNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Text(
        'These medications have different schedules.\nCreate a separate reminder for each medication.',
        style: AppTextStyles.reqular12.copyWith(color: const Color(0xFFB91C1C)),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  final int count;
  final bool isDifferent;
  final VoidCallback onTap;

  const _CreateButton({
    required this.count,
    required this.isDifferent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = count == 1
        ? 'Create Reminder'
        : (isDifferent
              ? 'Create reminders separately'
              : 'Create Reminder for $count Medications');

    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: Material(
        color: AppColors.primaryNormal,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.semiBold14.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _AdjustLink extends StatelessWidget {
  final int count;
  final bool disabled;
  final VoidCallback onTap;

  const _AdjustLink({
    required this.count,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = count == 1
        ? 'Adjust reminder'
        : 'Adjust reminder time for $count Medications';

    return Center(
      child: InkWell(
        onTap: disabled ? null : onTap,
        child: Text(
          label,
          style: AppTextStyles.semiBold12.copyWith(
            color: disabled ? AppColors.neutralDark : AppColors.primaryNormal,
          ),
        ),
      ),
    );
  }
}
