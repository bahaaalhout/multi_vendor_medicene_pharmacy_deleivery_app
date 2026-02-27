import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class OrderDetailsSummary extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsSummary({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.spacing8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Summary Title
          Text(
            'Order Summary',
            style: AppTextStyles.semiBold14.copyWith(
              color: AppColors.neutralDarkActive,
            ),
          ),
          SizedBox(height: AppSizes.spacing8.h),

          // Driver and Customer Info
          RichText(
            text: TextSpan(
              style: AppTextStyles.medium12,
              children: [
                TextSpan(
                  text: 'Driver : ',
                  style: AppTextStyles.medium12.copyWith(color: AppColors.neutralDarkHover),
                ),
                TextSpan(
                  text: order.driverName ?? 'N/A',
                  style: AppTextStyles.medium12.copyWith(color: AppColors.neutralDarker),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSizes.spacing4.h),

          RichText(
            text: TextSpan(
              style: AppTextStyles.medium12,
              children: [
                TextSpan(
                  text: 'Customer : ',
                  style: AppTextStyles.medium12.copyWith(color: AppColors.neutralDarkHover),
                ),
                TextSpan(
                  text: order.customerName,
                  style: AppTextStyles.medium12.copyWith(color: AppColors.neutralDarker),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSizes.spacing4.h),


          RichText(
            text: TextSpan(
              style: AppTextStyles.medium12,
              children: [
                TextSpan(
                  text: 'Count : ',
                  style: AppTextStyles.medium12.copyWith(color: AppColors.neutralDarkHover),
                ),
                TextSpan(
                  text: '${order.totalItems} item',
                  style: AppTextStyles.medium12.copyWith(color: AppColors.neutralDarker),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
