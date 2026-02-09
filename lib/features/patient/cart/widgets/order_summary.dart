import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralNormal),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        spacing: 24.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order summary', style: AppTextStyles.bold20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• ',
                style: AppTextStyles.medium14.copyWith(
                  color: AppColors.neutralDark,
                ),
              ),
              Expanded(
                child: Text(
                  'This price isn\'t final. Shipping and VAT will be added in the next step.',
                  style: AppTextStyles.medium14.copyWith(
                    color: AppColors.neutralDark,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
            ),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Subtotal  ',
                        style: AppTextStyles.semiBold18.copyWith(
                          color: AppColors.neutralDarker,
                        ),
                      ),
                      TextSpan(
                        text: "(2 items)",
                        style: AppTextStyles.reqular18.copyWith(
                          color: AppColors.neutralDarker,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '56.00',
                        style: AppTextStyles.bold24.copyWith(
                          color: AppColors.primaryNormal,
                        ),
                      ),
                      TextSpan(
                        text: "\$",
                        style: AppTextStyles.semiBold18.copyWith(
                          color: AppColors.primaryNormal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
