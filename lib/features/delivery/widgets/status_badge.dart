import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_sizes.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

enum BadgeType {
  pickingUp,
  pickedUp,
  onWay,
  delivered,
}

class StatusBadge extends StatelessWidget {
  final BadgeType type;
  final String? customText;

  const StatusBadge({
    super.key,
    required this.type,
    this.customText,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getBadgeConfig(type);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacing12.w,
        vertical: AppSizes.spacing8.h,
      ),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.borderRadius8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            customText ?? config.text,
            style: AppTextStyles.semiBold12.copyWith(
              color: config.textColor,
            ),
          ),
          if (config.showCheckmark) ...[
            SizedBox(width: AppSizes.spacing4.w),
            Icon(
              Icons.check,
              size: 12.sp,
              color: config.textColor,
            ),
          ],
        ],
      ),
    );
  }

  _BadgeConfig _getBadgeConfig(BadgeType type) {
    switch (type) {
      case BadgeType.pickingUp:
        return _BadgeConfig(
          text: 'Picking up',
          backgroundColor: AppColors.warningLightActive,
          textColor: AppColors.warningDarker,
          showCheckmark: false,
        );
      case BadgeType.pickedUp:
        return _BadgeConfig(
          text: 'Picked up',
          backgroundColor: AppColors.successLightHover,
          textColor: AppColors.successDarker,
          showCheckmark: true,
        );
      case BadgeType.onWay:
        return _BadgeConfig(
          text: 'On way',
          backgroundColor: AppColors.warningLightActive,
          textColor: AppColors.warningDarker,
          showCheckmark: false,
        );
      case BadgeType.delivered:
        return _BadgeConfig(
          text: 'Delivered',
          backgroundColor: AppColors.successLightHover,
          textColor: AppColors.successDarker,
          showCheckmark: true,
        );
    }
  }
}

class _BadgeConfig {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final bool showCheckmark;

  _BadgeConfig({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.showCheckmark,
  });
}