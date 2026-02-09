import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,

    this.isWhite = false,

    this.isDisabled = false,
  });
  final String title;
  final Function() onPressed;

  final bool isWhite;

  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isDisabled
              ? AppColors.neutralLightActive
              : isWhite
              ? Colors.white
              : AppColors.primaryNormal,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isDisabled
                  ? AppColors.neutralLightActive
                  : AppColors.primaryNormal,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: Text(
          title,
          style: AppTextStyles.semiBold16.copyWith(
            color: isDisabled
                ? AppColors.neutralDark
                : isWhite
                ? AppColors.primaryNormal
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
