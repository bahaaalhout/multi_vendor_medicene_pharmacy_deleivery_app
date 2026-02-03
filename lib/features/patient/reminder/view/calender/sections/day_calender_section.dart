import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_states.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/border_box.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/common_widgets/reminder_items_list.dart';

class DayCalenderSection extends StatelessWidget {
  const DayCalenderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderCubit, ReminderStates>(
      builder: (context, state) {
        if (state is! ReminderSuccessState) return const SizedBox.shrink();

        return BorderBox(
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
