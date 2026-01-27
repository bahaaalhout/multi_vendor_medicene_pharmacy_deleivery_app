import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/widgets/toggle.dart';

class SettingsItem extends StatelessWidget {
  final String? icon;
  final String title;
  final String? subtitle;
  final bool hasToggle;
  final bool toggleValue;
  final Function(bool)? onToggle;
  final VoidCallback? onTap;
  final bool isSubItem;

  const SettingsItem({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.hasToggle = false,
    this.toggleValue = false,
    this.onToggle,
    this.onTap,
    this.isSubItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 20.h),
            child: Row(
              children: [
                // Icon (only if not a sub-item and icon is provided)
                if (!isSubItem && icon != null) ...[
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightBlue,
                    ),
                    child: Image.asset(
                      icon!.toString(),
                      width: 16.w,
                      height: 16.h,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  16.horizontalSpace,
                ],
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      if (subtitle != null && !isSubItem) ...[
                        8.verticalSpace,
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                // Toggle or arrow
                if (hasToggle)
                  CustomToggle(value: toggleValue, onToggle: onToggle!)
                else if (!isSubItem)
                  Image.asset(
                    "assets/icons/chevron_right.png",
                    width: 24.w,
                    height: 24.h,
                    color: AppColors.primaryBlue,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


