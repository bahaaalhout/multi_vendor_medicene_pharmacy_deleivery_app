import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_helpers.dart';

class CalendarMonthGrid extends StatelessWidget {
  final DateTime monthStart; // yyyy-mm-01
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelect;

  const CalendarMonthGrid({
    super.key,
    required this.monthStart,
    required this.selectedDate,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final days = buildCalendarDays(monthStart);
    final weekdays = const ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekdays
              .map(
                (w) => SizedBox(
                  width: 36.w,
                  child: Center(
                    child: Text(
                      w,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryNormal,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: days.map((d) {
            final isInMonth = d.month == monthStart.month;
            final isSelected =
                d.year == selectedDate.year &&
                d.month == selectedDate.month &&
                d.day == selectedDate.day;

            return InkWell(
              onTap: isInMonth ? () => onSelect(d) : null,
              borderRadius: BorderRadius.circular(999.r),
              child: Container(
                width: 36.w,
                height: 36.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryNormal
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  '${d.day}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: !isInMonth
                        ? const Color.fromRGBO(160, 170, 190, 1)
                        : (isSelected
                              ? Colors.white
                              : AppColors.primaryDarkActive),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
