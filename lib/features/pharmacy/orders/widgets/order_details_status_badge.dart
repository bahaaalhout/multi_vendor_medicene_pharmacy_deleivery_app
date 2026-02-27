import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class OrderDetailsStatusBadge extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsStatusBadge({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color backgroundColor;
    Color textColor;

    switch (order.status) {
      case OrderStatus.placed:
        statusText = 'New';
        backgroundColor = AppColors.successLightActive;
        textColor = AppColors.successNormalActive;
        break;
      case OrderStatus.delivered:
        statusText = 'Delivered';
        backgroundColor = AppColors.primaryLightActive;
        textColor = AppColors.primaryNormalActive;
        break;
      case OrderStatus.receiveConfirmed:
        statusText = 'Past';
        backgroundColor = AppColors.warningLightActive;
        textColor = AppColors.warningDarkActive;
        break;
      default:
        statusText = 'On the way';
        backgroundColor = AppColors.neutralLightActive;
        textColor = AppColors.neutralDarkActive;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing12.w, vertical: AppSizes.spacing4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius24.r),
      ),
      child: Text(
        statusText,
        style: AppTextStyles.semiBold12.copyWith(color: textColor),
      ),
    );
  }
}
