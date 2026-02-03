import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_filter.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_events_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/myCalenderCard/my_calendar_card.dart';

class MonthCalenderSection extends StatelessWidget {
  final TextEditingController search;
  final DateTime currentMonth;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelectDate;
  final ValueChanged<DateTime> onChangeMonth;

  const MonthCalenderSection({
    super.key,
    required this.search,
    required this.currentMonth,
    required this.selectedDate,
    required this.onSelectDate,
    required this.onChangeMonth,
  });

  @override
  Widget build(BuildContext context) {
    final items = filterRemindersByDate(reminders, selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyCalendarCard(
          title: 'My Calendar',
          searchController: search,
          currentMonth: currentMonth,
          selectedDate: selectedDate,
          onSelectDate: onSelectDate,
          onChangeMonth: onChangeMonth,
        ),
        SizedBox(height: 14.h),

        CalendarEventsSection(date: selectedDate, items: items),
      ],
    );
  }
}
