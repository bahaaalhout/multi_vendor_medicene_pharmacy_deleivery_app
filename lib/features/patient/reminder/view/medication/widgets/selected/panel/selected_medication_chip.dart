import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SelectedMedicationChip extends StatelessWidget {
  final String text;
  const SelectedMedicationChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.neutralLightActive),
      ),
      child: Text(
        text,
        style: AppTextStyles.medium10.copyWith(
          color: AppColors.secondaryDarker,
        ),
      ),
    );
  }
}
