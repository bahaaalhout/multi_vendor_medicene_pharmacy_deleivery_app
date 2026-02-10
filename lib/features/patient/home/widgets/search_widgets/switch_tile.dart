import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SwitchTile extends StatelessWidget {
  const SwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutralLightActive),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.medium16.copyWith(
                    color: AppColors.neutralDarkActive,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.medium16.copyWith(
                    color: AppColors.primaryNormal,
                  ),
                ),
              ],
            ),
          ),
          12.horizontalSpace,
          Switch(
            value: value,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.successDark,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColors.neutralLightActive,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
