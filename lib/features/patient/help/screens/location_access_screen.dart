import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  children: [
                    NavigateBackButton(),
                    20.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Help Center',
                            style: AppTextStyles.bold25.copyWith(
                              fontSize: 24.sp,
                              color: AppColors.secondaryDarker1,
                            ),
                          ),
                          Text(
                            'Get help, FAQs, and contact support',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.reqular14.copyWith(
                              color: AppColors.secondaryDarker1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40.w),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Text(
                  'Enable Location Access',
                  style: AppTextStyles.bold17.copyWith(
                    color: AppColors.secondaryDarker1,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: AppColors.primaryLightActive,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(24.w),
                  constraints: BoxConstraints(minHeight: 230.h),
                  child: Text(
                    'We use your location to show nearby pharmacies and calculate delivery accurately.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.reqular14.copyWith(
                      color: AppColors.secondaryDarker1,
                    ),
                  ),
                ),
              ),

              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryNormal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Allow Location',
                          style: AppTextStyles.reqular16.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE8EAF6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Not Now',
                          style: AppTextStyles.reqular16.copyWith(
                            color: AppColors.secondaryDarker1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
