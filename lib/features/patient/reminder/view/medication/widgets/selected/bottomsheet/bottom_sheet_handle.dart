import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

/// Small drag handle shown on top of bottom sheets
class BottomSheetHandle extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final Color? color;

  const BottomSheetHandle({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width ?? 44.w,
        height: height ?? 4.h,
        margin: margin ?? EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: color ?? AppColors.neutralLightActive,
          borderRadius: BorderRadius.circular(999.r),
        ),
      ),
    );
  }
}
