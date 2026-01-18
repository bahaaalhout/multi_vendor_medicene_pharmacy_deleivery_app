import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart' as delivery;

class OrderIdHeader extends StatelessWidget {
  final String orderId;

  const OrderIdHeader({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.only(bottom: AppSizes.spacing8.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.neutralLightActive, width: 1.w),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Order ID: ",
                      style: AppTextStyles.reqular16.copyWith(color: AppColors.neutralNormalActive),
                    ),
                    Text(
                      FormattingUtils.formatOrderId(orderId),
                      style: AppTextStyles.reqular16.copyWith(color: AppColors.primaryNormal),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => _copyOrderId(context),
                  child: Text(
                    'Copy',
                    style: AppTextStyles.reqular12.copyWith(
                      color: AppColors.neutralNormalActive,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void _copyOrderId(BuildContext context) {
    Clipboard.setData(ClipboardData(text: delivery.order.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order ID copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}