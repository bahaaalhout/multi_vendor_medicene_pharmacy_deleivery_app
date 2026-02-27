import 'package:flutter/material.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/sections/day_calender_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/sections/month_calender_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/sections/week_calender_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/sections/calendar_tabs.dart';

class CalendarPager extends StatelessWidget {
  final PageController controller;
  final CalendarViewTab tab;

  final TextEditingController search;
  final DateTime currentMonth;
  final DateTime selectedDate;

  final void Function(DateTime) onSelectDate;
  final void Function(DateTime) onChangeMonth;

  final void Function(CalendarViewTab) onTabChangedFromSwipe;

  const CalendarPager({
    super.key,
    required this.controller,
    required this.tab,
    required this.search,
    required this.currentMonth,
    required this.selectedDate,
    required this.onSelectDate,
    required this.onChangeMonth,
    required this.onTabChangedFromSwipe,
  });

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      reverse: true,
      physics: const BouncingScrollPhysics(),
      onPageChanged: (index) => onTabChangedFromSwipe(_indexToTab(index)),
      children: [
         SizedBox.expand(
          child: MonthCalenderSection(
            search: search,
            currentMonth: currentMonth,
            selectedDate: selectedDate,
            onSelectDate: onSelectDate,
            onChangeMonth: onChangeMonth,
          ),
        ),
         SizedBox.expand(child: WeekCalenderSection(onSelectedDateChanged: onSelectDate)),
          SizedBox.expand(child: DayCalenderSection()),
      ],
    );
  }

  CalendarViewTab _indexToTab(int index) {
    if (index == 0) return CalendarViewTab.month;
    if (index == 1) return CalendarViewTab.week;
    return CalendarViewTab.day;
  }
}