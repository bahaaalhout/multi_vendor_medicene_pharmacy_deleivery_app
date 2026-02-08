import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class PharmacyHeader extends StatelessWidget {
  final String pharmacyName;

  const PharmacyHeader({
    super.key,
    required this.pharmacyName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing24.w, vertical: 0.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Row(
        children: [
          // Pharmacy Icon
          Container(
            width: 34.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
            ),
          ),
          SizedBox(width: AppSizes.spacing16.w),
          
          // Pharmacy Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pharmacyName,
                  style: AppTextStyles.bold24.copyWith(
                    color: AppColors.primaryNormal,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Pharmacy Name',
                  style: AppTextStyles.reqular12.copyWith(
                    color: AppColors.primaryDarker,
                  ),
                ),
              ],
            ),
          ),
          
          // Notification Icon
          Container(
            width: AppSizes.spacing24.w,
            height: AppSizes.spacing24.h,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
            ),
            child: Icon(
              Icons.notifications,
              size: AppSizes.spacing16.r,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}