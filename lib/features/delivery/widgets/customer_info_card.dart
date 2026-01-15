import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/order_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/delivery_info_chips.dart';
import 'contact_info_row.dart';

class CustomerInfoCard extends StatelessWidget {
  final OrderModel order;
  final DeliveryModel delivery;
  final String? customerImageUrl;

  const CustomerInfoCard({
    super.key,
    required this.order,
    required this.delivery,
    this.customerImageUrl,
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
          _buildCustomerHeader(),
          SizedBox(height: AppSizes.spacing12.h),
          _buildContactInfo(),
          SizedBox(height: AppSizes.spacing12.h),
          _buildDeliveryInfo(),
        ],
      ),
    );
  }

  Widget _buildCustomerHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 28.r,
          backgroundColor: AppColors.neutralLight,
          backgroundImage: customerImageUrl != null
              ? NetworkImage(customerImageUrl!)
              : null,
          child: customerImageUrl == null
              ? Text(
                  FormattingUtils.getInitials(order.customerName),
                  style: AppTextStyles.bold21.copyWith(
                    color: AppColors.primaryNormal,
                  ),
                )
              : null,
        ),
        SizedBox(width: AppSizes.spacing12.w),
        
        Expanded(
          child: Text(
            order.customerName,
            style: AppTextStyles.bold16.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
        ),

        if (delivery.status == DeliveryStatus.enRoute)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.spacing12.w,
              vertical: AppSizes.spacing8.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.warningLightActive,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
            ),
            child: Text(
              'On way',
              style: AppTextStyles.semiBold12.copyWith(
                color: AppColors.warningDarker,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        ContactInfoRow(
          icon: Icons.location_on,
          label: 'To',
          value: order.deliveryAddress.street,
          subtitle: '${order.deliveryAddress.area}, ${order.deliveryAddress.city}',
        ),
        SizedBox(height: AppSizes.spacing8.h),
        ContactInfoRow(
          icon: Icons.email,
          label: 'Gmail',
          value: order.customerEmail,
        ),
        SizedBox(height: AppSizes.spacing8.h),
        ContactInfoRow(
          icon: Icons.phone,
          label: 'Phone',
          value: FormattingUtils.formatPhoneNumber(order.customerPhone),
        ),
      ],
    );
  }

  Widget _buildDeliveryInfo() {
    return Row(
      children: [
        Expanded(
          child: DeliveryInfoChips(
            timeMinutes: order.estimatedTimeMinutes,
            distanceKm: delivery.distanceKm,
            showFreeDelivery: false,
          ),
        ),
        SizedBox(width: AppSizes.spacing8.w),
        _buildPaymentBadge(),
      ],
    );
  }

  Widget _buildPaymentBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacing12.w,
        vertical: AppSizes.spacing8.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutralLightActive,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
      ),
      child: order.paymentMethod.toLowerCase().contains('visa')
          ? Image.asset(
              'assets/images/visa_logo.png',
              height: 24.h,
              errorBuilder: (_, __, ___) => Text(
                order.paymentMethod,
                style: AppTextStyles.medium12,
              ),
            )
          : Text(
              order.paymentMethod,
              style: AppTextStyles.medium12,
            ),
    );
  }
}
