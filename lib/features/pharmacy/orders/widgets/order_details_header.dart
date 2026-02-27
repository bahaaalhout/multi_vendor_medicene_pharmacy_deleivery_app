import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class OrderDetailsHeader extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsHeader({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back Button
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: AppSizes.iconSize20.r,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        
        SizedBox(width: AppSizes.spacing4.w),

        // Order Title
        Text(
          'Order #${order.id}',
          style: AppTextStyles.semiBold18.copyWith(
            color: AppColors.neutralDarker,
          ),
        ),
        
      ],
    );
  }
}
