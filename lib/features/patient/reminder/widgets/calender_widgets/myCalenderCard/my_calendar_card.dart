import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_formatters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/myCalenderCard/my_calendar_content.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/myCalenderCard/my_calendar_title_row.dart';

class MyCalendarCard extends StatefulWidget {
  final String title;
  final TextEditingController searchController;

  //current visible month (yyyy-mm-01)
  final DateTime currentMonth;

  //selected day (yyyy-mm-dd)
  final DateTime selectedDate;

  //when user select a day from grid
  final ValueChanged<DateTime> onSelectDate;

  //when user change month only (prev/next)
  final ValueChanged<DateTime> onChangeMonth;

  const MyCalendarCard({
    super.key,
    required this.title,
    required this.searchController,
    required this.currentMonth,
    required this.selectedDate,
    required this.onSelectDate,
    required this.onChangeMonth,
  });

  @override
  State<MyCalendarCard> createState() => _MyCalendarCardState();
}

class _MyCalendarCardState extends State<MyCalendarCard> {
  //expand/collapse state
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    //build 42 cells to match figma
    final days = buildCalendarDays(widget.currentMonth);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.secondaryLightActive),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title row + expand/collapse icon
          MyCalendarTitleRow(
            title: widget.title,
            expanded: expanded,
            onToggle: () => setState(() => expanded = !expanded),
          ),

          //content (collapsible)
          MyCalendarContent(
            expanded: expanded,
            days: days,
            searchController: widget.searchController,
            currentMonth: widget.currentMonth,
            selectedDate: widget.selectedDate,
            onSelectDate: widget.onSelectDate,
            onChangeMonth: widget.onChangeMonth,
          ),
        ],
      ),
    );
  }
}
