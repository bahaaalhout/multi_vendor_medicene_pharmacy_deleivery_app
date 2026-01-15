import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class DeliveryInstructionsCard extends StatelessWidget {
  final String? instructions;

  const DeliveryInstructionsCard({
    super.key,
    this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    if (instructions == null || instructions!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(AppSizes.spacing16.w),
      decoration: BoxDecoration(
        color: AppColors.warningLightHover,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 2.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 32.sp,
                color: AppColors.neutralDarker,
              ),
              SizedBox(width: AppSizes.spacing12.w),
              Text(
                'Delivery Instructions',
                style: AppTextStyles.bold16.copyWith(
                  color: AppColors.primaryDarkActive,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.spacing8.h),
          
          Center(
            child: Text(
              instructions!,
              style: AppTextStyles.reqular14,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}