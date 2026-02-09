import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';

class EarningsSummaryCard extends StatelessWidget {
  final int totalDeliveries;
  final double totalEarnings;
  final VoidCallback? onViewDetailsPressed;

  const EarningsSummaryCard({
    super.key,
    required this.totalDeliveries,
    required this.totalEarnings,
    this.onViewDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacing16.w,
        vertical: AppSizes.spacing12.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralLightActive, width: 1.w),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Weekly earnings summary',
            style: AppTextStyles.semiBold16.copyWith(
              color: AppColors.primaryDarker,
            ),
          ),

          SizedBox(height: AppSizes.spacing16.h),

          // Total Deliveries
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total deliveries', style: AppTextStyles.reqular14),
              Text(
                totalDeliveries.toString(),
                style: AppTextStyles.semiBold16.copyWith(
                  color: AppColors.primaryNormal,
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.spacing12.h),

          // Total Earnings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total earnings', style: AppTextStyles.reqular14),
              Text(
                '${totalEarnings.toStringAsFixed(2)}\$',
                style: AppTextStyles.semiBold16.copyWith(
                  color: AppColors.successDark,
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.spacing12.h),

          // View Details Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onViewDetailsPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryLight,
                foregroundColor: AppColors.secondaryDark,
                padding: EdgeInsets.symmetric(vertical: AppSizes.spacing8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
                ),
                elevation: 2,
                shadowColor: Colors.black.withAlphaPercent(0.1),
              ),
              child: Text(
                'View details',
                style: AppTextStyles.semiBold12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
