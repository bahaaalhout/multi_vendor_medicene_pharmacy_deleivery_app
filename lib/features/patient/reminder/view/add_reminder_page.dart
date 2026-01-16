import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/reminder_date_label.dart';
import '../widgets/reminder_app_bar.dart';
import '../widgets/reminder_date_selector.dart';
import '../widgets/reminder_day_strip.dart';
import '../widgets/reminder_list_item.dart';

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({super.key});

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  //1
  DateTime selectedDate = DateTime(2025, 12, 17);
  //
  @override
  Widget build(BuildContext context) {
    //2
    final days = [
      DayItem(weekLetter: 'S', dayNumber: 16),
      DayItem(weekLetter: 'M', dayNumber: 17),
      DayItem(weekLetter: 'T', dayNumber: 18),
      DayItem(weekLetter: 'W', dayNumber: 19),
      DayItem(weekLetter: 'T', dayNumber: 20),
      DayItem(weekLetter: 'F', dayNumber: 21),
      DayItem(weekLetter: 'S', dayNumber: 22),
    ];
    //
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: ReminderAppBar(onBack: () {}, onMore: () {}),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReminderDateSelector(
              dateWidget: ReminderDateLabel(date: selectedDate),
              onPrev: prevDay,
              onNext: nextDay,
            ),

            SizedBox(height: 12.h),

            ReminderDayStrip(
              days: days,
              selectedDay: selectedDate.day,
              onSelectDay: (d) {
                setState(() {
                  selectedDate = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    d,
                  );
                });
              },
            ),

            SizedBox(height: 16.h),

            Row(
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
                  '${reminders.length} Reminders',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primaryNormal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 48 + 80.h),
                itemCount: reminders.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, i) {
                  final item = reminders[i];
                  return ReminderListItem(item: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void prevDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
  }

  void nextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
  }
}
