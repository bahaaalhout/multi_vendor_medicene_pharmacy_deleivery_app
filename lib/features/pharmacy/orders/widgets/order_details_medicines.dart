import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class OrderDetailsMedicines extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsMedicines({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Medicines Title
          Text(
            'Medicines',
            style: AppTextStyles.semiBold14.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
          SizedBox(height: AppSizes.spacing12.h),

          // Medicines List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            separatorBuilder: (context, index) => SizedBox(
              height: AppSizes.spacing12.h,
            ),
            itemBuilder: (context, index) {
              final item = order.items[index];
              final offer = item.pharmacyOffer;
              final medicine = offer.medicine;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '  •  ${medicine.brandName}',
                    style: AppTextStyles.reqular12.copyWith(
                      color: AppColors.neutralDarker,
                    ),
                  ),
                  Text(
                    'Item: ${item.quantity}',
                    style: AppTextStyles.reqular12.copyWith(
                      color: AppColors.neutralDarker,
                    ),
                  ),
                  Text(
                    '\$${(offer.price * item.quantity).toStringAsFixed(2)}',
                    style: AppTextStyles.reqular12.copyWith(
                      color: AppColors.neutralDarker,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
