import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/add_reminder_widgets/reminder_list_item.dart';

class CalendarEventsSection extends StatelessWidget {
  final DateTime date;
  final List<ReminderItem> items;
  final VoidCallback onPrevDay;
  final VoidCallback onNextDay;

  const CalendarEventsSection({
    super.key,
    required this.date,
    required this.items,
    required this.onPrevDay,
    required this.onNextDay,
  });

  @override
  Widget build(BuildContext context) {
    final label = _headerLabel(date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryDarkActive,
              ),
            ),
            const Spacer(),
            _NavBtn(icon: Icons.chevron_left, onTap: onPrevDay),
            SizedBox(width: 8.w),
            _NavBtn(icon: Icons.chevron_right, onTap: onNextDay),
          ],
        ),
        SizedBox(height: 10.h),
        if (items.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(248, 250, 254, 1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFE9EDF3)),
            ),
            child: Text(
              'No events for this day',
              style: TextStyle(fontSize: 12.sp, color: AppColors.primaryNormal),
            ),
          )
        else
          ListView.separated(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, i) {
              return ReminderListItem(item: items[i]);
            },
          ),
      ],
    );
  }

  String _headerLabel(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final target = DateTime(d.year, d.month, d.day);

    if (target == today) return 'Today';
    if (target == yesterday) return 'Yesterday';

    final weekday = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ][d.weekday - 1];
    final month = [
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
    ][d.month - 1];

    return '$weekday ${d.day} $month ${d.year}';
  }
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999.r),
      child: Container(
        width: 34.w,
        height: 34.w,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE9EDF3)),
        ),
        child: Icon(icon, size: 20.sp, color: AppColors.primaryDarkActive),
      ),
    );
  }
}
