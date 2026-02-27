import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/confirm_reminder_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/confirm_reminder_args.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/shared_widgets/main_frame.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

import 'widgets/overview_row.dart';

class ConfirmReminderPage extends StatelessWidget {
  final ConfirmReminderArgs args;

  const ConfirmReminderPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final meds = args.medicines;
    final schedule = args.schedule;

    //  start date = today (without global now)
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, now.day);

    //  end date per med
    final endDates = estimateEndDatesForSelectedMeds(
      meds: meds,
      schedule: schedule,
      start: startDate,
      dosePerTime: 1,
    );

    final earliestEnd = endDates.values.isEmpty
        ? startDate.add(const Duration(days: 1))
        : endDates.values.reduce((a, b) => a.isBefore(b) ? a : b);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 34.h),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.w,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: SvgPicture.asset("assets/icons/back.svg"),
                  ),
                ),
                SizedBox(width: 30.w),
                Text(
                  'Confirm Reminder',
                  style: AppTextStyles.bold22.copyWith(
                    height: 1.5,
                    color: AppColors.primaryDarker,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),
            Text(
              '•  Review the details before confirming',
              style: AppTextStyles.medium16.copyWith(
                color: AppColors.neutralDarker,
              ),
            ),

            SizedBox(height: 14.h),

            //  Selected medicines
            MainFrame(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You’re setting reminders for:',
                    style: AppTextStyles.medium14.copyWith(
                      color: AppColors.neutralDarkActive,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  ...meds.map((m) {
                    final img = (m.imageUrls.isNotEmpty) ? m.imageUrls.first : null;
                    final end = endDates[m.id] ?? startDate.add(const Duration(days: 1));

                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        children: [
                          Container(
                            width: 56.w,
                            height: 56.w,
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.neutralNormal),
                            ),
                            child: img == null
                                ? const Icon(Icons.medication_outlined)
                                : Image.network(img, fit: BoxFit.contain),
                          ),
                          SizedBox(width: 12.w),

                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        m.brandName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.semiBold14.copyWith(color: Colors.black),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        m.genericName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.reqular12.copyWith(color: AppColors.neutralDark),
                                      ),
                                      SizedBox(height: 6.h),

                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Ends on: ',
                                              style: AppTextStyles.reqular12.copyWith(color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: formatFullDate(end),
                                              style: AppTextStyles.reqular12.copyWith(color: AppColors.primaryNormal),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 10.w),

                                Container(
                                  width: 65.w,
                                  height: 80.w,
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryLight,
                                    borderRadius: BorderRadius.circular(16.w),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "x${schedule.times.length}/day",
                                      style: AppTextStyles.semiBold14.copyWith(
                                        color: AppColors.secondaryDarkActive,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            //  Schedule Overview
            MainFrame(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Schedule Overview',
                    style: AppTextStyles.semiBold14.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: 12.h),

                  OverviewRow(
                    iconAsset: "assets/icons/time.svg",
                    title: 'Time',
                    valueSpans: [
                      TextSpan(
                        text: 'Starts at: ',
                        style: AppTextStyles.medium14.copyWith(color: Colors.black),
                      ),
                      TextSpan(
                        text: schedule.times.isEmpty ? '-' : schedule.times.first,
                        style: AppTextStyles.medium14.copyWith(color: AppColors.primaryNormal),
                      ),
                    ],
                    sub: 'Repeats: Automatically adjusted',
                  ),

                  SizedBox(height: 10.h),

                  OverviewRow(
                    iconAsset: "assets/icons/time.svg",
                    title: 'Days',
                    valueSpans: [
                      TextSpan(
                        text: 'Starts on: ',
                        style: AppTextStyles.medium14.copyWith(color: Colors.black),
                      ),
                      TextSpan(
                        text:
                            '${dayCodeToFull(schedule.days.isEmpty ? 'Sun' : schedule.days.first)} - ${formatFullDate(startDate)}',
                        style: AppTextStyles.medium14.copyWith(color: AppColors.primaryNormal),
                      ),
                    ],
                    sub: 'Repeats: Automatically adjusted',
                  ),

                  SizedBox(height: 10.h),

                  OverviewRow(
                    iconAsset: "assets/icons/time.svg",
                    title: 'Frequency',
                    valueSpans: [
                      TextSpan(
                        text: 'Schedule: ',
                        style: AppTextStyles.medium14.copyWith(color: Colors.black),
                      ),
                      TextSpan(
                        text: schedule.frequency.isEmpty ? '-' : schedule.frequency,
                        style: AppTextStyles.medium14.copyWith(color: AppColors.primaryNormal),
                      ),
                    ],
                    sub:
                        'Repeats ${frequencyToSub(schedule.frequency)} • Ends on ${formatFullDate(earliestEnd)} (earliest medicine)',
                  ),

                  SizedBox(height: 14.h),
                ],
              ),
            ),

            const Spacer(),

            // Buttons
            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNormal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                onPressed: () async {
                  final res = await context.push(AppRoutes.reminderSet, extra: args);
                  if (res is List<ReminderItem>) context.pop(res);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm Reminder',
                      style: AppTextStyles.semiBold14.copyWith(color: Colors.white),
                    ),
                    SizedBox(width: 12.w),
                    SizedBox(
                      width: 20.w,
                      child: SvgPicture.asset(
                        "assets/icons/reminder.svg",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 5.h),

            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryNormal, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                onPressed: () => context.pop(),
                child: Text(
                  'Edit',
                  style: AppTextStyles.semiBold14.copyWith(color: AppColors.primaryNormal),
                ),
              ),
            ),

            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}