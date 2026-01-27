import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/more_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_helpers.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_filter.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_events_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_month_top_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/my_calendar_card.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/primary_wide_button.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarViewTab tab = CalendarViewTab.month;

  DateTime currentMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );
  DateTime selectedDate = DateTime.now();

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final monthLabel = monthYearLabel(currentMonth);
    final dayItems = filterRemindersByDate(reminders, selectedDate);

    return Scaffold(
      appBar: AppPrimaryAppBar(
        title: 'Calendar',
        actionWidget: MoreButton(
          fun: () {
            //open  menu / bottom sheet / dialog etc
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CalendarMonthTopBar(
              monthLabel: monthLabel,
              onPrev: _prevMonth,
              onNext: _nextMonth,
              onToday: _goToday,
            ),
            SizedBox(height: 12.h),
            CalendarTabs(
              selected: tab,
              onChanged: (v) => setState(() => tab = v),
            ),
            SizedBox(height: 16.h),
            MyCalendarCard(
              title: 'My Calendar',
              searchController: search,
              currentMonth: currentMonth,
              selectedDate: selectedDate,
              onSelectDate: (d) => setState(() {
                selectedDate = d;
                currentMonth = DateTime(d.year, d.month, 1);
              }),
            ),
            SizedBox(height: 12.h),

            PrimaryWideButton(text: '+ Add new calendar', onTap: () {}),
            SizedBox(height: 14.h),

            CalendarEventsSection(
              date: selectedDate,
              items: dayItems,
              onPrevDay: () => setState(() {
                selectedDate = selectedDate.subtract(const Duration(days: 1));
                currentMonth = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  1,
                );
              }),
              onNextDay: () => setState(() {
                selectedDate = selectedDate.add(const Duration(days: 1));
                currentMonth = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  1,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _prevMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
      selectedDate = clampSelectedToMonth(selectedDate, currentMonth);
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
      selectedDate = clampSelectedToMonth(selectedDate, currentMonth);
    });
  }

  void _goToday() {
    final now = DateTime.now();
    setState(() {
      currentMonth = DateTime(now.year, now.month, 1);
      selectedDate = DateTime(now.year, now.month, now.day);
    });
  }
}
