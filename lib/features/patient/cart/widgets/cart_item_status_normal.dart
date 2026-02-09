import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/avalaible_cart_item_status.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/cart/widgets/required_prescription_cart_item_status.dart';

class CartItemStatusNormal extends StatelessWidget {
  const CartItemStatusNormal({super.key, this.isPrescriptionRequired = false});
  final bool isPrescriptionRequired;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 1,
      child: Column(
        children: [
          AvailableCartItemStatus(),
          Container(
            decoration: BoxDecoration(),
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 8.h,
              bottom: 12.h,
            ),
            child: Column(
              children: [
                isPrescriptionRequired
                    ? RequiredPrescriptionCartItemStatus()
                    : Container(),

                12.verticalSpace,
                Divider(color: AppColors.neutralLightActive),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 14.h,
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.neutralLightActive,
                            width: 1.w,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.delete_rounded, size: 16.sp),
                          title: Text('Remove', style: AppTextStyles.medium14),
                        ),
                      ),
                    ),
                    24.horizontalSpace,
                    Text('28.00\$', style: AppTextStyles.bold16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
