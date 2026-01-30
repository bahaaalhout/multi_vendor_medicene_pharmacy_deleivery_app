import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_panel.dart';

class SelectedMedicationsSection extends StatelessWidget {
  final List<MedicineModel> medicines;

  //actions
  final ValueChanged<List<MedicineModel>> onCreateReminders;
  final VoidCallback onClearAll;
  final VoidCallback onAdjustReminder;

  //remove one medicine by id
  final ValueChanged<String> onRemoveMedicine;

  //temp fixed data (connect later per medicine)
  final List<String> times;
  final List<String> days;
  final String frequency;
  final String frequencyHint;

  const SelectedMedicationsSection({
    super.key,
    required this.medicines,
    required this.onCreateReminders,
    required this.onClearAll,
    required this.onAdjustReminder,
    required this.onRemoveMedicine,
    this.times = const ['8:00am', '2:00pm', '9:00am'],
    this.days = const ['Saturday', 'Monday', 'Wednesday'],
    this.frequency = 'Daily',
    this.frequencyHint = 'until you finish the tablet',
  });

  @override
  Widget build(BuildContext context) {
    //if empty -> do nothing
    if (medicines.isEmpty) return const SizedBox.shrink();

    final count = medicines.length;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.neutralNormal, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title + clear all
          _TitleRow(onClearAll: onClearAll),

          SizedBox(height: 16.h),

          //panels list (one per medicine)
          Column(
            children: medicines.map((medicine) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: SelectedMedicationPanel(
                  medicine: medicine,
                  times: times,
                  days: days,
                  frequency: frequency,
                  frequencyHint: frequencyHint,
                  onRemove: () => onRemoveMedicine(medicine.id),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 16.h),

          //create reminder button for all
          _CreateButton(
            count: count,
            onTap: () => onCreateReminders(medicines),
          ),

          SizedBox(height: 13.h),

          //adjust reminder
          _AdjustButton(count: count, onTap: onAdjustReminder),
        ],
      ),
    );
  }
}

//----------------------------------
//title row
//----------------------------------
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

//----------------------------------
//create reminders button
//----------------------------------
class _CreateButton extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  const _CreateButton({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final label = count == 1
        ? 'Create Reminder'
        : 'Create Reminder for $count Medications';

    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: Material(
        color: AppColors.primaryNormal,
        borderRadius: BorderRadius.circular(16.r),
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

//----------------------------------
//adjust button
//----------------------------------
class _AdjustButton extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  const _AdjustButton({required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final label = count == 1
        ? 'Adjust reminder'
        : 'Adjust reminder time for $count Medications';

    return Center(
      child: InkWell(
        onTap: onTap,
        child: Text(
          label,
          style: AppTextStyles.semiBold12.copyWith(
            color: AppColors.primaryNormal,
          ),
        ),
      ),
    );
  }
}
