import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class CheckOutTextField extends StatelessWidget {
  const CheckOutTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyType = TextInputType.text,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyType,
      controller: controller,
      cursorColor: AppColors.primaryDarker,
      style: AppTextStyles.medium14.copyWith(color: AppColors.primaryDarker),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        hint: Text(
          hintText,
          style: AppTextStyles.medium14.copyWith(
            color: AppColors.neutralDarkActive,
          ),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.primaryDarker, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(
            color: AppColors.neutralLightActive,
            width: 1.w,
          ),
        ),
      ),
    );
  }
}
