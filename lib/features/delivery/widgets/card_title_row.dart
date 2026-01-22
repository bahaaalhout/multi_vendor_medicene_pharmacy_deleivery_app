import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class CardTitleRow extends StatelessWidget {
  final String? imageUrl;
  final IconData fallbackIcon;
  final String title;
  final String city;
  final String phone;
  final Widget? statusBadge;

  const CardTitleRow({
    super.key,
    this.imageUrl,
    required this.fallbackIcon,
    required this.title,
    required this.city,
    required this.phone,
    this.statusBadge,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSizes.spacing56.w,
          height: AppSizes.spacing56.h,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
          ),
          child: imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
                  child: Image.network(
                    imageUrl!,
                    width: AppSizes.spacing56.w,
                    height: AppSizes.spacing56.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      fallbackIcon,
                      color: AppColors.primaryNormal,
                      size: AppSizes.iconSize24.sp,
                    ),
                  ),
                )
              : Icon(
                  fallbackIcon,
                  color: AppColors.primaryNormal,
                  size: AppSizes.iconSize24.sp,
                ),
        ),
        SizedBox(width: AppSizes.spacing12.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bold16.copyWith(color: AppColors.primaryDark),
                  ),
                  SizedBox(height: AppSizes.spacing8.h),
                  Text(
                    "$city, $phone",
                    style: AppTextStyles.medium12.copyWith(color: AppColors.neutralDark),
                  ),
                ],
              ),
              if (statusBadge != null)
                statusBadge!,
            ],
          ),
        ),
      ],
    );
  }
}
