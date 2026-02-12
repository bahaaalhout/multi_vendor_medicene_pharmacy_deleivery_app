import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class OrderDetailsNotes extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsNotes({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.spacing8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notes Title
          Text(
            'Note:',
            style: AppTextStyles.semiBold14.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
          SizedBox(height: AppSizes.spacing8.h),

          // Notes Content
          Row(
            children: [
              SizedBox(width: AppSizes.spacing8.w),

              Text(
                order.deliveryInstructions ?? 'No special instructions',
                style: AppTextStyles.medium12.copyWith(
                  color: AppColors.neutralDarkActive,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
