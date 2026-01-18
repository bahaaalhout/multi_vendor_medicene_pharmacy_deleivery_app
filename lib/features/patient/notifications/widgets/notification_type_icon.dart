import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/models/notification_item.dart';

class NotificationTypeIcon extends StatelessWidget {
  final NotificationCategory category;
  final bool isRead;

  const NotificationTypeIcon({
    super.key,
    required this.category,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final String iconPath = iconPathForCategory(category);

    final Color backgroundColor = isRead
        ? AppColors.primaryLight
        : const Color.fromRGBO(255, 255, 255, 1);

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        iconPath,
        width: 15.w,
        height: 15.w,
        colorFilter: ColorFilter.mode(AppColors.primaryDark, BlendMode.srcIn),
      ),
    );
  }

  String iconPathForCategory(NotificationCategory category) {
    switch (category) {
      case NotificationCategory.offer:
        return 'assets/icons/Offers_icon.svg';
      case NotificationCategory.medicineReminder:
        return 'assets/icons/reminder_icon.svg';
      case NotificationCategory.rating:
        return 'assets/icons/rate_icon.svg';
      case NotificationCategory.all:
        return 'assets/icons/reminder_icon.svg';
    }
  }
}
