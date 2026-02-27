import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_formatters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/myCalenderCard/my_calendar_search_field.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/myCalenderCard/my_calendar_week_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/my_calendar_month_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/primary_wide_button.dart';

import '../calendar_day_cell.dart';

///----------------------------
/// CONTENT (COLLAPSIBLE)
///----------------------------

class MyCalendarContent extends StatelessWidget {
  final bool expanded;
  final List<DateTime> days;

  final TextEditingController searchController;
  final DateTime currentMonth;
  final DateTime selectedDate;

  final ValueChanged<DateTime> onSelectDate;
  final ValueChanged<DateTime> onChangeMonth;

  const MyCalendarContent({
    super.key,
    required this.expanded,
    required this.days,
    required this.searchController,
    required this.currentMonth,
    required this.selectedDate,
    required this.onSelectDate,
    required this.onChangeMonth,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      //animate heightFactor from 0 -> 1 and back
      tween: Tween<double>(end: expanded ? 1.0 : 0.0),
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: value,
            child: child,
          ),
        );
      },

      //keep heavy UI here so it doesn't rebuild each frame
      child: IgnorePointer(
        //disable touches when collapsed
        ignoring: !expanded,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),

            //search field
            MyCalendarSearchField(controller: searchController),

            SizedBox(height: 16.h),

            //month header (prev/next)
            MyCalendarMonthHeader(
              month: currentMonth,
              onPrev: () => onChangeMonth(prevMonthStart(currentMonth)),
              onNext: () => onChangeMonth(nextMonthStart(currentMonth)),
            ),

            SizedBox(height: 12.h),

            //week header
            const MyCalendarWeekHeader(),

            SizedBox(height: 8.h),

            //month grid
            GridView.builder(
              itemCount: days.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemBuilder: (context, i) {
                final d = days[i];
                final isInMonth = d.month == currentMonth.month;
                final isSelected = isSameCalendarDay(d, selectedDate);

                return CalendarDayCell(
                  date: d,
                  isInMonth: isInMonth,
                  isSelected: isSelected,
                  onTap: () => onSelectDate(d),
                );
              },
            ),

            //add new calendar button
            PrimaryWideButton(text: '+ Add new calendar', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
