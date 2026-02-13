import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

import 'selected_medication_frequency_row.dart';
import 'selected_medication_header_row.dart';
import 'selected_medication_info_row.dart';

class SelectedMedicationPanel extends StatelessWidget {
  final MedicineModel medicine;

  final List<String> times;
  final List<String> days;
  final String frequency;
  final String frequencyHint;
  final Color? color;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;

  final bool compact;
  final bool disableAdjust;

  final VoidCallback onRemove;
  final VoidCallback onAdjust;

  final bool showFrequency;

  final bool showDays;

  final bool showRemove;

  const SelectedMedicationPanel({
    super.key,
    required this.medicine,
    required this.times,
    required this.days,
    required this.frequency,
    required this.frequencyHint,
    required this.onRemove,
    required this.onAdjust,
    this.compact = false,
    this.disableAdjust = false,
    this.showFrequency = true,
    this.showDays = true,
    this.showRemove = true,
    this.color,
    this.borderColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Container(
        width: double.infinity,
        padding: padding ?? EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primaryLightActive),
        ),
        child: SelectedMedicationHeaderRow(
          medicine: medicine,
          onRemove: onRemove,
          showRemove: showRemove,
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      child: Column(
        children: [
          SelectedMedicationHeaderRow(
            medicine: medicine,
            onRemove: onRemove,
            showRemove: showRemove,
          ),
          SizedBox(height: 12.h),

          SelectedMedicationInfoRow(
            label: 'Time:',
            iconPath: "assets/icons/alarm_icon.svg",
            chips: times,
          ),

          if (showDays) ...[
            SizedBox(height: 12.h),
            SelectedMedicationInfoRow(
              label: 'Days:',
              iconPath: "assets/icons/alarm_icon.svg",
              chips: days,
            ),
          ],

          if (showFrequency) ...[
            SizedBox(height: 12.h),
            SelectedMedicationFrequencyRow(
              frequency: frequency,
              hint: frequencyHint,
            ),
          ],
        ],
      ),
    );
  }
}
