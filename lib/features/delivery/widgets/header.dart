import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class Header extends StatelessWidget {
  final String driverName;
  final String driverLocation;
  final String? driverImageUrl;

  const Header({
    super.key,
    required this.driverName,
    required this.driverLocation,
    this.driverImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.spacing16.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi 👋 $driverName',
                  style: AppTextStyles.semiBold20.copyWith(
                    color: AppColors.primaryNormalActive,
                  ),
                ),
                SizedBox(height: AppSizes.spacing4.h),
                Text(
                  driverLocation,
                  style: AppTextStyles.medium14.copyWith(
                    color: AppColors.neutralDarker,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: AppSizes.spacing60.w,
            height: AppSizes.spacing60.h,
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.notifications,
                    color: AppColors.primaryNormal,
                    size: AppSizes.iconSize24.sp,
                  ),
                ),
                Positioned(
                  right: AppSizes.spacing14.w,
                  top: AppSizes.spacing14.h,
                  child: Container(
                    width: AppSizes.spacing8.w,
                    height: AppSizes.spacing8.h,
                    decoration: const BoxDecoration(
                      color: AppColors.errorNormal,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppSizes.spacing12.w),
          _driverImage(),
        ],
      ),
    );
  }

Widget _driverImage() {
    final hasImage = driverImageUrl != null;
    return CircleAvatar(
      radius: AppSizes.borderRadius30.r,
      backgroundColor: AppColors.primaryLight,
      backgroundImage: hasImage ? NetworkImage(driverImageUrl!) : null,
      child: hasImage
          ? null
          : Icon(Icons.person, size: AppSizes.iconSize28.sp, color: AppColors.primaryNormal),
    );
  }
}