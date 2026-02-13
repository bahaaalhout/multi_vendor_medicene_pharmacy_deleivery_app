import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/navigate_back_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/confirm_reminder_args.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/main_frame.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

class ConfirmReminderPage extends StatelessWidget {
  final ConfirmReminderArgs args;

  const ConfirmReminderPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final meds = args.medicines;
    final schedule = args.schedule;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 34.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.w,
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
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

            // You’re setting reminders for
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
                    final img = m.imageUrls[0];
                    return Row(
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
                          child: Image.network(img, fit: BoxFit.contain),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    m.brandName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.semiBold14.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    m.genericName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.reqular12.copyWith(
                                      color: AppColors.neutralDark,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 65.w,
                                height: 80.w,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 16.h,
                                ),
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
                    );
                  }),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Schedule Overview
            MainFrame(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Schedule Overview',
                    style: AppTextStyles.semiBold14.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  _OverviewRow(
                    title: 'Time',
                    value: schedule.times.isEmpty
                        ? '-'
                        : 'Starts at: ${schedule.times.first}',
                    sub: 'Repeats: Automatically adjusted',
                    icon: Icons.access_time,
                  ),
                  SizedBox(height: 10.h),

                  _OverviewRow(
                    title: 'Days',
                    value: schedule.days.isEmpty
                        ? '-'
                        : 'Starts on: ${schedule.days.first}',
                    sub: 'Repeats: Automatically adjusted',
                    icon: Icons.calendar_today_outlined,
                  ),
                  SizedBox(height: 10.h),

                  _OverviewRow(
                    title: 'Frequency',
                    value: 'Schedule: ${schedule.frequency}',
                    sub: 'Repeats daily',
                    icon: Icons.repeat,
                  ),
                  SizedBox(height: 14.h),
                ],
              ),
            ),

            const Spacer(),

            // Buttons
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
                onPressed: () async {
                  final res = await context.push(
                    AppRoutes.reminderSet,
                    extra: args,
                  );

                  if (res is List<ReminderItem>) {
                    context.pop(res); //
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm Reminder',
                      style: AppTextStyles.semiBold14.copyWith(
                        color: Colors.white,
                      ),
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

            SizedBox(height: 10.h),

            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryNormal, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  'Edit',
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.primaryNormal,
                  ),
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

class _OverviewRow extends StatelessWidget {
  final String title;
  final String value;
  final String sub;
  final IconData icon;

  const _OverviewRow({
    required this.title,
    required this.value,
    required this.sub,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 12.w,
              height: 12.w,
              child: SvgPicture.asset(
                "assets/icons/time.svg",
                color: AppColors.primaryNormal,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.medium12.copyWith(
                  color: AppColors.primaryDarker,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 329.w,
          child: MainFrame(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: AppTextStyles.medium14.copyWith(color: Colors.black),
                ),
                SizedBox(height: 6.h),
                Text(
                  sub,
                  style: AppTextStyles.reqular10.copyWith(
                    color: AppColors.primaryDarkActive,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
