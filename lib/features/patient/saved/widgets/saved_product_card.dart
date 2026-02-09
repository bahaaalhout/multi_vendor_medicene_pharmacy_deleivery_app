import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/pharmacy_offer_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/product_details/widgets/convert_formtype_tostring.dart';

class SavedProductCard extends StatelessWidget {
  final PharmacyOfferModel offer;
  final VoidCallback? onAddToCart;
  final VoidCallback? onRemove;

  const SavedProductCard({
    super.key,
    required this.offer,
    this.onAddToCart,
    this.onRemove,
  });

  String get _productName => offer.medicine.brandName;
  
  String get _formType {
    final form = ConvertFormtypeTostring.convertForm(offer.medicine.form);
    final formString = (form as String?) ?? 'tablets';
    final capitalizedForm = formString.isNotEmpty
        ? '${formString[0].toUpperCase()}${formString.substring(1)}'
        : formString;
    return '${offer.medicine.quantity} $capitalizedForm';
  }
  
  String get _strength => offer.medicine.strength;
  
  String get _type => offer.medicine.type;
  
  String get _currentPrice {
    final price = offer.discountedPrice ?? offer.price;
    return FormattingUtils.formatPrice(price);
  }
  
  String? get _originalPrice {
    if (offer.discountedPrice != null && offer.discountedPrice! < offer.price) {
      return FormattingUtils.formatPrice(offer.price);
    }
    return null;
  }
  
  String get _imageUrl {
    if (offer.medicine.imageUrls.isNotEmpty) {
      return offer.medicine.imageUrls.first;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.neutralLightActive, width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  color: AppColors.neutralLight,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: _imageUrl.isNotEmpty
                      ? Image.network(
                          _imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/product-history.png',
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          'assets/images/product-history.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              16.horizontalSpace,
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            _productName,
                            style: AppTextStyles.bold16.copyWith(
                              color: AppColors.primaryDarker,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        8.horizontalSpace,
                        Image.asset('assets/images/saved.png')
                      ],
                    ),
                    12.verticalSpace,
                    // Badges
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 6.h,
                      children: [
                        _buildBadge(_type), // OTC
                        _buildBadge(_formType), // 12 Tablets
                        _buildBadge(_strength), // 400 mg
                      ],
                    ),
                    12.verticalSpace,
                    // Price
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _currentPrice,
                          style: AppTextStyles.semiBold16.copyWith(
                            color: AppColors.successDark,
                          ),
                        ),
                        if (_originalPrice != null) ...[
                          8.horizontalSpace,
                          Text(
                            _originalPrice!,
                            style: AppTextStyles.medium10.copyWith(
                              color: AppColors.neutralDark,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.verticalSpace,
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onAddToCart,
                  label: Text(
                    "Add to Cart",
                    style: AppTextStyles.semiBold10.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 14.sp,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: OutlinedButton(
                  onPressed: onRemove,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primaryLightActive),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    "Remove",
                    style: AppTextStyles.semiBold10.copyWith(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.warningLightActive,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: AppColors.warningDarkHover2,
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.semiBold10.copyWith(
          color: AppColors.warningDarker,
        ),
      ),
    );
  }
}

