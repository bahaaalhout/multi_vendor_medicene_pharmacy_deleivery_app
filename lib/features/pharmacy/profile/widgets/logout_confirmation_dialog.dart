import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.only(top: 20.h, bottom: 20.h, left: 10.w, right: 10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Illustration (simplified - using an icon instead)
              Container(child: Image.asset('assets/icons/logout.png')),
              24.verticalSpace,
              // Question Text
              Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: AppTextStyles.medium17.copyWith(
                  color: AppColors.neutralDark1,
                ),
              ),
              32.verticalSpace,
              // Buttons
              Row(
                children: [
                  // No Button (filled blue)
                  Expanded(
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'No',
                          style: AppTextStyles.medium16.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  12.horizontalSpace,
                  // Yes Logout Button (outlined/secondary)
                  Expanded(
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.neutralLightActive,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Handle logout logic here
                          Navigator.of(context).pop();
                          // Add your logout logic here
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Yes Logout',
                          style: AppTextStyles.medium16.copyWith(
                            color: AppColors.neutralDarkActive,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
