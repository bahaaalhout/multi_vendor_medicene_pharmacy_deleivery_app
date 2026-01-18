import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/header_widget.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      padding: EdgeInsets.only(
        top: 24.h,
        bottom: 24.h,
        right: 20.w,
        left: 20.w,
      ),
      child: Column(
        children: [
          HeaderWidget(),

          SizedBox(height: 20.h),
          SearchBar(
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            elevation: WidgetStatePropertyAll(0),
            backgroundColor: WidgetStatePropertyAll(AppColors.primaryLight),
            hintText: 'Search medicine, pharmacy..',
            hintStyle: WidgetStatePropertyAll(
              AppTextStyles.medium12.copyWith(color: AppColors.neutralDarker),
            ),
            leading: Icon(
              Icons.search,
              size: 24.r,
              color: AppColors.neutralDarker,
            ),
            trailing: [
              Icon(Icons.mic, size: 24.r, color: AppColors.primaryNormal),
            ],
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            ),
            onTap: () {},
          ),
          SizedBox(height: 20.h),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryDarker,
                  AppColors.primaryDarkHover,
                  AppColors.primaryDark,
                  AppColors.primaryNormal,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),

                  width: 100.w,
                  height: 100.h,
                  child: Image.asset(
                    'assets/images/upload.png',
                    width: 100.w,
                    height: 100.h,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Prescription',
                      style: AppTextStyles.bold17.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        'Get medicines by uploading prescriptions to pharmacist ',
                        style: AppTextStyles.medium10.copyWith(
                          color: AppColors.neutralLight,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Upload Prescription',
                            style: AppTextStyles.semiBold14.copyWith(
                              color: AppColors.primaryNormal,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryNormal,
                            size: 16.r,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
