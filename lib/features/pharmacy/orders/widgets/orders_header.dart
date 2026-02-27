import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/cubit/pharmacy_orders_state.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/pharmacy/orders/widgets/status_filter_chips.dart';

class OrdersHeader extends StatelessWidget {
  final OrderStatusFilter selectedFilter;
  final ValueChanged<OrderStatusFilter> onFilterChanged;

  const OrdersHeader({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Orders',
          style: AppTextStyles.semiBold20.copyWith(
            color: AppColors.neutralDarker,
          ),
        ),
        StatusFilterDropdown(
          selectedFilter: selectedFilter,
          onFilterChanged: onFilterChanged,
        ),
      ],
    );
  }
}