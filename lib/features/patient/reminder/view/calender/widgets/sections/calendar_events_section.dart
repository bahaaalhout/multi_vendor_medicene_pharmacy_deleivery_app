import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/list/reminder_items_list.dart';

class CalendarEventsSection extends StatelessWidget {
  final DateTime date;
  final List<ReminderItem> items;

  const CalendarEventsSection({
    super.key,
    required this.date,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(248, 250, 254, 1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 1.5, color: AppColors.secondaryLightActive),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderLabel(date: date),
          SizedBox(height: 13.h),

          // Keep list rendering responsibility inside ReminderItemsList.
          ReminderItemsList(items: items),
        ],
      ),
    );
  }
}

class _HeaderLabel extends StatelessWidget {
  final DateTime date;

  const _HeaderLabel({required this.date});

  static const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const _months = [
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

  @override
  Widget build(BuildContext context) {
    final weekday = _weekdays[date.weekday - 1];
    final month = _months[date.month - 1];

    return Row(
      children: [
        Text(
          weekday,
          style: AppTextStyles.bold20.copyWith(color: AppColors.primaryNormal),
        ),
        SizedBox(width: 12.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(color: AppColors.successLight),
          child: Text(
            '${date.day} $month ${date.year}',
            style: AppTextStyles.semiBold12.copyWith(
              color: AppColors.successDarker,
            ),
          ),
        ),
      ],
    );
  }
}