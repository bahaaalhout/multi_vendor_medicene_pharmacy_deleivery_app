import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class OrderDetailsPrescription extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onPrescriptionTap;

  const OrderDetailsPrescription({
    super.key,
    required this.order,
    this.onPrescriptionTap,
  });

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
          // Prescription Title
          Text(
            'Prescription',
            style: AppTextStyles.semiBold14.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
          SizedBox(height: AppSizes.spacing8.h),

          // Prescription Content
          Center(
            child: order.requirePrescription
                ? InkWell(
                    onTap: onPrescriptionTap,
                    child: Text(
                      'View Prescription Image',
                      style: AppTextStyles.medium12.copyWith(
                        color: AppColors.primaryNormal,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                : Text(
                    'No Prescription required',
                    style: AppTextStyles.medium12.copyWith(
                      color: AppColors.neutralDarkHover,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
