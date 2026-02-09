import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;

  const RatingBadge({
    super.key,
    required this.rating,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacing12.w,
        vertical: AppSizes.spacing8.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.neutralLightHover,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: iconColor ?? const Color(0xFFFFCC00),
            size: AppSizes.iconSize20.sp,
          ),
          SizedBox(width: AppSizes.spacing4.w),
          Text(
            rating.toStringAsFixed(1),
            style: AppTextStyles.semiBold14.copyWith(
              color: textColor ?? AppColors.neutralDarker,
            ),
          ),
        ],
      ),
    );
  }
}
