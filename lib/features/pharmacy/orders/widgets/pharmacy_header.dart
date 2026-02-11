import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class PharmacyHeader extends StatelessWidget {
  final String pharmacyName;
  final VoidCallback onNotificationPressed;

  const PharmacyHeader({
    super.key,
    required this.pharmacyName,
    required this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Pharmacy Icon (logo)
        Image.asset(
          'assets/icons/pharmacy_app_logo.png',
          width: AppSizes.spacing34.w,
          height: AppSizes.spacing32.h,
          fit: BoxFit.contain,
        ),
        SizedBox(width: AppSizes.spacing8.w),
    
        // Pharmacy Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                  color: AppColors.primaryNormalHover,
                ),
              ),
            ],
          ),
        ),
    
        // Notification Icon with subtle border
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            size: AppSizes.spacing40.r,
            color: Colors.black,
          ),
          onPressed: onNotificationPressed,
        ),
      ],
    );
  }
}