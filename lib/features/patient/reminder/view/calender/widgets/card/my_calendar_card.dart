import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_formatters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/card/my_calendar_content.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/card/my_calendar_title_row.dart';

class MyCalendarCard extends StatefulWidget {
  final String title;
  final TextEditingController searchController;

  /// Current visible month (yyyy-mm-01).
  final DateTime currentMonth;

  /// Selected date (yyyy-mm-dd).
  final DateTime selectedDate;

  /// Called when user selects a date from the grid.
  final ValueChanged<DateTime> onSelectDate;

  /// Called when user changes month (prev/next).
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
  bool expanded = true;

  /// Cache the 42 calendar cells to avoid rebuilding the list on every build.
  late List<DateTime> _days;

  @override
  void initState() {
    super.initState();
    _days = buildCalendarDays(widget.currentMonth);
  }

  @override
  void didUpdateWidget(covariant MyCalendarCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Recompute only when month changes.
    if (oldWidget.currentMonth.year != widget.currentMonth.year ||
        oldWidget.currentMonth.month != widget.currentMonth.month) {
      _days = buildCalendarDays(widget.currentMonth);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          MyCalendarTitleRow(
            title: widget.title,
            expanded: expanded,
            onToggle: () => setState(() => expanded = !expanded),
          ),
          MyCalendarContent(
            expanded: expanded,
            days: _days,
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