import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/home/widgets/title_of_headers.dart';

class PharmacyOffers extends StatelessWidget {
  const PharmacyOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleOfHeaders(title: 'Pharmacy Offers', navigateToPage: () {}),
        SizedBox(height: 24.h),
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: AppColors.errorLight,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.translate(
                offset: Offset(0, -30.h),
                child: Image.asset(
                  'assets/images/kit.png',
                  width: 100.r,
                  height: 100.r,
                ),
              ),
              SizedBox(width: 24.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '20% Discount',
                    style: AppTextStyles.bold20.copyWith(
                      color: AppColors.errorNormal,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  Text(
                    'First Aid',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontFamily: 'montserrat',
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Everything you need to act\n fast in emergencies',
                    style: AppTextStyles.medium12.copyWith(
                      color: AppColors.neutralDarkHover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
