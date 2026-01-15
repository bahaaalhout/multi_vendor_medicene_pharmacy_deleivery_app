import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/order_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/pharmacy_info_row.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/address_tile.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/product_list.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_info_chips.dart';

/// Card showing pharmacy order details (pickup location, products)
class PharmacyOrderCard extends StatelessWidget {
  final OrderModel order;
  final DeliveryModel delivery;
  final Widget? statusBadge;
  final bool showProductDetails;
  final VoidCallback? onToggleProductDetails;

  const PharmacyOrderCard({
    super.key,
    required this.order,
    required this.delivery,
    this.statusBadge,
    this.showProductDetails = false,
    this.onToggleProductDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryLightActive),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Column(
        children: [
          OrderHeader(
            orderId: order.id,
            onCopy: () => _copyOrderId(),
          ),
          Divider(color: AppColors.neutralLightActive),
          SizedBox(height: AppSizes.spacing8.h),

          PharmacyInfoRow(
            pharmacyName: order.pharmacyName,
            rating: order.items[0].pharmacyOffer.pharmacy.rating, //todo: check and improve this
            statusBadge: statusBadge,
          ),
          SizedBox(height: AppSizes.spacing12.h),

          AddressTile(
            label: 'From',
            street: order.pharmacyAddress.street,
            areaCity: '${order.pharmacyAddress.area}, ${order.pharmacyAddress.city}',
          ),
          SizedBox(height: AppSizes.spacing8.h),

          ProductListWidget(
            items: order.items,
            showDetails: showProductDetails,
            onShowDetails: onToggleProductDetails,
            showVerified: delivery.status == DeliveryStatus.pickedUp ||
                          delivery.status == DeliveryStatus.enRoute,
          ),
          SizedBox(height: AppSizes.spacing12.h),

          DeliveryInfoChips(
            timeMinutes: delivery.timeMinutes,
            distanceKm: delivery.distanceKm,
            showFreeDelivery: true,
          ),
        ],
      ),
    );
  }

  void _copyOrderId() {
    // TODO: Implement copy to clipboard
    debugPrint('Copy order ID: $order.id');
  }
}
