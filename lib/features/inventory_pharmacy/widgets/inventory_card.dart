import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/inventory_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_inventory_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class InventoryCard extends StatelessWidget {
  final InventoryModel item;

  const InventoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Color statusBgColor;
    String statusText;

    switch (item.status) {
      case StockStatus.inStock:
        statusBgColor = AppColors.successLightActive;
        statusText = "In Stock";
        break;
      case StockStatus.lowStock:
        statusBgColor = AppColors.warningLightHover;
        statusText = "Low Stock";
        break;
      case StockStatus.outOfStock:
        statusBgColor = AppColors.errorLightActive;
        statusText = "Out of Stock";
        break;
    }

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.neutralLight,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.medicine?.name ?? "Unknown Medicine",
                style: AppTextStyles.semiBold16,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 7.5.h,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  statusText,
                  style: AppTextStyles.medium12.copyWith(
                    color: AppColors.neutralDarkActive,
                  ),
                ),
              ),
            ],
          ),

          Text(
            item.medicine?.manufacturer ?? "Unknown Manufacturer",
            style: AppTextStyles.reqular12.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),

          8.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.stockQuantity.toString(),
                style: AppTextStyles.reqular12.copyWith(
                  color: AppColors.neutralDarker,
                ),
              ),
              Text(
                'EX : ${item.expiryDate}',
                style: AppTextStyles.medium12.copyWith(
                  color: AppColors.neutralDarkActive,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
