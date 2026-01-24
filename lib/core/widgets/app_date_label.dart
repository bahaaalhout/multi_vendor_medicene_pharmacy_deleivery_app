import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

class AppDateLabel extends StatelessWidget {
  final DateTime date;

  const AppDateLabel({super.key, required this.date});

  //check if the given date is today (real current day)
  bool _isToday(DateTime d) {
    final now = DateTime.now();
    return d.year == now.year && d.month == now.month && d.day == now.day;
  }

  //return weekday label based on date (Mon, Tue, Wed...)
  String _weekdayLabel(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    //list of months for formatting date text
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

    //check if selected date is today
    final bool isToday = _isToday(date);

    //if today -> show "Today"
    //if not today -> show weekday (Mon, Tue, Wed...)
    final String dayLabel = isToday ? 'Today' : _weekdayLabel(date.weekday);

    return RichText(
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            //dynamic day label (Today or weekday)
            text: dayLabel,
            style: TextStyle(
              color: AppColors.primaryDarkActive,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            //dot separator between day label and date
            text: ' • ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            //formatted date (day, month, year)
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
