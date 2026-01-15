import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class AvailableOrderInfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const AvailableOrderInfoChip({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.neutralNormal, width: 0.5.w),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: AppSizes.iconSize16.r,
            color: AppColors.neutralDarkActive,
          ),
          SizedBox(width: AppSizes.spacing8.w),
          Text(
            text,
            style: AppTextStyles.medium12.copyWith(color: AppColors.neutralDarkActive),
          ),
        ],
      ),
    );
  }
}
