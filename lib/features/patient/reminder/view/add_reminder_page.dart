import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_date_label.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_date_selector.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_filter.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/day_item.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';
import '../widgets/reminder_day_strip.dart';
import '../widgets/reminder_list_item.dart';

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({super.key});

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final days = buildDaysStrip(selectedDate);
    final dayReminders = filterRemindersByDate(reminders, selectedDate);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppPrimaryAppBar(
        title: 'Add Reminder',
        onBack: () {},
        onAction: () {},
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(days),
            SizedBox(height: 12.h),
            _buildList(dayReminders),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(List<DayItem> days) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppDateSelector(
          dateWidget: AppDateLabel(date: selectedDate),
          onPrev: _prevDay,
          onNext: _nextDay,
        ),
        SizedBox(height: 12.h),
        ReminderDayStrip(
          days: days,
          selectedDay: selectedDate.day,
          onSelectDay: _onSelectDay,
        ),
        SizedBox(height: 16.h),
        _buildTitle(),
      ],
    );
  }

  Widget _buildTitle() {
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
          '${filterRemindersByDate(reminders, selectedDate).length} Reminders',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.primaryNormal,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildList(List<ReminderItem> dayReminders) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 48 + 80.h),
        itemCount: dayReminders.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, i) {
          return ReminderListItem(item: dayReminders[i]);
        },
      ),
    );
  }

  void _prevDay() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _nextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
  }

  void _onSelectDay(int d) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month, d);
    });
  }
}
