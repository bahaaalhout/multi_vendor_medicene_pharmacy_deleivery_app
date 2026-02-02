import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing10.r),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryDark, width: 1.w),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
      ),
      child: Center(
        child: Text(
          'Logout',
          style: AppTextStyles.semiBold16.copyWith(
            color: AppColors.secondaryDark,
          ),
        ),
      ),
    );
  }
}
