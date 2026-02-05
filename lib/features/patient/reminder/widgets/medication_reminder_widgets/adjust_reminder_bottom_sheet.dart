import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';

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

    // لو فاضيين، خليه default منطقي بدل ما يطلع "--"
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

    final formatted = _formatTime(picked);

    setState(() {
      if (!_times.contains(formatted)) {
        _times.add(formatted);
        _times.sort(_compareTimeStrings);
      }
    });
  }

  void _removeTime(String t) {
    setState(() {
      _times.remove(t);
      if (_times.isEmpty) {
        _times = ['8:00am']; // ما نخليه فاضي
      }
    });
  }

  void _toggleDay(String d) {
    setState(() {
      if (_days.contains(d)) {
        // ما نخليها تصير فاضية
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
            _TopHandle(),

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

            //====================
            // TIME (Editable)
            //====================
            const _SectionLabel(title: 'New Time'),
            SizedBox(height: 8.h),

            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                ..._times.map(
                  (t) =>
                      _RemovableChip(text: t, onRemove: () => _removeTime(t)),
                ),
                _AddChip(onTap: _addTime),
              ],
            ),

            SizedBox(height: 14.h),

            //====================
            // DAYS (Editable)
            //====================
            const _SectionLabel(title: 'New Days'),
            SizedBox(height: 8.h),

            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _allDays.map((d) {
                final selected = _days.contains(d);
                return _SelectableChip(
                  text: d.substring(0, 3), // Sun/Mon...
                  selected: selected,
                  onTap: () => _toggleDay(d),
                );
              }).toList(),
            ),

            SizedBox(height: 14.h),

            //====================
            // Frequency
            //====================
            const _SectionLabel(title: 'Frequency'),
            SizedBox(height: 8.h),
            _Chip(text: freq),

            SizedBox(height: 18.h),

            //====================
            // SAVE (Return result)
            //====================
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

//====================
// UI helpers
//====================
class _TopHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 44.w,
        height: 4.h,
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.neutralLightActive,
          borderRadius: BorderRadius.circular(999.r),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String title;
  const _SectionLabel({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.medium12.copyWith(
        color: AppColors.neutralDarkActive,
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  const _Chip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.neutralLightActive),
      ),
      child: Text(
        text,
        style: AppTextStyles.medium10.copyWith(
          color: AppColors.secondaryDarker,
        ),
      ),
    );
  }
}

class _AddChip extends StatelessWidget {
  final VoidCallback onTap;
  const _AddChip({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.neutralLightActive),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 16.w, color: AppColors.primaryNormal),
            SizedBox(width: 6.w),
            Text(
              'Add',
              style: AppTextStyles.medium10.copyWith(
                color: AppColors.primaryNormal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RemovableChip extends StatelessWidget {
  final String text;
  final VoidCallback onRemove;
  const _RemovableChip({required this.text, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.neutralLightActive),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: AppTextStyles.medium10.copyWith(
              color: AppColors.secondaryDarker,
            ),
          ),
          SizedBox(width: 6.w),
          InkWell(
            onTap: onRemove,
            child: Icon(Icons.close, size: 14.w, color: AppColors.neutralDark),
          ),
        ],
      ),
    );
  }
}

class _SelectableChip extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _SelectableChip({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryNormal : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.neutralLightActive),
        ),
        child: Text(
          text,
          style: AppTextStyles.medium10.copyWith(
            color: selected ? Colors.white : AppColors.secondaryDarker,
          ),
        ),
      ),
    );
  }
}

//====================
// Time formatting + sorting
//====================
String _formatTime(TimeOfDay t) {
  final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
  final minute = t.minute.toString().padLeft(2, '0');
  final suffix = t.period == DayPeriod.am ? 'am' : 'pm';
  return '$hour:$minute$suffix';
}

int _compareTimeStrings(String a, String b) {
  int toMin(String s) {
    final lower = s.toLowerCase().trim(); // "8:15am"
    final isPm = lower.endsWith('pm');
    final timePart = lower.replaceAll('am', '').replaceAll('pm', '');
    final parts = timePart.split(':');
    var h = int.parse(parts[0]);
    final m = int.parse(parts[1]);

    if (h == 12) h = 0;
    var total = h * 60 + m;
    if (isPm) total += 12 * 60;
    return total;
  }

  return toMin(a).compareTo(toMin(b));
}
