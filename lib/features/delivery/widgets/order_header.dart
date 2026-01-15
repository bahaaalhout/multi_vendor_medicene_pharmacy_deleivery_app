import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';

class OrderHeader extends StatelessWidget {
  final String orderId;
  final VoidCallback? onCopy;

  const OrderHeader({
    super.key,
    required this.orderId,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Order ID: ${FormattingUtils.formatOrderId(orderId)}',
            style: AppTextStyles.reqular16.copyWith(
              color: AppColors.neutralNormalActive,
            ),
          ),
        ),
        GestureDetector(
          onTap: onCopy,
          child: Text(
            'Copy',
            style: AppTextStyles.reqular12.copyWith(
              color: AppColors.neutralNormalActive,
            ),
          ),
        ),
      ],
    );
  }
}