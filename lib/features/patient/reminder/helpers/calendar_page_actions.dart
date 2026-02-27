import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_actions.dart'
    as nav;
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_formatters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/sections/calendar_tabs.dart';

void selectDate({
  required BuildContext context,
  required void Function(VoidCallback fn) setState,
  required DateTime d,
  required DateTime currentMonth,
  required void Function(DateTime v) setCurrentMonth,
  required void Function(DateTime v) setSelectedDate,
}) {
  setState(() {
    setSelectedDate(d);
    setCurrentMonth(DateTime(d.year, d.month, 1));
  });
  context.read<ReminderCubit>().loadReminders(date: d);
}

void changeMonth({
  required BuildContext context,
  required void Function(VoidCallback fn) setState,
  required DateTime month,
  required DateTime selectedDate,
  required void Function(DateTime v) setCurrentMonth,
  required void Function(DateTime v) setSelectedDate,
}) {
  final clamped = clampSelectedToMonth(selectedDate, month);

  setState(() {
    setCurrentMonth(month);
    setSelectedDate(clamped);
  });
  context.read<ReminderCubit>().loadReminders(date: clamped);
}

void applyNav({
  required BuildContext context,
  required void Function(VoidCallback fn) setState,
  required nav.CalendarNavResult r,
  required void Function(DateTime v) setCurrentMonth,
  required void Function(DateTime v) setSelectedDate,
}) {
  setState(() {
    setCurrentMonth(r.currentMonth);
    setSelectedDate(r.selectedDate);
  });
  context.read<ReminderCubit>().loadReminders(date: r.selectedDate);
}

void prevPeriod({
  required BuildContext context,
  required void Function(VoidCallback fn) setState,
  required CalendarViewTab tab,
  required DateTime currentMonth,
  required DateTime selectedDate,
  required void Function(DateTime v) setCurrentMonth,
  required void Function(DateTime v) setSelectedDate,
}) {
  final r = nav.computePrevPeriod(
    tab: tab,
    currentMonth: currentMonth,
    selectedDate: selectedDate,
  );
  applyNav(
    context: context,
    setState: setState,
    r: r,
    setCurrentMonth: setCurrentMonth,
    setSelectedDate: setSelectedDate,
  );
}

void nextPeriod({
  required BuildContext context,
  required void Function(VoidCallback fn) setState,
  required CalendarViewTab tab,
  required DateTime currentMonth,
  required DateTime selectedDate,
  required void Function(DateTime v) setCurrentMonth,
  required void Function(DateTime v) setSelectedDate,
}) {
  final r = nav.computeNextPeriod(
    tab: tab,
    currentMonth: currentMonth,
    selectedDate: selectedDate,
  );
  applyNav(
    context: context,
    setState: setState,
    r: r,
    setCurrentMonth: setCurrentMonth,
    setSelectedDate: setSelectedDate,
  );
}

void goToday({
  required BuildContext context,
  required void Function(VoidCallback fn) setState,
  required void Function(DateTime v) setCurrentMonth,
  required void Function(DateTime v) setSelectedDate,
}) {
  final r = nav.computeToday();
  applyNav(
    context: context,
    setState: setState,
    r: r,
    setCurrentMonth: setCurrentMonth,
    setSelectedDate: setSelectedDate,
  );
}
