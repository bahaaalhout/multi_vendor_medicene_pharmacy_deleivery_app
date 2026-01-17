import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/card_details_tile.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_info_badge.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_info_chips.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/order_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/card_title_row.dart';

class AvailableOrderCard extends StatelessWidget {
  final DeliveryModel delivery;
  final VoidCallback onAccept;

  const AvailableOrderCard({
    super.key,
    required this.delivery,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final pharmacy = delivery.order.pharmacy;
    final fromAddress = pharmacy.address;
    final toAddress = delivery.order.deliveryAddress;

    return Container(
      padding: EdgeInsets.all(AppSizes.spacing12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
        border: Border.all(color: AppColors.primaryLightActive),
      ),
      child: Column(
        children: [
          // Order Header
          OrderIdHeader(orderId: delivery.order.id),
          SizedBox(height: AppSizes.spacing12.h),

          // Pharmacy Section
          CardTitleRow(
            title: pharmacy.name,
            fallbackIcon: Icons.local_pharmacy,
            statusBadge: _ratingBadge(),
          ),

          SizedBox(height: AppSizes.spacing12.h),

          // Address Sections
          CardDetailsTile(
            label: "From",
            value: fromAddress.street,
            subTitle: '${fromAddress.area}, ${fromAddress.city}',
          ),
          SizedBox(height: AppSizes.spacing8.h),
          CardDetailsTile(
            label: "To",
            value: toAddress.street,
            subTitle: '${toAddress.area}, ${toAddress.city}',
          ),

          SizedBox(height: AppSizes.spacing12.h),

          // Bottom Info
          Container(
            padding: EdgeInsets.only(bottom: AppSizes.spacing16.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withAlphaPercent(0.1),
                  width: 1.w,
                ),
              ),
            ),
            child: DeliveryInfoChips(
              timeMinutes: delivery.timeMinutes,
              distanceKm: delivery.distanceKm,
              deliveryInfoBadge: DeliveryInfoBadge(price: delivery.price),
            ),
          ),

          SizedBox(height: AppSizes.spacing12.h),

          // Accept Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onAccept,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDarkActive,
                padding: EdgeInsets.all(AppSizes.spacing16.r),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
                ),
              ),
              child: Text(
                "Accept Order",
                style: AppTextStyles.semiBold14.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacing12.w,
        vertical: AppSizes.spacing8.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutralLightHover,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: const Color(0xFFFFCC00),
            size: AppSizes.iconSize20.sp,
          ),
          SizedBox(width: AppSizes.spacing4.w),
          Text(
            "${delivery.order.pharmacy.rating}",
            style: AppTextStyles.semiBold14.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
        ],
      ),
    );
  }

}
