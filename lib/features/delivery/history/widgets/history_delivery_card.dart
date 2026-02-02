import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/card_details_tile.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/card_title_row.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_info_badge.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/status_badge.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_info_chips.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/order_id_header.dart';

class HistoryDeliveryCard extends StatelessWidget {
  final DeliveryModel delivery;

  const HistoryDeliveryCard({
    super.key,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    final pharmacy = delivery.order.pharmacy;
    final fromAddress = pharmacy.address;

    return Container(
      padding: EdgeInsets.all(AppSizes.spacing12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryLightActive),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Column(
        children: [
          OrderIdHeader(orderId: delivery.order.id),
          SizedBox(height: AppSizes.spacing12.h),

          CardTitleRow(
            title: pharmacy.name,
            fallbackIcon: Icons.local_pharmacy,
            city: pharmacy.address.city,
            phone: pharmacy.phone,
            statusBadge: StatusBadge(type: BadgeType.pickedUp),
          ),
          SizedBox(height: AppSizes.spacing12.h),

          CardDetailsTile(
            label: 'From',
            value: pharmacy.address.street,
            subTitle: '${fromAddress.area}, ${fromAddress.city}',
          ),
          SizedBox(height: AppSizes.spacing8.h),
         CardTitleRow(
            imageUrl: delivery.order.customerImageUrl,
            fallbackIcon: Icons.person,
            title: delivery.order.customerName,
            city: delivery.order.deliveryAddress.city,
            phone: delivery.order.customerPhone,
            statusBadge: StatusBadge(type: BadgeType.contfirmed),
          ),
          SizedBox(height: AppSizes.spacing12.h),
          CardDetailsTile(
          label: 'To',
          value: delivery.order.deliveryAddress.street,
          subTitle:
              '${delivery.order.deliveryAddress.area}, ${delivery.order.deliveryAddress.city}',
        ),
          SizedBox(height: AppSizes.spacing12.h),

          DeliveryInfoChips(
            timeMinutes: delivery.timeMinutes,
            distanceKm: delivery.distanceKm,
            deliveryInfoBadge: DeliveryInfoBadge(
              paymentMethod: delivery.order.paymentMethod,
            )
          ),
        ],
      ),
    );
  }
}
