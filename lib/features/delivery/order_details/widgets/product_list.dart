import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/cart_item_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';
import 'product_item.dart';

class ProductListWidget extends StatelessWidget {
  final List<CartItemModel> items;
  final bool showDetails;
  final VoidCallback? onShowDetails;
  final bool showVerified;

  const ProductListWidget({
    super.key,
    required this.items,
    this.showDetails = false,
    this.onShowDetails,
    this.showVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    final totalQuantity = items.fold(0, (sum, item) => sum + item.quantity);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing12.w, vertical: AppSizes.spacing8.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius4.r),
      ),
      child: Column(
        children: [
          // Header row
          Container(
            padding: EdgeInsets.all(AppSizes.spacing8.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius4.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Products (${FormattingUtils.formatItemCount(items.length)})',
                    style: AppTextStyles.medium12.copyWith(
                      color: AppColors.neutralDarker,
                    ),
                  ),
                ),
                Text(
                  'Quantity',
                  style: AppTextStyles.medium12.copyWith(
                    color: AppColors.neutralDarker,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSizes.spacing8.h),

          // Product content
          if (showDetails)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing8.w),
              child: Column(
                children: items.map((item) => ProductItem(item: item)).toList(),
              ),
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing8.w),
              child: Row(
                children: [
                  // Overlapping medicine images - with bounded constraints
                  SizedBox(
                    width: (items.length.clamp(0, 4) * AppSizes.iconSize24 + AppSizes.spacing16).w,
                    height: AppSizes.spacing40.h,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: List.generate(
                        items.length.clamp(0, 4),
                        (index) => Positioned(
                          left: (index * AppSizes.iconSize24).w,
                          child: Transform.rotate(
                            angle: 0.14,
                            child: Container(
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
                                items[index].pharmacyOffer.medicine.imageUrls.first,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(
                                  Icons.medication,
                                  color: AppColors.primaryNormal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSizes.spacing12.w),
                  
                  if (onShowDetails != null)
                    Expanded(
                      child: GestureDetector(
                        onTap: onShowDetails,
                        child: Text(
                          'Show details',
                          style: AppTextStyles.medium12.copyWith(
                            color: AppColors.primaryNormal,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  
                  Text(
                    '×$totalQuantity',
                    style: AppTextStyles.semiBold12.copyWith(
                      color: AppColors.neutralDarker,
                    ),
                  ),
                ],
              ),
            ),

          if (showVerified) ...[
            SizedBox(height: AppSizes.spacing8.h),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.spacing12.w,
                vertical: AppSizes.spacing8.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.successLightActive,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified_user,
                    size: AppSizes.iconSize14.sp,
                    color: AppColors.successDarkActive,
                  ),
                  SizedBox(width: AppSizes.spacing4.w),
                  Text(
                    'Medication quantities verified.',
                    style: AppTextStyles.semiBold12.copyWith(
                      color: AppColors.successDarker,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
