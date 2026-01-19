import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class ReviewAlert extends StatelessWidget {
  const ReviewAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing12.w),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
        border: Border(
          left: BorderSide(
            color: AppColors.errorNormal,
            width: AppSizes.spacing3.w,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.error,
                color: AppColors.errorNormal,
                size: AppSizes.iconSize24.sp,
              ),
              SizedBox(width: AppSizes.spacing12.w),
              Expanded(
                child: Text(
                  'Delivery Needs Review',
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.neutralDarker,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.spacing12.w,
                  vertical: AppSizes.spacing8.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.errorLightActive,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
                ),
                child: Text(
                  'Pending',
                  style: AppTextStyles.medium12.copyWith(
                    color: AppColors.errorDarkActive,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.spacing12.h),
          GestureDetector(
            onTap: () {
              debugPrint('Review Details tapped');
            },
            child: Container(
              padding: EdgeInsets.all(AppSizes.spacing12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Review Details',
                    style: AppTextStyles.medium16.copyWith(
                      color: AppColors.neutralDarkActive,
                    ),
                  ),
                  SizedBox(width: AppSizes.spacing8.w),
                  Icon(
                    Icons.arrow_forward,
                    size: AppSizes.iconSize16.sp,
                    color: AppColors.neutralDarkActive,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
