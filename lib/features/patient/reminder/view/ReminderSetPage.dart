import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/date_time_utils.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/confirm_reminder_args.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/main_frame.dart';

class ReminderSetPage extends StatelessWidget {
  final ConfirmReminderArgs args;

  const ReminderSetPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final med = args.medicines.isNotEmpty ? args.medicines.first : null;
    final img = (med != null && med.imageUrls.isNotEmpty)
        ? med.imageUrls.first
        : null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              // top back
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

              // big check
              Container(
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

              // Medication card
              if (med != null)
                MainFrame(
                  padding: EdgeInsets.all(14.w),

                  child: Row(
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.w,
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: img == null
                            ? const Icon(Icons.medication_outlined)
                            : Image.network(img, fit: BoxFit.contain),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              med.brandName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.semiBold16.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '''${args.schedule.times.length} times ${args.schedule.frequency} · Until Mar 12'''
                              '''First reminder at ${args.schedule.times.isNotEmpty ? args.schedule.times.first : '-'}''',
                              style: AppTextStyles.reqular12.copyWith(
                                color: AppColors.primaryDarkActive,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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

                    final daysIdx = args.schedule.days.map(dayToIndex).toList();

                    final newItems = <ReminderItem>[];

                    for (final med in args.medicines) {
                      for (final t in args.schedule.times) {
                        newItems.add(
                          ReminderItem(
                            id: '${med.id}_${t}_${now.millisecondsSinceEpoch}',
                            medicine: med,
                            time: parseTime(t),
                            dose: 1,
                            startDate: now,
                            endDate: now.add(const Duration(days: 30)),
                            days: daysIdx,
                          ),
                        );
                      }
                    }

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

              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
