import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class OrderDetailsDeliveredStatus extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsDeliveredStatus({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // Show this badge only when order is delivered and deliveredAt is not null
    if (order.status.index < OrderStatus.delivered.index || order.deliveredAt == null) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Time icon
        SvgPicture.asset(
          'assets/icons/clock.svg',
          colorFilter: ColorFilter.mode(AppColors.neutralDarkHover, BlendMode.srcIn),
          width: AppSizes.iconSize16.r,
          height: AppSizes.iconSize16.r,
        ),
        
        // Status text
        Text(
          'Delivered at : ${order.deliveredAt}',
          style: AppTextStyles.medium12.copyWith(
            color: AppColors.neutralDarkHover,
          ),
        ),
      ],
    );
  }
}