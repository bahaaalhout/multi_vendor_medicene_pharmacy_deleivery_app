import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_actions.dart' as nav;
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_formatters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/header/calendar_header_row.dart.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/pager/calendar_pager.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/sections/calendar_month_top_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/sections/calendar_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';



class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarViewTab tab = CalendarViewTab.month;

  DateTime currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime selectedDate = DateTime.now();

  final TextEditingController search = TextEditingController();
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex(tab));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReminderCubit>().loadReminders(date: selectedDate);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SizedBox(height: 18.h),

              CalendarHeaderRow(
                title: 'Calendar',
                onAdd: () async {
                  await context.push(AppRoutes.medicationReminder);
                  if (!context.mounted) return;
                  context.read<ReminderCubit>().loadReminders(date: selectedDate);
                },
              ),

              CalendarMonthTopBar(
                monthLabel: monthYearLabel(currentMonth),
                onPrev: tab == CalendarViewTab.month ? _prev : null,
                onNext: tab == CalendarViewTab.month ? _next : null,
                onToday: _today,
              ),

              SizedBox(height: 12.h),

              CalendarTabs(
                selected: tab,
                onChanged: (v) async {
                  setState(() => tab = v);
                  await _animateToTab(v);
                },
              ),

              SizedBox(height: 16.h),

              Expanded(
                child: CalendarPager(
                  controller: pageController,
                  tab: tab,
                  search: search,
                  currentMonth: currentMonth,
                  selectedDate: selectedDate,
                  onSelectDate: _selectDate,
                  onChangeMonth: _changeMonth,
                  onTabChangedFromSwipe: (t) => setState(() => tab = t),
                ),
              ),

              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  int _tabIndex(CalendarViewTab t) =>
      t == CalendarViewTab.month ? 0 : (t == CalendarViewTab.week ? 1 : 2);

  CalendarViewTab _indexToTab(int i) =>
      i == 0 ? CalendarViewTab.month : (i == 1 ? CalendarViewTab.week : CalendarViewTab.day);

  Future<void> _animateToTab(CalendarViewTab t) async {
    if (!pageController.hasClients) return;
    await pageController.animateToPage(
      _tabIndex(t),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
    );
  }

  void _selectDate(DateTime d) {
    setState(() {
      selectedDate = d;
      currentMonth = DateTime(d.year, d.month, 1);
    });
    context.read<ReminderCubit>().loadReminders(date: d);
  }

  void _changeMonth(DateTime m) {
    setState(() {
      currentMonth = m;
      selectedDate = clampSelectedToMonth(selectedDate, m);
    });
    context.read<ReminderCubit>().loadReminders(date: selectedDate);
  }

  void _apply(nav.CalendarNavResult r) {
    setState(() {
      currentMonth = r.currentMonth;
      selectedDate = r.selectedDate;
    });
    context.read<ReminderCubit>().loadReminders(date: selectedDate);
  }

  void _prev() => _apply(nav.computePrevPeriod(tab: tab, currentMonth: currentMonth, selectedDate: selectedDate));
  void _next() => _apply(nav.computeNextPeriod(tab: tab, currentMonth: currentMonth, selectedDate: selectedDate));
  void _today() => _apply(nav.computeToday());
}