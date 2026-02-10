import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class ProductShowcaseCard extends StatelessWidget {
  const ProductShowcaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            alignment: Alignment.center,
            height: 32.h,
            width: 43.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLightHover,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '+2',
              style: AppTextStyles.bold14.copyWith(
                color: AppColors.primaryNormal,
              ),
            ),
          ),
        ),
        Positioned(
          left: 5,
          child: Transform.rotate(
            angle: math.pi / 10,
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image.asset(
                'assets/images/panadol.png',
                height: 40.h,
                width: 40.h,
              ),
            ),
          ),
        ),

        Positioned(
          right: 55,
          child: Transform.rotate(
            angle: math.pi / 10,
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image.asset(
                'assets/images/panadol.png',

                height: 40,
                width: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
