import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/profile/widgets/toggle.dart';

class NotificationCard extends StatelessWidget {
  final bool notificationsEnabled;
  final bool offersEnabled;
  final bool orderTrackingEnabled;
  final bool ratingRequestsEnabled;
  final ValueChanged<bool> onNotificationsToggle;
  final ValueChanged<bool> onOffersToggle;
  final ValueChanged<bool> onOrderTrackingToggle;
  final ValueChanged<bool> onRatingRequestsToggle;

  const NotificationCard({
    super.key,
    required this.notificationsEnabled,
    required this.offersEnabled,
    required this.orderTrackingEnabled,
    required this.ratingRequestsEnabled,
    required this.onNotificationsToggle,
    required this.onOffersToggle,
    required this.onOrderTrackingToggle,
    required this.onRatingRequestsToggle,
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
      child: Column(
        children: [
          // Header section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 16.h),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightBlue,
                  ),
                  child: Image.asset(
                    "assets/icons/ring.png",
                    width: 20.w,
                    height: 20.h,
                    color: AppColors.primaryBlue,
                  ),
                ),
                16.horizontalSpace,
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notification',
                        style: AppTextStyles.semiBold16.copyWith(
                          color: AppColors.textDark,
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        'Get access to edit your notifications',
                        style: AppTextStyles.reqular12.copyWith(
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                // Main toggle
                CustomToggle(
                  value: notificationsEnabled,
                  onToggle: onNotificationsToggle,
                ),
              ],
            ),
          ),
          // Divider
          if (notificationsEnabled) ...[
            Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
            // Sub-items
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
              child: Column(
                children: [
                  _NotificationSubItem(
                    title: 'Offers',
                    value: offersEnabled,
                    onToggle: onOffersToggle,
                  ),
                  30.verticalSpace,
                  _NotificationSubItem(
                    title: 'Order tracking',
                    value: orderTrackingEnabled,
                    onToggle: onOrderTrackingToggle,
                  ),
                  30.verticalSpace,
                  _NotificationSubItem(
                    title: 'Rating requests',
                    value: ratingRequestsEnabled,
                    onToggle: onRatingRequestsToggle,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NotificationSubItem extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onToggle;

  const _NotificationSubItem({
    required this.title,
    required this.value,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.reqular16.copyWith(
            color: AppColors.textDark,
          ),
        ),
        CustomToggle(value: value, onToggle: onToggle),
      ],
    );
  }
}


