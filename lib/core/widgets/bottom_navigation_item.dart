import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/formatting_utils.dart';

class BottomNavigationItem extends StatelessWidget {
  final String activeIcon;
  final String label;
  final int tabIndex;
  final bool isActive;
  final int lastIndex;
  final bool isSpecialItem;
  final Function(int)? onTap;

  const BottomNavigationItem({
    super.key,
    required this.activeIcon,
    required this.label,
    required this.tabIndex,
    this.isActive = false,
    this.lastIndex = -1,
    this.isSpecialItem = false,
    this.onTap ,
  });

  @override
  Widget build(BuildContext context) {

    final radius = BorderRadius.horizontal(
      left: tabIndex == 0
          ? Radius.circular(AppSizes.borderRadius16.r)
          : Radius.circular(AppSizes.borderRadius8.r),
      right: tabIndex == lastIndex
          ? Radius.circular(AppSizes.borderRadius16.r)
          : Radius.circular(AppSizes.borderRadius8.r),
    );

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: radius,
        ),
        child: InkWell(
          borderRadius: radius,
          onTap: () => onTap?.call(tabIndex),
          splashColor: AppColors.primaryNormal.withAlphaPercent(0.1),
          highlightColor: AppColors.primaryNormal.withAlphaPercent(0.05),
          child: Container(
            width: isSpecialItem ? AppSizes.spacing64.w : AppSizes.spacing56.w,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: AppSizes.spacing8.h),
            child: Column(
              children: [
                SvgPicture.asset(
                  activeIcon,
                  width: isSpecialItem
                      ? AppSizes.iconSize24.w
                      : AppSizes.iconSize18.w,
                  height: isSpecialItem
                      ? AppSizes.iconSize27.h
                      : AppSizes.iconSize18.h,
                  colorFilter: ColorFilter.mode(
                    isActive
                        ? AppColors.primaryNormal
                        : AppColors.neutralDarker,
                    BlendMode.srcIn,
                  ),
                ),

                SizedBox(height: AppSizes.spacing8.h),
                Text(
                  label,
                  style: AppTextStyles.medium10.copyWith(
                    fontWeight: isSpecialItem
                        ? FontWeight.w800
                        : FontWeight.w500,
                    color: isActive
                        ? AppColors.primaryNormal
                        : AppColors.neutralDarker,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
