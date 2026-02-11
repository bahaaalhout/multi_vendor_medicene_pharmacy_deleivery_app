import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/cubit/pharmacy_orders_state.dart';

class StatusFilterDropdown extends StatelessWidget {
  final OrderStatusFilter selectedFilter;
  final ValueChanged<OrderStatusFilter> onFilterChanged;

  const StatusFilterDropdown({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing8.w, vertical: AppSizes.spacing8.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralNormal),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
      ),
      child: DropdownButton<OrderStatusFilter>(
        value: selectedFilter,
        underline: Container(), // Remove default underline
        focusColor: Colors.transparent,
        icon: Icon(
          Icons.arrow_drop_down,
          size: AppSizes.spacing18.r,
          color: AppColors.primaryNormal,
        ),
        iconSize: AppSizes.spacing18.r,
        isDense: true,
        isExpanded: false,
        style: AppTextStyles.medium12.copyWith(color: AppColors.neutralDarkActive),
        dropdownColor: Colors.white,
        elevation: 0,
        items: [
          DropdownMenuItem(
            value: OrderStatusFilter.all,
            child: Text('All Status', style: AppTextStyles.medium12),
          ),
          DropdownMenuItem(
            value: OrderStatusFilter.newOrders,
            child: Text('New', style: AppTextStyles.medium12),
          ),
          DropdownMenuItem(
            value: OrderStatusFilter.delivered,
            child: Text('Delivered', style: AppTextStyles.medium12),
          ),
          DropdownMenuItem(
            value: OrderStatusFilter.past,
            child: Text('Past', style: AppTextStyles.medium12),
          ),
        ],
        onChanged: (OrderStatusFilter? newValue) {
          if (newValue != null) {
            onFilterChanged(newValue);
          }
        },
      ),
    );
  }
}
