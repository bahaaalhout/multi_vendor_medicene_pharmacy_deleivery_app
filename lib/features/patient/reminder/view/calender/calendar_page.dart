import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/add_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_actions.dart'
    as nav;
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_formatters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_page_actions.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/sections/day_calender_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/sections/month_calender_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/sections/week_calender_section.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_month_top_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_tabs.dart';

import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  //active tab
  CalendarViewTab tab = CalendarViewTab.month;

  //current visible month (yyyy-mm-01)
  DateTime currentMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );

  //selected day (yyyy-mm-dd)
  DateTime selectedDate = DateTime.now();

  //search controller (month view)
  final TextEditingController search = TextEditingController();

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //month label like: January 2026
    final monthLabel = monthYearLabel(currentMonth);

    //fix: List<dynamic> -> List<ReminderItem>
    final List<ReminderItem> typedReminders = reminders.cast<ReminderItem>();

    return BlocProvider(
      create: (_) =>
          ReminderCubit(typedReminders)..loadReminders(date: selectedDate),
      child: Scaffold(
        appBar: AppPrimaryAppBar(
          title: 'Calendar',
          actionWidget: AddButton(
            fun: () => context.push(AppRoutes.medicationReminder),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //month header (month + today + arrows)
              CalendarMonthTopBar(
                monthLabel: monthLabel,
                onPrev: tab == CalendarViewTab.month ? _prevPeriod : null,
                onNext: tab == CalendarViewTab.month ? _nextPeriod : null,
                onToday: _goToday,
              ),

              SizedBox(height: 12.h),

              //tabs (month/week/day)
              CalendarTabs(
                selected: tab,
                onChanged: (v) => setState(() => tab = v),
              ),

              SizedBox(height: 16.h),

              //sections based on tab
              if (tab == CalendarViewTab.month) ...[
                MonthCalenderSection(
                  search: search,
                  currentMonth: currentMonth,
                  selectedDate: selectedDate,
                  onSelectDate: _selectDate,
                  onChangeMonth: _changeMonth,
                ),
              ] else if (tab == CalendarViewTab.week) ...[
                WeekCalenderSection(onSelectedDateChanged: (v) => selectDate),
              ] else ...[
                DayCalenderSection(),
              ],

              SizedBox(height: 118.h + 16),
            ],
          ),
        ),
      ),
    );
  }
}

extension CalendarPageActions on _CalendarPageState {
  void _selectDate(DateTime d) {
    setState(() {
      selectedDate = d;
      currentMonth = DateTime(d.year, d.month, 1);
    });
    context.read<ReminderCubit>().loadReminders(date: selectedDate);
  }

  void _changeMonth(DateTime m) {
    setState(() {
      currentMonth = m;
      selectedDate = clampSelectedToMonth(selectedDate, currentMonth);
    });
    context.read<ReminderCubit>().loadReminders(date: selectedDate);
  }

  void _applyNav(nav.CalendarNavResult r) {
    setState(() {
      currentMonth = r.currentMonth;
      selectedDate = r.selectedDate;
    });
    context.read<ReminderCubit>().loadReminders(date: selectedDate);
  }

  void _prevPeriod() {
    final r = nav.computePrevPeriod(
      tab: tab,
      currentMonth: currentMonth,
      selectedDate: selectedDate,
    );
    _applyNav(r);
  }

  void _nextPeriod() {
    final r = nav.computeNextPeriod(
      tab: tab,
      currentMonth: currentMonth,
      selectedDate: selectedDate,
    );
    _applyNav(r);
  }

  void _goToday() {
    final r = nav.computeToday();
    _applyNav(r);
  }
}
