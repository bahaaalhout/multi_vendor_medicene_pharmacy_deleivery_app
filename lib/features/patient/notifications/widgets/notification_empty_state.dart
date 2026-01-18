import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/icons/notification_empty_icon.svg'),
          SizedBox(height: 16.h),
          Text(
            'No notifications yet',
            style: AppTextStyles.bold16.copyWith(
              color: AppColors.primaryDarker,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'When you receive notifications, they will appear here immediately',
            textAlign: TextAlign.center,
            style: AppTextStyles.reqular14.copyWith(
              color: const Color.fromRGBO(152, 149, 147, 1),
            ),
          ),
        ],
      ),
    );
  }
}
