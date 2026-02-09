import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/time_formatters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/adjust_bottom_sheet_widgets/add_chip.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/adjust_bottom_sheet_widgets/bottom_sheet_handle.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/adjust_bottom_sheet_widgets/info_chip.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/adjust_bottom_sheet_widgets/removable_chip.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/adjust_bottom_sheet_widgets/section_label.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/adjust_bottom_sheet_widgets/selectable_chip.dart';

class AdjustReminderBottomSheet extends StatefulWidget {
  final List<MedicineModel> selected;

  final String title;
  final String subtitle;

  final List<String> times; // initial
  final List<String> days; // initial
  final String frequency; // initial

  final bool sameSchedule;

  final String primaryButtonText;

  const AdjustReminderBottomSheet({
    super.key,
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.times,
    required this.days,
    required this.frequency,
    required this.primaryButtonText,
    required this.sameSchedule,
  });

  @override
  State<AdjustReminderBottomSheet> createState() =>
      _AdjustReminderBottomSheetState();
}

class _AdjustReminderBottomSheetState extends State<AdjustReminderBottomSheet> {
  late List<String> _times;
  late Set<String> _days;

  static const _allDays = <String>[
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  void initState() {
    super.initState();
    _times = List<String>.from(widget.times);
    _days = widget.days.toSet();

    if (_times.isEmpty) _times = ['8:00am'];
    if (_days.isEmpty) _days = {'Sunday'};
  }

  String _calcFrequency(Set<String> days) {
    return (days.length == 7) ? 'Daily' : 'Weekly';
  }

  Future<void> _addTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) return;

    final formatted = formatTime(picked);

    setState(() {
      if (!_times.contains(formatted)) {
        _times.add(formatted);
        _times.sort(compareTimeStrings);
      }
    });
  }

  void _removeTime(String t) {
    setState(() {
      _times.remove(t);
      if (_times.isEmpty) {
        _times = ['8:00am'];
      }
    });
  }

  void _toggleDay(String d) {
    setState(() {
      if (_days.contains(d)) {
        if (_days.length > 1) _days.remove(d);
      } else {
        _days.add(d);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.selected.length;
    final freq = _calcFrequency(_days);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 12.h,
          bottom: 16.h + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetHandle(),

            Text(
              widget.title,
              style: AppTextStyles.semiBold16.copyWith(color: Colors.black),
            ),
            SizedBox(height: 6.h),
            Text(
              widget.subtitle,
              style: AppTextStyles.reqular12.copyWith(
                color: AppColors.neutralDark,
              ),
            ),

            SizedBox(height: 14.h),

            Text(
              count == 1
                  ? widget.selected.first.brandName
                  : '$count Medications selected',
              style: AppTextStyles.medium12.copyWith(
                color: AppColors.neutralDarker,
              ),
            ),

            SizedBox(height: 14.h),

            const SectionLabel(title: 'New Time'),
            SizedBox(height: 8.h),

            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                ..._times.map(
                  (t) => RemovableChip(text: t, onRemove: () => _removeTime(t)),
                ),
                AddChip(onTap: _addTime),
              ],
            ),

            SizedBox(height: 14.h),

            const SectionLabel(title: 'New Days'),
            SizedBox(height: 8.h),

            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _allDays.map((d) {
                final selected = _days.contains(d);
                return SelectableChip(
                  text: d.substring(0, 3), // Sun/Mon...
                  selected: selected,
                  onTap: () => _toggleDay(d),
                );
              }).toList(),
            ),

            SizedBox(height: 14.h),

            const SectionLabel(title: 'Frequency'),
            SizedBox(height: 8.h),
            InfoChip(text: freq),

            SizedBox(height: 18.h),

            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: Material(
                color: AppColors.primaryNormal,
                borderRadius: BorderRadius.circular(14.r),
                child: InkWell(
                  onTap: () {
                    final result = AdjustedScheduleResult(
                      times: List<String>.from(_times),
                      days: _days.toList(),
                      frequency: freq,
                    );
                    Navigator.pop(context, result);
                  },
                  borderRadius: BorderRadius.circular(14.r),
                  child: Center(
                    child: Text(
                      widget.primaryButtonText,
                      style: AppTextStyles.semiBold14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            Center(
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.semiBold12.copyWith(
                      color: AppColors.primaryNormal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
