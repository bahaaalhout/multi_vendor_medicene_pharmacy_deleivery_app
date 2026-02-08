import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;

  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
      ),
      child: CustomPaint(
        child: Column(
          children: [
            // Avatar
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightBlue,
              ),
              child: Image.asset(
                "assets/icons/person.png",
                width: 120.w,
                height: 120.h,
              ),
            ),
            16.verticalSpace,
            // Name
            Text(
              name,
              style: AppTextStyles.bold20.copyWith(
                color: AppColors.textDark,
              ),
            ),
            8.verticalSpace,
            // Email
            Text(
              email,
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


