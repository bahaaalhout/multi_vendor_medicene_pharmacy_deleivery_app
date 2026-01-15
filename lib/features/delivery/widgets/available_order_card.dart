import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/delivery_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/delivery/widgets/address_tile.dart';
import 'available_order_info_chip.dart';

class AvailableOrderCard extends StatelessWidget {
  final DeliveryModel deliveryModel;
  final VoidCallback onAccept;

  const AvailableOrderCard({
    super.key,
    required this.deliveryModel,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final pharmacy = deliveryModel.order.items.first.pharmacyOffer.pharmacy;
    final fromAddress = pharmacy.address;
    final toAddress = deliveryModel.order.deliveryAddress;

    return Container(
      padding: EdgeInsets.all(AppSizes.spacing12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
        border: Border.all(color: AppColors.primaryLightActive),
      ),
      child: Column(
        children: [
          // Order Header
          Container(
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
                      FormattingUtils.formatOrderId(deliveryModel.order.id),
                      style: AppTextStyles.reqular16.copyWith(color: AppColors.primaryNormal),
                    ),
                  ],
                ),
                Text(
                  "Copy",
                  style: AppTextStyles.reqular12.copyWith(color: AppColors.neutralNormalActive),
                ),
              ],
            ),
          ),

          SizedBox(height: AppSizes.spacing12.h),

          // Pharmacy Section
          Row(
            children: [
              Container(
                width: AppSizes.spacing56.w,
                height: AppSizes.spacing56.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
                ),
                child: Icon(
                  Icons.local_pharmacy,
                  color: AppColors.primaryNormal,
                  size: AppSizes.iconSize24.sp,
                ),
              ),
              SizedBox(width: AppSizes.spacing12.w),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pharmacy.name,
                      style: AppTextStyles.bold16.copyWith(color: AppColors.primaryDark),
                    ),
                    Container(
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
                            "${pharmacy.rating}",
                            style: AppTextStyles.semiBold14.copyWith(color: AppColors.neutralDarker),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.spacing12.h),

          // Address Sections
          AddressTile(
            label: "From",
            street: fromAddress.street,
            areaCity: '${fromAddress.area}, ${fromAddress.city}',
          ),
          SizedBox(height: AppSizes.spacing8.h),
          AddressTile(
            label: "To",
            street: toAddress.street,
            areaCity: '${toAddress.area}, ${toAddress.city}',
          ),

          SizedBox(height: AppSizes.spacing12.h),

          // Bottom Info
          Container(
            padding: EdgeInsets.only(bottom: AppSizes.spacing16.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black.withAlphaPercent(0.1), width: 1.w),
              ),
            ),
            child: Row(
              children: [
                AvailableOrderInfoChip(
                  icon: Icons.access_time,
                  text: "${deliveryModel.timeMinutes} minutes",
                ),
                SizedBox(width: AppSizes.spacing8.w),
                AvailableOrderInfoChip(
                  icon: Icons.location_on_outlined,
                  text: "${deliveryModel.distanceKm} km",
                ),
                const Spacer(),
                Text(
                  "\$${deliveryModel.price}",
                  style: AppTextStyles.bold24.copyWith(color: AppColors.successDarkHover),
                ),
              ],
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
                padding: EdgeInsets.all(AppSizes.spacing16.r,),
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
}
