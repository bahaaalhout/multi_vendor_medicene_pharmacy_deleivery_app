import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class DeliveryOrderDetailsHeader extends StatelessWidget {
  const DeliveryOrderDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppSizes.spacing16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: AppSizes.spacing60.w,
              height: AppSizes.spacing60.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryLightActive),
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryNormal,
                size: AppSizes.iconSize14.r,
              ),
            ),
          ),
          SizedBox(width: AppSizes.spacing16.w),
          
          Expanded(
            child: Text(
              'Delivery Details',
              style: AppTextStyles.bold25.copyWith(
                color: AppColors.primaryDarker,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          SizedBox(width: (AppSizes.spacing16 + AppSizes.spacing60).w),
        ],
      ),
    );
  }
}
