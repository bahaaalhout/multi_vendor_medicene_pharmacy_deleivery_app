import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class AvailableCartItemStatus extends StatelessWidget {
  const AvailableCartItemStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutralLightHover,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      padding: EdgeInsets.all(12.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Image.asset(
              'assets/images/pharmacy.png',
              width: 10.w,
              height: 14.h,
            ),
          ),
          12.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('City Pharmacy', style: AppTextStyles.semiBold14),
              8.verticalSpace,
              Text(
                'Deliver · 15 minutes  | 2.55 km',
                style: AppTextStyles.medium10.copyWith(
                  color: AppColors.neutralDarkHover,
                ),
              ),
            ],
          ),
          Spacer(),
          Chip(
            backgroundColor: AppColors.successLightHover,
            label: Row(
              children: [
                Text(
                  'Available',
                  style: AppTextStyles.semiBold10.copyWith(
                    color: AppColors.successDarker,
                  ),
                ),
                4.horizontalSpace,
                Icon(Icons.check_circle, color: AppColors.successDarker),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
