import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class PrimaryWideButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PrimaryWideButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 60.h,
        padding: EdgeInsets.all(12.w),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryNormal,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          text,
          style: AppTextStyles.semiBold16.copyWith(
            color: AppColors.primaryLight,
          ),
        ),
      ),
    );
  }
}
