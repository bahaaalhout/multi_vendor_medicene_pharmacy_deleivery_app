  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';

  import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/circle_icon_button.dart';
  import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';
  import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_states.dart';
  import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/date_time_utils.dart';
  import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/sections/reminder_day_strip.dart';
  import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/shared_widgets/border_box.dart';
  import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/calender/widgets/list/reminder_items_list.dart';

  class WeekCalenderSection extends StatelessWidget {
    final ValueChanged<DateTime> onSelectedDateChanged;

    const WeekCalenderSection({
      super.key,
      required this.onSelectedDateChanged,
    });

    @override
    Widget build(BuildContext context) {
      return BlocBuilder<ReminderCubit, ReminderStates>(
        builder: (context, state) {
          if (state is! ReminderSuccessState) return const SizedBox.shrink();

          final cubit = context.read<ReminderCubit>();

          void goTo(DateTime d) {
            onSelectedDateChanged(d);
            cubit.loadReminders(date: d);
          }

          return BorderBox(
            child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleIconButton(
                        assetIcon: "assets/icons/arrow_left.svg",
                        onPressed: () => goTo(prevWeek(state.selectedDate)),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: ReminderDayStrip(
                          days: state.days,
                          selectedDay: state.selectedDate.day,
                          onSelectDay: (dayNumber) {
                            final pickedDay = state.days.firstWhere(
                              (x) => x.dayNumber == dayNumber,
                              orElse: () => state.days.first,
                            );
                            goTo(pickedDay.date);
                          },
                        ),
                      ),
                      SizedBox(width: 8.w),
                      CircleIconButton(
                        assetIcon: "assets/icons/arrow_right.svg",
                        onPressed: () => goTo(nextWeek(state.selectedDate)),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  ReminderItemsList(items: state.dayReminders,scrollable: false, ),
                ],
              ),
            ),
          );
        },
      );
    }
  }