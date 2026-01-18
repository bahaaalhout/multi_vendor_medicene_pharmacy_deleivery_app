import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class DeliveryInfoBadge extends StatelessWidget {
  final String? paymentMethod;
  final double? price;

  const DeliveryInfoBadge({super.key, this.paymentMethod, this.price});

  @override
  Widget build(BuildContext context) {
    if (price == 0) {
      return _buildFreeDeliveryBadge();
    } else if (price != null && price! > 0) {
      return _buildPaidDeliveryBadge();
    } else if (paymentMethod != null) {
      return _buildPaymentMethodBadge();
    }
    return const SizedBox.shrink();
  }

  Widget _buildFreeDeliveryBadge() {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing12.r),
      decoration: BoxDecoration(
        color: AppColors.successLightHover,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
      ),
      child: Text(
        'Free Delivery',
        style: AppTextStyles.semiBold12.copyWith(
          color: AppColors.successDarker,
        ),
      ),
    );
  }

  Widget _buildPaidDeliveryBadge() {
    return Text(
      "\$$price",
      style: AppTextStyles.bold24.copyWith(color: AppColors.successDarkHover),
    );
  }

  Widget _buildPaymentMethodBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacing12.w,
        vertical: AppSizes.spacing8.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutralLightActive,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
      ),
      child: paymentMethod!.toLowerCase().contains('visa')
          ? Image.asset(
              'assets/images/visa_logo.png',
              height: AppSizes.spacing24.h,
              errorBuilder: (_, __, ___) =>
                  Text(paymentMethod!, style: AppTextStyles.medium12),
            )
          : Text(paymentMethod!, style: AppTextStyles.medium12),
    );
  }
}
