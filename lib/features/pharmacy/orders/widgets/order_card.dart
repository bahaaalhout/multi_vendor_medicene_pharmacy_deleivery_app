import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing24.w, vertical: AppSizes.spacing8.h),
      decoration: BoxDecoration(
        color: AppColors.neutralLight,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Column(
        children: [
          // Order Header
          _buildOrderHeader(),
          SizedBox(height: AppSizes.spacing8.h),
          
          // Divider
          Container(
            height: 1.h,
            color: AppColors.neutralLightActive,
            margin: EdgeInsets.symmetric(vertical: AppSizes.spacing8.h),
          ),
          
          // Customer Info
          _buildCustomerInfo(),
          SizedBox(height: AppSizes.spacing8.h),
          
          // Order Details
          _buildOrderDetails(),
        ],
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Order # ${order.id}',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: AppColors.primaryNormal,
          ),
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
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          order.customerName,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: AppColors.neutralDarkActive,
          ),
        ),
        Text(
          order.createdAt.day.toString() +
              '/' +
              order.createdAt.month.toString() +
              '/' +
              order.createdAt.year.toString(),
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: AppColors.neutralDarkHover,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              '\$${_calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: AppColors.neutralDarkActive,
              ),
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
              '${order.totalItems} items',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
                color: AppColors.neutralDarkHover,
              ),
            ),
          ],
        ),
        Text(
          order.createdAt.day.toString() +
              '/' +
              order.createdAt.month.toString() +
              '/' +
              order.createdAt.year.toString(),
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: AppColors.neutralDarkHover,
          ),
        ),
      ],
    );
  }

  double _calculateTotalPrice() {
    return order.items.fold(0.0, (sum, item) => sum + (item.pharmacyOffer.price * item.quantity));
  }
}