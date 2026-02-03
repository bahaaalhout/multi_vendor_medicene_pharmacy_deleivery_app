// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
// import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/more_button.dart';
// import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_date_label.dart';
// import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_date_selector.dart';
// import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
// import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';
// import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_states.dart';
// import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/add_reminder_widgets/reminder_day_strip.dart';
// import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/common_widgets/reminder_items_list.dart';

// class AddReminderPage extends StatefulWidget {
//   const AddReminderPage({super.key});

//   @override
//   State<AddReminderPage> createState() => _AddReminderPageState();
// }

// class _AddReminderPageState extends State<AddReminderPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
//       appBar: AppPrimaryAppBar(
//         title: 'Add Reminder',
//         actionWidget: MoreButton(fun: () {}),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: BlocConsumer<ReminderCubit, ReminderStates>(
//           listener: (context, state) {
//             //when error -> show snack (optional)
//             //if (state is ReminderErrorState) {}
//           },
//           builder: (context, state) {
//             //when loading -> show loader (optional)
//             //if (state is ReminderLoadingState) {}

//             //when success -> build header + list based on selected date
//             if (state is ReminderSuccessState) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _Header(state: state),
//                   SizedBox(height: 12.h),
//                   Expanded(
//                     child: ReminderItemsList(
//                       items: state.dayReminders,
//                       padding: EdgeInsets.only(bottom: 48 + 80.h),
//                       scrollable: true,
//                     ),
//                   ),
//                 ],
//               );
//             }

//             //initial -> empty
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
// }

// class _Header extends StatelessWidget {
//   final ReminderSuccessState state;
//   const _Header({required this.state});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<ReminderCubit>();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         AppDateSelector(
//           //show selectedDate from cubit state
//           dateWidget: AppDateLabel(date: state.selectedDate),

//           //prev/next day load
//           onPrev: () => cubit.prevDayPressed(state.selectedDate),
//           onNext: () => cubit.nextDayPressed(state.selectedDate),
//         ),
//         SizedBox(height: 12.h),
//         ReminderDayStrip(
//           days: state.days,
//           selectedDay: state.selectedDate.day,
//           onSelectDay: (d) => cubit.selectDay(state.selectedDate, d),
//         ),
//         SizedBox(height: 16.h),
//         _TitleRow(count: state.dayReminders.length),
//       ],
//     );
//   }
// }

// class _TitleRow extends StatelessWidget {
//   final int count;
//   const _TitleRow({required this.count});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           'Today',
//           style: TextStyle(
//             fontSize: 22.sp,
//             fontWeight: FontWeight.w700,
//             color: AppColors.primaryDarkActive,
//           ),
//         ),
//         const Spacer(),
//         Text(
//           '$count Reminders',
//           style: TextStyle(
//             fontSize: 14.sp,
//             color: AppColors.primaryNormal,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }
