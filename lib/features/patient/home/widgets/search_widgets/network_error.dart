import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SearchErrorState extends StatelessWidget {
  const SearchErrorState({super.key, required this.onTryAgain});

  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const Spacer(flex: 2),

          Icon(
            Icons.wifi_off_rounded,
            size: 80.r,
            color: AppColors.primaryNormal,
          ),

          24.verticalSpace,

          Text(
            "Unable to load results",
            textAlign: TextAlign.center,
            style: AppTextStyles.bold16.copyWith(
              color: AppColors.primaryDarker,
              fontSize: 18.sp,
            ),
          ),

          8.verticalSpace,

          Text(
            "Please check your connection and try\nagain.",
            textAlign: TextAlign.center,
            style: AppTextStyles.reqular14.copyWith(
              color: AppColors.neutralDark,
              height: 1.5,
            ),
          ),

          const Spacer(flex: 3),

          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: onTryAgain,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDarker,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Try again',
                style: AppTextStyles.semiBold16.copyWith(color: Colors.white),
              ),
            ),
          ),

          32.verticalSpace,
        ],
      ),
    );
  }
}
