import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class DeliveryInstructionsCard extends StatelessWidget {
  final String? instructions;

  const DeliveryInstructionsCard({super.key, this.instructions});

  @override
  Widget build(BuildContext context) {
    if (instructions == null || instructions!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacing16.w,
        vertical: AppSizes.spacing12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.warningLightHover,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
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
                size: AppSizes.iconSize32.r,
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
          SizedBox(height: AppSizes.spacing4.h),

          Padding(
            padding: EdgeInsets.only(
              left: AppSizes.spacing32.w + AppSizes.spacing16.w,
            ),
            child: Text(instructions!, style: AppTextStyles.reqular14),
          ),
        ],
      ),
    );
  }
}
