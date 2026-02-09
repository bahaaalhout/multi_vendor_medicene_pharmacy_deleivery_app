import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  children: [
                    NavigateBackButton(),
                    20.horizontalSpace,
                    Text(
                      'Privacy Policy',
                      style: AppTextStyles.bold25.copyWith(
                        fontSize: 24.sp,
                        height: 1.5,
                        color: AppColors.secondaryDarker1,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: 580.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: AppColors.primaryLightActive,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(20.w),
                  child: Text(
                    'Your privacy is important to us.\nWe collect and use your information only to provide and improve our services.\nYour prescription data is encrypted and never shared with unauthorized parties.',
                    style: AppTextStyles.semiBold16.copyWith(
                      color: AppColors.secondaryDarker1,
                    ),
                  ),
                ),
              ),

              10.verticalSpace,

              Padding(
                padding: EdgeInsets.only(bottom: 20.h, left: 40.w, right: 40.w),
                child: Text(
                  'By using this application, you agree to our privacy policy',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.semiBold16.copyWith(
                    color: AppColors.secondaryDarker1,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
