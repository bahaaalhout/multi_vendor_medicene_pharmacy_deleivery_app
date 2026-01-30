import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';

import 'selected_medication_header.dart';
import 'selected_medication_info_rows.dart';

class SelectedMedicationPanel extends StatelessWidget {
  final MedicineModel medicine;

  //data
  final List<String> times;
  final List<String> days;
  final String frequency;
  final String frequencyHint;

  //actions
  final VoidCallback onRemove;

  const SelectedMedicationPanel({
    super.key,
    required this.medicine,
    required this.times,
    required this.days,
    required this.frequency,
    required this.frequencyHint,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          //header row
          SelectedMedicationHeader(medicine: medicine, onRemove: onRemove),

          SizedBox(height: 12.h),

          //info rows
          SelectedMedicationInfoRows(
            times: times,
            days: days,
            frequency: frequency,
            frequencyHint: frequencyHint,
          ),
        ],
      ),
    );
  }
}
