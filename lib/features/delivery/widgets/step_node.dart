import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class StepNode extends StatelessWidget {
  final String number;
  final bool isActive;
  final bool isCompleted;

  const StepNode({
    super.key,
    required this.number,
    required this.isActive,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color contentColor;
    Widget content;

    if (isCompleted) {
      backgroundColor = AppColors.successNormalHover;
      contentColor = AppColors.successLight;
      content = Icon(
        Icons.check,
        color: Colors.white,
        size: 32.sp,
      );
    } else if (isActive) {
      backgroundColor = AppColors.secondaryNormal;
      contentColor = AppColors.primaryLight;
      content = Text(
        number,
        style: AppTextStyles.bold25.copyWith(
          color: contentColor,
        ),
      );
    } else {
      backgroundColor = Colors.white;
      contentColor = AppColors.primaryDarker;
      content = Text(
        number,
        style: AppTextStyles.medium25.copyWith(
          color: contentColor,
        ),
      );
    }

    return Container(
      width: 56.w,
      height: 56.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: isActive
            ? Border.all(
                color: AppColors.primaryLightActive,
                width: 2.w,
              )
            : null,
      ),
      child: Center(child: content),
    );
  }
}
