import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_date_label.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_date_selector.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_states.dart';
import '../widgets/reminder_day_strip.dart';
import '../widgets/reminder_list_item.dart';

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({super.key});

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  //DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // final days = buildDaysStrip(selectedDate);
    // final dayReminders = filterRemindersByDate(reminders, selectedDate);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppPrimaryAppBar(
        title: 'Add Reminder',
        onBack: () {},
        onAction: () {},
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: BlocBuilder<ReminderCubit, ReminderStates>(
          builder: (context, state) {
            // //when loading -> for example show progress
            // if (state is ReminderLoadingState) {
            //   return const Center(child: CircularProgressIndicator());
            // }

            // //when error -> show scafold
            // if (state is ReminderErrorState) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       content: Text(state.errorMsg),
            //       backgroundColor: Colors.redAccent,
            //       behavior: SnackBarBehavior.floating,
            //     ),
            //   );
            // }

            //when success -> build header + list based on selected date
            if (state is ReminderSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, state),
                  SizedBox(height: 12.h),
                  _buildList(state),
                ],
              );
            }

            //initial -> empty
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  //Widget _buildHeader(List<DayItem> days) {
  Widget _buildHeader(BuildContext context, ReminderSuccessState state) {
    final cubit = context.read<ReminderCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDateSelector(
          //dateWidget: AppDateLabel(date: selectedDate),
          //onPrev: _prevDay,
          //onNext: _nextDay,

          //show selectedDate from cubit state
          dateWidget: AppDateLabel(date: state.selectedDate),

          //when user click prev day -> cubit loads previous date reminders
          onPrev: () => cubit.prevDay(state.selectedDate),

          //when user click next day -> cubit loads next date reminders
          onNext: () => cubit.nextDay(state.selectedDate),
        ),
        SizedBox(height: 12.h),
        ReminderDayStrip(
          //days: days,
          //selectedDay: selectedDate.day,
          //onSelectDay: _onSelectDay,

          //days strip from cubit state
          days: state.days,

          //highlight day based on selectedDate in cubit
          selectedDay: state.selectedDate.day,

          //when user click any day on strip -> load reminders for that day
          onSelectDay: (d) => cubit.selectDay(state.selectedDate, d),
        ),
        SizedBox(height: 16.h),
        //_buildTitle(),
        _buildTitle(state),
      ],
    );
  }

  //Widget _buildTitle() {
  Widget _buildTitle(ReminderSuccessState state) {
    return Row(
      children: [
        Text(
          'Today',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryDarkActive,
          ),
        ),
        const Spacer(),
        Text(
          //'${filterRemindersByDate(reminders, selectedDate).length} Reminders',

          //show reminders count based on cubit filtered list
          '${state.dayReminders.length} Reminders',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.primaryNormal,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  //Widget _buildList(List<ReminderItem> dayReminders) {
  Widget _buildList(ReminderSuccessState state) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 48 + 80.h),
        //itemCount: dayReminders.length,
        itemCount: state.dayReminders.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, i) {
          //return ReminderListItem(item: dayReminders[i]);
          return ReminderListItem(item: state.dayReminders[i]);
        },
      ),
    );
  }

  // void _prevDay() {
  //   setState(() {
  //     selectedDate = selectedDate.subtract(const Duration(days: 1));
  //   });
  // }

  // void _nextDay() {
  //   setState(() {
  //     selectedDate = selectedDate.add(const Duration(days: 1));
  //   });
  // }

  // void _onSelectDay(int d) {
  //   setState(() {
  //     selectedDate = DateTime(selectedDate.year, selectedDate.month, d);
  //   });
  // }
}
