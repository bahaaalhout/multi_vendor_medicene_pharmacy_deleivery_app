import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class PharmacyInfoRow extends StatelessWidget {
  final String pharmacyName;
  final double? rating;
  final Widget? statusBadge;

  const PharmacyInfoRow({
    super.key,
    required this.pharmacyName,
    this.rating,
    this.statusBadge,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
          ),
          child: Icon(
            Icons.local_pharmacy,
            color: AppColors.primaryNormal,
            size: 28.sp,
          ),
        ),
        SizedBox(width: AppSizes.spacing12.w),
        
        Expanded(
          child: Text(
            pharmacyName,
            style: AppTextStyles.bold16.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
        ),
        
        if (rating != null)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.spacing12.w,
              vertical: AppSizes.spacing8.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.neutralLightHover,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  size: 20.sp,
                  color: const Color(0xFFFFCC00),
                ),
                SizedBox(width: AppSizes.spacing4.w),
                Text(
                  rating!.toStringAsFixed(1),
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.neutralDarker,
                  ),
                ),
              ],
            ),
          ),
        
        if (statusBadge != null)
          statusBadge!,
      ],
    );
  }
}