import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class RemovableChip extends StatelessWidget {
  final String text;
  final VoidCallback onRemove;

  final EdgeInsetsGeometry? padding;
  final double? radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final double? iconSize;

  const RemovableChip({
    super.key,
    required this.text,
    required this.onRemove,
    this.padding,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final r = (radius ?? 12).r;

    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(r),
        border: Border.all(color: borderColor ?? AppColors.neutralLightActive),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: AppTextStyles.medium10.copyWith(
              color: textColor ?? AppColors.secondaryDarker,
            ),
          ),
          SizedBox(width: 6.w),
          InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(999),
            child: Icon(
              Icons.close,
              size: (iconSize ?? 14).w,
              color: iconColor ?? AppColors.neutralDark,
            ),
          ),
        ],
      ),
    );
  }
}
