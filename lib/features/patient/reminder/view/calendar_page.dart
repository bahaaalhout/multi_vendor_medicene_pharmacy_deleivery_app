import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/add_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_states.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_helpers.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_filter.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/add_reminder_widgets/reminder_day_strip.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/common_widgets/reminder_items_list.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_events_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_month_top_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/calendar_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/my_calendar_card.dart';

import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

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
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final monthLabel = monthYearLabel(currentMonth);

    // ✅ fix: List<dynamic> -> List<ReminderItem>
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
              // ✅ هذا الهيدر "الشهر + today + arrows" يضل زي القديم لكل التابات
              CalendarMonthTopBar(
                monthLabel: monthLabel,
                onPrev: _prevPeriod,
                onNext: _nextPeriod,
                onToday: _goToday,
              ),

              SizedBox(height: 12.h),

              CalendarTabs(
                selected: tab,
                onChanged: (v) => setState(() => tab = v),
              ),

              SizedBox(height: 16.h),

              if (tab == CalendarViewTab.month) ...[
                _MonthView(
                  search: search,
                  currentMonth: currentMonth,
                  selectedDate: selectedDate,
                  onSelectDate: (d) {
                    setState(() {
                      selectedDate = d;
                      currentMonth = DateTime(d.year, d.month, 1);
                    });
                    context.read<ReminderCubit>().loadReminders(date: d);
                  },
                  onChangeMonth: (m) {
                    setState(() {
                      currentMonth = m;
                      selectedDate = clampSelectedToMonth(
                        selectedDate,
                        currentMonth,
                      );
                    });
                    context.read<ReminderCubit>().loadReminders(
                      date: selectedDate,
                    );
                  },
                ),
              ] else if (tab == CalendarViewTab.week) ...[
                _WeekView(
                  onSelectedDateChanged: (d) {
                    setState(() {
                      selectedDate = d;
                      currentMonth = DateTime(d.year, d.month, 1);
                    });
                  },
                ),
              ] else ...[
                _DayView(),
              ],

              SizedBox(height: 118.h + 16),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ الأسهم في الهيدر القديم:
  // month => شهر
  // week  => أسبوع
  // day   => يوم
  void _prevPeriod() {
    final cubit = context.read<ReminderCubit>();

    setState(() {
      if (tab == CalendarViewTab.month) {
        currentMonth = prevMonthStart(currentMonth);
        selectedDate = clampSelectedToMonth(selectedDate, currentMonth);
      } else if (tab == CalendarViewTab.week) {
        selectedDate = selectedDate.subtract(const Duration(days: 7));
        currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);
      } else {
        selectedDate = selectedDate.subtract(const Duration(days: 1));
        currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);
      }
    });

    cubit.loadReminders(date: selectedDate);
  }

  void _nextPeriod() {
    final cubit = context.read<ReminderCubit>();

    setState(() {
      if (tab == CalendarViewTab.month) {
        currentMonth = nextMonthStart(currentMonth);
        selectedDate = clampSelectedToMonth(selectedDate, currentMonth);
      } else if (tab == CalendarViewTab.week) {
        selectedDate = selectedDate.add(const Duration(days: 7));
        currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);
      } else {
        selectedDate = selectedDate.add(const Duration(days: 1));
        currentMonth = DateTime(selectedDate.year, selectedDate.month, 1);
      }
    });

    cubit.loadReminders(date: selectedDate);
  }

  void _goToday() {
    final cubit = context.read<ReminderCubit>();

    final now = DateTime.now();
    setState(() {
      selectedDate = DateTime(now.year, now.month, now.day);
      currentMonth = DateTime(now.year, now.month, 1);
    });

    cubit.loadReminders(date: selectedDate);
  }
}

// =====================================================
// MONTH VIEW (مثل القديم)
// =====================================================
class _MonthView extends StatelessWidget {
  final TextEditingController search;
  final DateTime currentMonth;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelectDate;
  final ValueChanged<DateTime> onChangeMonth;

  const _MonthView({
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

        // ✅ هيدر الشهر الداخلي يبقى زي ما كان (Today + reminders)
        CalendarEventsSection(date: selectedDate, items: items),
      ],
    );
  }
}

// =====================================================
// WEEK VIEW (بدون هيدر داخلي — فقط arrows + day strip + list داخل نفس الإطار)
// =====================================================
class _WeekView extends StatelessWidget {
  final ValueChanged<DateTime> onSelectedDateChanged;
  const _WeekView({required this.onSelectedDateChanged});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderCubit, ReminderStates>(
      builder: (context, state) {
        if (state is! ReminderSuccessState) return const SizedBox.shrink();

        final cubit = context.read<ReminderCubit>();

        return _BorderBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ الأسهم على جنبي الـ DayStrip (زي Add Reminder)
              Row(
                children: [
                  _CircleBtn(
                    icon: Icons.chevron_left,
                    onTap: () {
                      final d = state.selectedDate.subtract(
                        const Duration(days: 7),
                      );
                      onSelectedDateChanged(d);
                      cubit.loadReminders(date: d);
                    },
                  ),
                  SizedBox(width: 8.w),

                  Expanded(
                    child: ReminderDayStrip(
                      days: state.days,
                      selectedDay: state.selectedDate.day,
                      onSelectDay: (dayNumber) {
                        // ✅ أهم fix: لا تبني DateTime من year/month/day
                        // استخدم اليوم الحقيقي من state.days (فيه date كامل)
                        final pickedDay = state.days.firstWhere(
                          (x) => x.dayNumber == dayNumber,
                          orElse: () => state.days.first,
                        );

                        onSelectedDateChanged(pickedDay.date);
                        cubit.loadReminders(date: pickedDay.date);
                      },
                    ),
                  ),

                  SizedBox(width: 8.w),
                  _CircleBtn(
                    icon: Icons.chevron_right,
                    onTap: () {
                      final d = state.selectedDate.add(const Duration(days: 7));
                      onSelectedDateChanged(d);
                      cubit.loadReminders(date: d);
                    },
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              ReminderItemsList(
                items: state.dayReminders,
                padding: EdgeInsets.only(bottom: 48 + 80.h),
                scrollable: false,
              ),
            ],
          ),
        );
      },
    );
  }
}

// =====================================================
// DAY VIEW (بدون هيدر داخلي)
// =====================================================
class _DayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderCubit, ReminderStates>(
      builder: (context, state) {
        if (state is! ReminderSuccessState) return const SizedBox.shrink();

        return _BorderBox(
          child: ReminderItemsList(
            items: state.dayReminders,
            padding: EdgeInsets.only(bottom: 48 + 80.h),
            scrollable: false,
          ),
        );
      },
    );
  }
}

// =====================================================
// BORDER BOX (الإطار)
// =====================================================
class _BorderBox extends StatelessWidget {
  final Widget child;
  const _BorderBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.neutralLightActive, width: 1.w),
      ),
      child: child,
    );
  }
}

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 36.w,
        height: 36.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutralLightActive, width: 1.w),
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(icon, size: 20.sp, color: AppColors.neutralDarkActive),
      ),
    );
  }
}
