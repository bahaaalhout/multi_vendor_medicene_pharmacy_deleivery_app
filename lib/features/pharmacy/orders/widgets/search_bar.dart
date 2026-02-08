import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;

  const SearchBar({
    super.key,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.spacing48.h,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacing16.w),
      decoration: BoxDecoration(
        color: AppColors.neutralLight,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius16.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: AppSizes.spacing24.r,
            color: AppColors.neutralDark,
          ),
          SizedBox(width: AppSizes.spacing8.w),
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search orders',
                hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: AppColors.neutralDark,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          SizedBox(width: AppSizes.spacing8.w),
          Container(
            width: AppSizes.spacing32.w,
            height: AppSizes.spacing32.h,
            decoration: BoxDecoration(
              color: AppColors.neutralDark,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
            ),
            child: Icon(
              Icons.mic,
              size: AppSizes.spacing14.r,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}