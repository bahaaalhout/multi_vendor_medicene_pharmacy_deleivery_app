import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
    required this.onApply,
    required this.onClear,
  });
  final void Function() onApply;
  final void Function() onClear;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            onPressed: onApply,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDarker,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'Apply filter',
              style: AppTextStyles.semiBold16.copyWith(
                color: AppColors.primaryLight,
              ),
            ),
          ),
        ),
        12.verticalSpace,
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: OutlinedButton(
            onPressed: onClear,
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 1, color: AppColors.primaryDarker),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Clear all',
              style: AppTextStyles.semiBold16.copyWith(
                color: AppColors.primaryDarker,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
