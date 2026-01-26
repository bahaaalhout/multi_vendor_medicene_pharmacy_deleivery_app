import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/card_details_tile.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_info_badge.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_info_chips.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/card_title_row.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/order_details/widgets/status_badge.dart';

class CustomerInfoCard extends StatelessWidget {
  final DeliveryModel delivery;

  const CustomerInfoCard({
    super.key,
    required this.delivery,
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
          CardTitleRow(
            imageUrl: delivery.order.customerImageUrl,
            fallbackIcon: Icons.person,
            title: delivery.order.customerName,
            city: delivery.order.deliveryAddress.city,
            phone: delivery.order.customerPhone,
            statusBadge: _getCustomerStatusBadge(),
          ),
          SizedBox(height: AppSizes.spacing12.h),
          _buildContactInfo(),
          SizedBox(height: AppSizes.spacing12.h),
          DeliveryInfoChips(
            timeMinutes: delivery.order.estimatedTimeMinutes,
            distanceKm: delivery.distanceKm,
            deliveryInfoBadge: DeliveryInfoBadge(
              paymentMethod: delivery.order.paymentMethod,
            ),
          ),
        ],
      ),
    );
  }

  Widget? _getCustomerStatusBadge() {
    switch (delivery.status) {
      case DeliveryStatus.available:
      case DeliveryStatus.accepted:
      case DeliveryStatus.pickedUp:
        return StatusBadge(type: BadgeType.waiting);
      case DeliveryStatus.enRoute:
        return StatusBadge(type: BadgeType.onWay);
      case DeliveryStatus.delivered:
        return StatusBadge(type: BadgeType.delivered);
      case DeliveryStatus.confirmed:
        return StatusBadge(type: BadgeType.contfirmed);
    }
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        CardDetailsTile(
          label: 'To',
          value: delivery.order.deliveryAddress.street,
          subTitle:
              '${delivery.order.deliveryAddress.area}, ${delivery.order.deliveryAddress.city}',
        ),
        SizedBox(height: AppSizes.spacing8.h),
        CardDetailsTile(
          icon: Icons.email_outlined,
          label: 'Gmail',
          value: delivery.order.customerEmail,
        ),
        SizedBox(height: AppSizes.spacing8.h),
        CardDetailsTile(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: FormattingUtils.formatPhoneNumber(
            delivery.order.customerPhone,
          ),
        ),
      ],
    );
  }
}
