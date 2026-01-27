import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class HistoryEmptyView extends StatelessWidget {
  const HistoryEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: AppSizes.iconSize80,
            color: AppColors.neutralLightActive,
          ),
          SizedBox(height: AppSizes.spacing16.h),
          Text(
            'No delivery history yet',
            style: AppTextStyles.semiBold16.copyWith(
              color: AppColors.neutralDark,
            ),
          ),
          SizedBox(height: AppSizes.spacing8.h),
          Text(
            'Your completed deliveries will appear here',
            style: AppTextStyles.medium12.copyWith(
              color: AppColors.neutralNormalActive,
            ),
          ),
        ],
      ),
    );
  }
}