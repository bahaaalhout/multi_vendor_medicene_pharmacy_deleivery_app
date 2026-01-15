import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';

class AddressTile extends StatelessWidget {
  final String label;
  final String street;
  final String areaCity;

  const AddressTile({
    super.key,
    required this.label,
    required this.street,
    required this.areaCity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacing8.r),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius4.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(AppSizes.spacing8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primaryNormal,
                  size: AppSizes.iconSize16.w,
                ),
                SizedBox(width: AppSizes.spacing8.w),
                Text(
                  label,
                  style: AppTextStyles.semiBold14.copyWith(color: Colors.black.withAlphaPercent(0.8)),
                ),
              ],
            ),
          ),
          SizedBox(width: AppSizes.spacing12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  street,
                  style: AppTextStyles.semiBold14.copyWith(color: Colors.black.withAlphaPercent(0.8)),
                ),
                Text(
                  areaCity,
                  style: AppTextStyles.reqular12.copyWith(color: Colors.black.withAlphaPercent(0.5)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}