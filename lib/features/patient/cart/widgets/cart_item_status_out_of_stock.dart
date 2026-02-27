import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/button_in_row.dart';

class CartItemStatusOutOfStock extends StatelessWidget {
  const CartItemStatusOutOfStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Opacity(
          opacity: .5,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.neutralLightHover,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            padding: EdgeInsets.all(12.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Image.asset(
                    'assets/images/pharmacy.png',
                    width: 10.w,
                    height: 14.h,
                  ),
                ),
                12.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('City Pharmacy', style: AppTextStyles.semiBold14),
                    8.verticalSpace,
                    Text(
                      'Deliver · 15 minutes  | 2.55 km',
                      style: AppTextStyles.medium10.copyWith(
                        color: AppColors.neutralDarkHover,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Chip(
                  backgroundColor: AppColors.errorLightHover,
                  label: Text(
                    'Out Of Stock',
                    style: AppTextStyles.semiBold10.copyWith(
                      color: AppColors.errorDarker,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        8.verticalSpace,
        Row(
          children: [
            ButtonInRow(title: 'Change Pharmacy', onPressed: () {}),
            8.horizontalSpace,
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.primaryNormal,
                  ),
                ),
                padding: EdgeInsets.all(12.r),
                child: Row(
                  children: [
                    Icon(
                      Icons.refresh_outlined,
                      color: AppColors.primaryNormal,
                      size: 14.sp,
                    ),
                    8.horizontalSpace,
                    Text(
                      'Refresh',
                      style: AppTextStyles.semiBold12.copyWith(
                        color: AppColors.primaryNormal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
