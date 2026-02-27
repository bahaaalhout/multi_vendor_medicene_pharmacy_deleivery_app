import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_states.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/sections/calendar_events_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/card/my_calendar_card.dart';

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

        BlocBuilder<ReminderCubit, ReminderStates>(
          builder: (context, state) {
            if (state is! ReminderSuccessState) {
              return CalendarEventsSection(date: selectedDate, items: const []);
            }
            return CalendarEventsSection(
              date: state.selectedDate,
              items: state.dayReminders,
            );
          },
        ),
      ],
    );
  }
}
