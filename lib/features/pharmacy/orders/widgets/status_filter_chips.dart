import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/cubit/pharmacy_orders_state.dart';

class StatusFilterChips extends StatelessWidget {
  final OrderStatusFilter selectedFilter;
  final ValueChanged<OrderStatusFilter> onFilterChanged;

  const StatusFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFilterChip(
          label: 'All Status',
          filter: OrderStatusFilter.all,
          isSelected: selectedFilter == OrderStatusFilter.all,
        ),
        _buildFilterChip(
          label: 'New',
          filter: OrderStatusFilter.newOrders,
          isSelected: selectedFilter == OrderStatusFilter.newOrders,
        ),
        _buildFilterChip(
          label: 'Delivered',
          filter: OrderStatusFilter.delivered,
          isSelected: selectedFilter == OrderStatusFilter.delivered,
        ),
        _buildFilterChip(
          label: 'Past',
          filter: OrderStatusFilter.past,
          isSelected: selectedFilter == OrderStatusFilter.past,
        ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required OrderStatusFilter filter,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => onFilterChanged(filter),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing8.w, vertical: AppSizes.spacing8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLightActive : Colors.white,
          border: Border.all(
            color: AppColors.neutralNormal,
          ),
          borderRadius: BorderRadius.circular(AppSizes.borderRadius12.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: isSelected ? AppColors.primaryNormalActive : AppColors.neutralDarkActive,
          ),
        ),
      ),
    );
  }
}