import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class OrdersEmptyState extends StatelessWidget {
  final VoidCallback onOrderNow;

  const OrdersEmptyState({super.key, required this.onOrderNow});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 74.w,
              height: 74.w,
              alignment: Alignment.center,
              child: Icon(Icons.block, size: 62.sp, color: AppColors.primaryNormal),
            ),
            SizedBox(height: 20.h),
            Text(
              'No Order Found ,\n Start Your First Order Now!',
              textAlign: TextAlign.center,
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.neutralDarker,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: 170.w,
              height: 44.h,
              child: ElevatedButton(
                onPressed: onOrderNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNormal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Order Now',
                  style: AppTextStyles.semiBold14.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}