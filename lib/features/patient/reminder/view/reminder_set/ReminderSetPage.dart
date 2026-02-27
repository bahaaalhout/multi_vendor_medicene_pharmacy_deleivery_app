import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_factory.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_set_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/confirm_reminder_args.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

import 'widgets/selected_medicines_card.dart';

class ReminderSetPage extends StatelessWidget {
  final ConfirmReminderArgs args;

  const ReminderSetPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final meds = args.medicines;

    final firstTime = args.schedule.times.isNotEmpty
        ? args.schedule.times.first
        : '-';
    final timesPerDay = args.schedule.times.length;

    final untilText = formatShortMonthDay(
      estimateEndDateFromSchedule(args),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => context.pop(),
                          borderRadius: BorderRadius.circular(999.r),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      SizedBox(
                        width: 120.w,
                        height: 120.w,
                        child: SvgPicture.asset("assets/icons/sucess.svg"),
                      ),
                      SizedBox(height: 16.h),

                      Text(
                        'Your medication reminder is active',
                        style: AppTextStyles.medium16.copyWith(
                          color: AppColors.neutralDarker,
                        ),
                      ),
                      SizedBox(height: 18.h),

                      if (meds.isNotEmpty)
                        SelectedMedicinesCard(
                          meds: meds,
                          timesPerDay: timesPerDay,
                          frequency: safeFreqLabel(args.schedule.frequency),
                          untilText: untilText,
                          firstTime: firstTime,
                        ),

                      const Spacer(),

                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryNormal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                          ),
                          onPressed: () {
                            final now = DateTime.now();
                            final start = DateTime(now.year, now.month, now.day);
                            final end = start.add(const Duration(days: 30));

                            final List<ReminderItem> newItems = buildReminderItems(
                              medicines: args.medicines,
                              times: args.schedule.times,
                              days: args.schedule.days,
                              frequency: args.schedule.frequency,
                              startDate: start,
                              endDate: end,
                              dose: 1,
                            );

                            context.pop(newItems);
                          },
                          child: Text(
                            'Done',
                            style: AppTextStyles.semiBold14.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}