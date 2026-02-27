import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

//small chip used in selected medication section (time/days/frequency)
class ReminderInfoChip extends StatelessWidget {
  final String text;
  const ReminderInfoChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
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
