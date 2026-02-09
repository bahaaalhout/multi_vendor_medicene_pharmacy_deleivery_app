import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';

class ProfileInfoCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String email;
  final String location;
  final String phone;
  final String status;
  final String carType;

  const ProfileInfoCard({
    super.key,
    this.imageUrl,
    required this.name,
    required this.email,
    required this.location,
    required this.phone,
    required this.status,
    required this.carType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile Image
        SizedBox(
          width: AppSizes.iconSize120.r,
          height: AppSizes.iconSize120.r,
          child: ClipRRect(
            child: Image.network(
              imageUrl ?? "",
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Image.asset('assets/icons/person.png'),
            ),
          ),
        ),

        SizedBox(height: AppSizes.spacing24.h),

        // Status and Car Info
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Online Status
            Container(
              padding: EdgeInsets.all(AppSizes.spacing12.r),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(AppSizes.spacing2.r),
                    width: AppSizes.iconSize8.r,
                    height: AppSizes.iconSize8.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.successDarker,
                    ),
                  ),

                  SizedBox(width: AppSizes.spacing4.w),

                  Text(
                    status,
                    style: AppTextStyles.medium12.copyWith(
                      color: AppColors.successDarker,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: AppSizes.spacing8.w),

            // Car Info
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.spacing12.w,
                vertical: AppSizes.spacing8.h,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryNormal, width: 1.w),
                borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/car.svg',
                    width: AppSizes.iconSize20.r,
                    height: AppSizes.iconSize20.r,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryNormal,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: AppSizes.spacing8.w),
                  Text(
                    carType,
                    style: AppTextStyles.semiBold14.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: AppSizes.spacing24.h),

        // Profile Details
        Column(
          children: [
            Text(
              name,
              style: AppTextStyles.bold20.copyWith(
                color: AppColors.primaryDarkActive,
              ),
            ),

            SizedBox(height: AppSizes.spacing4.h),

            Text(
              email,
              style: AppTextStyles.medium14.copyWith(
                color: Colors.black.withAlphaPercent(0.8),
              ),
            ),

            SizedBox(height: AppSizes.spacing4.h),

            Text(
              '$location, $phone',
              style: AppTextStyles.medium12.copyWith(
                color: AppColors.neutralDark,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
