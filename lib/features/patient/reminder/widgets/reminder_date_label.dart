import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

class ReminderDateLabel extends StatelessWidget {
  final DateTime date;

  const ReminderDateLabel({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return RichText(
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Today',
            style: TextStyle(
              color: AppColors.primaryDarkActive,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: ' • ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: '${date.day}, ${months[date.month - 1]}, ${date.year}',
            style: TextStyle(
              color: AppColors.primaryNormal,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
