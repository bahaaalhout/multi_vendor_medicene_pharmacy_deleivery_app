import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_info_badge.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/order_id_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/card_title_row.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/card_details_tile.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/product_list.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_info_chips.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/status_badge.dart';

/// Card showing pharmacy order details (pickup location, products)
class PharmacyOrderCard extends StatelessWidget {
  final DeliveryModel delivery;
  final bool showProductDetails;
  final VoidCallback? onToggleProductDetails;

  const PharmacyOrderCard({
    super.key,
    required this.delivery,
    this.showProductDetails = false,
    this.onToggleProductDetails,
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
            statusBadge: _getPharmacyStatusBadge(),
          ),
          SizedBox(height: AppSizes.spacing12.h),

          CardDetailsTile(
            label: 'From',
            value: pharmacy.address.street,
            subTitle: '${fromAddress.area}, ${fromAddress.city}',
          ),
          SizedBox(height: AppSizes.spacing8.h),

          ProductListWidget(
            items: delivery.order.items,
            showDetails: showProductDetails,
            onShowDetails: onToggleProductDetails,
            showVerified:
                delivery.status.index >= DeliveryStatus.pickedUp.index,
          ),
          SizedBox(height: AppSizes.spacing12.h),

          DeliveryInfoChips(
            timeMinutes: delivery.timeMinutes,
            distanceKm: delivery.distanceKm,
            deliveryInfoBadge: DeliveryInfoBadge(price: delivery.price),
          ),
        ],
      ),
    );
  }

  Widget? _getPharmacyStatusBadge() {
    switch (delivery.status) {
      case DeliveryStatus.available:
        return null;
      case DeliveryStatus.accepted:
        return const StatusBadge(type: BadgeType.pickingUp);
      default:
        return const StatusBadge(type: BadgeType.pickedUp);
    }
  }
}
