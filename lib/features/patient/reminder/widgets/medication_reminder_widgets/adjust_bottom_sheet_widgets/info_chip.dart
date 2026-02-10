import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class InfoChip extends StatelessWidget {
  final String text;

  // optional customization
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;

  const InfoChip({
    super.key,
    required this.text,
    this.padding,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.secondaryLight,
        borderRadius: BorderRadius.circular((radius ?? 12).r),
        border: Border.all(color: borderColor ?? AppColors.neutralLightActive),
      ),
      child: Text(
        text,
        style:
            textStyle ??
            AppTextStyles.medium10.copyWith(color: AppColors.secondaryDarker),
      ),
    );
  }
}
