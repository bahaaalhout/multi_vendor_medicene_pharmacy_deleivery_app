import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class PharmacyAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onNotificationTap;
  final bool showNotification;

  const PharmacyAppBar({
    super.key,
    this.title = 'CureWay',
    this.subtitle = 'Pharmacy Name',
    this.onNotificationTap,
    this.showNotification = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Leading Widget, Logo and Title Section
          Row(
            children: [
              // Logo
              Container(child: Image.asset("assets/icons/pharmacy-logo.png")),
              8.horizontalSpace,
              // Title and Subtitle
              if (title.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bold16.copyWith(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    if (subtitle != null) ...[
                      2.verticalSpace,
                      Text(
                        subtitle!,
                        style: AppTextStyles.reqular12.copyWith(
                          color: AppColors.primaryNormalHover
                        ),
                      ),
                    ],
                  ],
                ),
            ],
          ),
          // Notification bell or trailing widget
          GestureDetector(
            onTap: onNotificationTap,
            child: Container(child: Image.asset("assets/icons/bell.png")),
          ),
        ],
      ),
    );
  }
}
