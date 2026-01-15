import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class StepLabel extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isCompleted;
  final TextAlign alignment;

  const StepLabel({
    super.key,
    required this.label,
    required this.isActive,
    required this.isCompleted,
    this.alignment = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor;
    FontWeight fontWeight;

    if (isCompleted) {
      textColor = AppColors.successDark;
      fontWeight = FontWeight.w500;
    } else if (isActive) {
      textColor = AppColors.primaryDarkActive;
      fontWeight = FontWeight.w600;
    } else {
      textColor = AppColors.neutralDarker;
      fontWeight = FontWeight.w500;
    }

    return Expanded(
      child: Text(
        label,
        textAlign: alignment,
        style: AppTextStyles.medium14.copyWith(
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
