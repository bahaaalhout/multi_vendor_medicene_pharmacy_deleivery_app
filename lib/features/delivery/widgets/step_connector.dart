import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';

class StepConnector extends StatelessWidget {
  final bool isCompleted;
  final bool isActive;

  const StepConnector({
    super.key,
    required this.isCompleted,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final color = (isCompleted || isActive)
        ? AppColors.secondaryNormal
        : AppColors.primaryLightActive;

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          3,
          (index) => Container(
            width: AppSizes.iconSize8.w,
            height: AppSizes.iconSize8.h,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
