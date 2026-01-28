import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/date_time_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/models/notification_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/widgets/notification_type_icon.dart';

class NotificationListItem extends StatelessWidget {
  final NotificationItem item;

  const NotificationListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final bgColor = item.isRead
        ? AppColors.neutralLightHover
        : const Color.fromRGBO(239, 243, 251, 1);

    final dotColor = item.isRead
        ? AppColors.primaryLightActive
        : const Color(0xFF4CAF50);

    final timeText = timeAgo(item.createdAt);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE9EDF3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationTypeIcon(category: item.category, isRead: item.isRead),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.semiBold14.copyWith(
                          color: AppColors.primaryDarkActive,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  item.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.medium12.copyWith(
                    color: AppColors.primaryNormal,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  timeText,
                  style: AppTextStyles.reqular12.copyWith(
                    color: AppColors.primaryLightActive,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
