import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/utils/date_time_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/notifications/models/notification_item.dart';

class RatingNotificationCard extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback onRateNow;
  final VoidCallback onClose;

  const RatingNotificationCard({
    super.key,
    required this.item,
    required this.onRateNow,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final timeText = timeAgo(item.createdAt);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE9EDF3)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(0, 4.h), // Y: 4
            blurRadius: 4.r, // Blur: 4
            spreadRadius: 0, // Spread: 0
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.star_border_rounded,
              size: 22.sp,
              color: AppColors.primaryNormal,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            timeText,
            style: AppTextStyles.reqular16.copyWith(
              color: AppColors.neutralDark,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBold16.copyWith(
              color: AppColors.primaryDarker,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.reqular12.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              onPressed: onRateNow,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryNormal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Rate Now',
                style: AppTextStyles.semiBold14.copyWith(
                  color: AppColors.primaryLight,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: OutlinedButton(
              onPressed: onClose,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primaryNormal),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Close',
                style: AppTextStyles.semiBold12.copyWith(
                  color: AppColors.primaryNormal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
