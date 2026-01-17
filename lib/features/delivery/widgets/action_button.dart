import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';

class ActionButton extends StatelessWidget {
  final String buttonText;
  final String noticeText;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.buttonText,
    required this.noticeText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:  AppSizes.spacing16.w, vertical: AppSizes.spacing12.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralNormal),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
      ),
      child: Column(
        children: [
          Text(
            noticeText,
            style: AppTextStyles.reqular12.copyWith(
              color: AppColors.neutralDarkHover,
            ),
          ),
          SizedBox(height: AppSizes.spacing16.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDarkActive,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppSizes.spacing18.h),
                child: Text(
                  buttonText,
                  style: AppTextStyles.semiBold16.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}