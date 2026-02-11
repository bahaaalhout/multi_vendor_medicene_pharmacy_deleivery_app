import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing16.w),
      decoration: BoxDecoration(
        color: AppColors.neutralLight,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header (title + badge)
          _buildOrderHeader(),
          SizedBox(height: AppSizes.spacing8.h),

          // Customer name
          Text(
            order.customerName,
            style: AppTextStyles.semiBold12.copyWith(color: AppColors.neutralDarkActive),
          ),
          SizedBox(height: AppSizes.spacing6.h),

          // Items count (small)
          Text(
            '${order.totalItems} Items',
            style: AppTextStyles.medium10.copyWith(color: AppColors.neutralDarkHover),
          ),
          SizedBox(height: AppSizes.spacing8.h),

          // Divider
          Container(
            height: 1.h,
            color: AppColors.neutralLightActive,
          ),
          SizedBox(height: AppSizes.spacing8.h),

          // Bottom row: price • date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '\$${_calculateTotalPrice().toStringAsFixed(0)}',
                    style: AppTextStyles.semiBold12.copyWith(color: AppColors.neutralDarkActive),
                  ),
                  SizedBox(width: AppSizes.spacing8.w),
                  Container(
                    width: AppSizes.spacing4.w,
                    height: AppSizes.spacing4.h,
                    decoration: BoxDecoration(
                      color: AppColors.neutralDark,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(width: AppSizes.spacing8.w),
                  Text(
                    '${order.createdAt.month}/${order.createdAt.day}/${order.createdAt.year}',
                    style: AppTextStyles.medium12.copyWith(color: AppColors.neutralDarkHover),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Order #${order.id}',
          style: AppTextStyles.bold16.copyWith(color: AppColors.primaryNormal),
        ),
        _buildStatusBadge(),
      ],
    );
  }

  Widget _buildStatusBadge() {
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
        statusText = 'Processing';
        backgroundColor = AppColors.neutralLightActive;
        textColor = AppColors.neutralDarkActive;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing8.w, vertical: AppSizes.spacing4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius24.r),
      ),
      child: Text(
        statusText,
        style: AppTextStyles.medium12.copyWith(color: textColor),
      ),
    );
  }

  double _calculateTotalPrice() {
    return order.items.fold(0.0, (sum, item) => sum + (item.pharmacyOffer.price * item.quantity));
  }
}