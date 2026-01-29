import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/add_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_helpers.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_filter.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_events_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_month_top_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/my_calendar_card.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

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
        actionWidget: AddButton(
          fun: () {
            context.push(AppRoutes.medicationReminder);
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

            //my calendar card (month grid)
            MyCalendarCard(
              title: 'My Calendar',
              searchController: search,
              currentMonth: currentMonth,
              selectedDate: selectedDate,

              //when user select day
              onSelectDate: (d) => setState(() {
                selectedDate = d;
                currentMonth = DateTime(d.year, d.month, 1);
              }),

              //when user change month only
              onChangeMonth: (m) => setState(() {
                currentMonth = m;
                selectedDate = clampSelectedToMonth(selectedDate, currentMonth);
              }),
            ),

            SizedBox(height: 12.h),
            SizedBox(height: 14.h),

            //events section
            CalendarEventsSection(date: selectedDate, items: dayItems),

            SizedBox(height: 118.h + 16),
          ],
        ),
      ),
    );
  }

  void _prevMonth() {
    setState(() {
      currentMonth = prevMonthStart(currentMonth);
      selectedDate = clampSelectedToMonth(selectedDate, currentMonth);
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = nextMonthStart(currentMonth);
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
