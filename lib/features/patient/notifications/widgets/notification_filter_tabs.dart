import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/models/notification_item.dart';

class NotificationFilterTabs extends StatelessWidget {
  final NotificationCategory selected;
  final ValueChanged<NotificationCategory> onChanged;

  const NotificationFilterTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 4.w),
            _buildTab(label: 'All', category: NotificationCategory.all),
            SizedBox(width: 8.w),
            _buildTab(label: 'Offers', category: NotificationCategory.offer),
            SizedBox(width: 8.w),
            _buildTab(
              label: 'Medicine Reminders',
              category: NotificationCategory.medicineReminder,
            ),
            SizedBox(width: 8.w),
            _buildTab(label: 'Rating', category: NotificationCategory.rating),
            SizedBox(width: 4.w),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required NotificationCategory category,
  }) {
    final bool isSelected = category == selected;

    Color backgroundColor;
    Color textColor;
    FontWeight fontWeight;

    if (!isSelected) {
      backgroundColor = AppColors.primaryLight;
      textColor = AppColors.primaryDarker;
      fontWeight = FontWeight.w500;
    } else {
      if (category == NotificationCategory.all) {
        backgroundColor = AppColors.primaryDark;
        textColor = AppColors.primaryLightHover;
      } else {
        backgroundColor = AppColors.primaryNormal;
        textColor = AppColors.primaryLightHover;
      }
      fontWeight = FontWeight.w700;
    }

    return GestureDetector(
      onTap: () => onChanged(category),
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          label,
          style: AppTextStyles.medium12.copyWith(
            color: textColor,
            fontWeight: fontWeight,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
