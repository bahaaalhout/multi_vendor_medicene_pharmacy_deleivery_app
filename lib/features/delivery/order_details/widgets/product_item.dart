import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/cart_item_model.dart';

class ProductItem extends StatelessWidget {
  final CartItemModel item;

  const ProductItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.spacing4.h),
      child: Row(
        children: [
          Container(
            width: AppSizes.spacing40.w,
            height: AppSizes.spacing40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius4.r),
              border: Border.all(
                color: AppColors.neutralLightActive,
                width: 0.5.w,
              ),
            ),
            child: Image.network(
              item.pharmacyOffer.medicine.imageUrls.first,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                Icons.medication,
                color: AppColors.primaryNormal,
              ),
            ),
          ),
          SizedBox(width: AppSizes.spacing12.w),

          Expanded(
            child: Text(
              item.pharmacyOffer.medicine.brandName,
              style: AppTextStyles.reqular12.copyWith(
                color: AppColors.neutralDarkActive,
              ),
            ),
          ),

          Text(
            '×${item.quantity}',
            style: AppTextStyles.semiBold12.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
        ],
      ),
    );
  }
}
