import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SelectableChip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback? onTap;

  // Optional customization (defaults match your current UI)
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;

  const SelectableChip({
    super.key,
    required this.text,
    required this.selected,
    this.onTap,
    this.padding,
    this.radius,
    this.selectedColor,
    this.unselectedColor,
    this.borderColor,
    this.textStyle,
    this.selectedTextColor,
    this.unselectedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final r = (radius ?? 10).r;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(r),
      child: Container(
        height: 40.w,
        width: 30.w,
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: selected
              ? (selectedColor ?? AppColors.primaryNormal)
              : (unselectedColor ?? Colors.white),
          borderRadius: BorderRadius.circular(r),
          border: Border.all(
            color: borderColor ?? AppColors.neutralLightActive,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: (textStyle ?? AppTextStyles.medium10).copyWith(
              color: selected
                  ? (selectedTextColor ?? Colors.white)
                  : (unselectedTextColor ?? AppColors.secondaryDarker),
            ),
          ),
        ),
      ),
    );
  }
}
