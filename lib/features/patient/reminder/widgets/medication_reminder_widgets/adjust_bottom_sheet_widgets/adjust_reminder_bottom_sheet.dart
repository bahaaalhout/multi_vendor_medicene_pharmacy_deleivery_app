import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/time_formatters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/adjust_bottom_sheet_widgets/add_chip.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/adjust_bottom_sheet_widgets/bottom_sheet_handle.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/adjust_bottom_sheet_widgets/selectable_chip.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/main_frame.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_panel_widgets/selected_medication_info_row.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_panel_widgets/selected_medication_panel.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/schedule_calculator.dart';

class AdjustReminderBottomSheet extends StatefulWidget {
  final List<MedicineModel> selected;

  final String title;
  final String subtitle;

  final List<String> times;
  final List<String> days; // ✅ expects short codes: Sun/Mon/...
  final String frequency;

  final bool sameSchedule;

  final bool showRemoveInSelectedCard;
  final bool showDaysInSelectedCard;

  const AdjustReminderBottomSheet({
    super.key,
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.times,
    required this.days,
    required this.frequency,
    required this.sameSchedule,
    this.showRemoveInSelectedCard = true,
    this.showDaysInSelectedCard = true,
  });

  @override
  State<AdjustReminderBottomSheet> createState() =>
      _AdjustReminderBottomSheetState();
}

class _AdjustReminderBottomSheetState extends State<AdjustReminderBottomSheet> {
  late List<String> _times;
  late Set<String> _days;

  // 1 = Once daily, 2 = Twice daily, etc.
  int _frequencyCount = 1;

  static const _allDays = <String>['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  void initState() {
    super.initState();

    _times = List<String>.from(widget.times);
    _days = widget.days.toSet();

    if (_times.isEmpty) _times = ['8:00 AM'];
    if (_days.isEmpty) _days = {'Sun'};

    // Auto-detect frequency from initial times length
    if (_times.length > 1) _frequencyCount = _times.length;
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.selected.length;
    final isMulti = count > 1;
    final showDaysInTopCards = isMulti ? false : widget.showDaysInSelectedCard;
    final freqText = _calcFrequency(_days);

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
            SizedBox(height: 16.h),

            MainFrame(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 16.h,
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: Text(
                      'Selected medication',
                      style: AppTextStyles.medium12.copyWith(
                        color: AppColors.neutralDarker,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  if (count == 1)
                    _selectedMedicationPanel(
                      med: widget.selected.first,
                      times: _times, // ✅ use current state
                      days: _days.toList(),
                      showDays: showDaysInTopCards,
                    )
                  else
                    _selectedMedicationsList(
                      meds: widget.selected,
                      times: _times,
                      days: _days.toList(),
                      showDays: showDaysInTopCards,
                    ),

                  SizedBox(height: 14.h),

                  MainFrame(
                    color: AppColors.secondaryLight,
                    child: Container(
                      color: AppColors.secondaryLight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "• Pick your preferred start time, and the app will set the rest automatically",
                            style: AppTextStyles.medium12.copyWith(
                              color: AppColors.secondaryDarker,
                            ),
                          ),
                          SizedBox(height: 20.h),

                          // Frequency
                          Row(
                            children: [
                              SelectedMedicationInfoRow(
                                label: "New Freq.",
                                iconPath: "assets/icons/alarm_icon.svg",
                                chips: const [],
                              ),
                              SizedBox(width: 20.w),
                              _buildFrequencyDropdown(),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // Time / Start Time
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SelectedMedicationInfoRow(
                                label: _frequencyCount <= 1
                                    ? "New Time"
                                    : "Start Time",
                                iconPath: "assets/icons/alarm_icon.svg",
                                chips: const [],
                              ),
                              SizedBox(width: 8.w),

                              if (_frequencyCount > 1)
                                _buildStartTimePicker()
                              else
                                Expanded(
                                  child: AddChip(
                                    onTap: _addTime,
                                    label: _times.first,
                                    iconPath: "assets/icons/select_icon.svg",
                                  ),
                                ),
                            ],
                          ),

                          if (_frequencyCount > 1 && _times.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 12.h, left: 4.w),
                              child: Text(
                                "Schedule: ${_times.join(", ")}",
                                style: AppTextStyles.medium12.copyWith(
                                  color: AppColors.primaryDarkActive,
                                ),
                              ),
                            ),

                          SizedBox(height: 14.h),

                          // Days
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SelectedMedicationInfoRow(
                                label: "New Days",
                                iconPath: "assets/icons/alarm_icon.svg",
                                chips: const [],
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Wrap(
                                  spacing: 2.5.w,
                                  children: _allDays.map((d) {
                                    final selected = _days.contains(d);
                                    return SelectableChip(
                                      text: d, // Sun/Mon...
                                      selected: selected,
                                      onTap: () => _toggleDay(d),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 18.h),

                          // Adjust Button
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
                                    frequency: freqText,
                                  );
                                  Navigator.pop(context, result);
                                },
                                borderRadius: BorderRadius.circular(14.r),
                                child: Center(
                                  child: Text(
                                    "Adjust",
                                    style: AppTextStyles.semiBold14.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 12.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequencyDropdown() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.neutralLightActive),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: _frequencyCount,
                isDense: true,
                borderRadius: BorderRadius.circular(8.w),
                style: AppTextStyles.medium12.copyWith(
                  color: AppColors.neutralDarker,
                ),
                icon: SvgPicture.asset("assets/icons/select_icon.svg"),
                items: const [
                  DropdownMenuItem(
                    value: 1,
                    alignment: AlignmentGeometry.center,
                    child: Text("Once daily"),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    alignment: AlignmentGeometry.center,
                    child: Text("Twice daily"),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    alignment: AlignmentGeometry.center,
                    child: Text("3 times daily"),
                  ),
                ],
                onChanged: (val) {
                  if (val == null) return;

                  setState(() {
                    _frequencyCount = val;

                    if (_frequencyCount > 1) {
                      final startStr = _times.isNotEmpty
                          ? _times.first
                          : "8:00 AM";
                      _times = [startStr];
                      _recalcTimes();
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartTimePicker() {
    final startTimeText = _times.isNotEmpty ? _times.first : "8:00 AM";

    return InkWell(
      onTap: () async {
        final picked = await pickTime(context);
        if (picked == null) return;

        final formatted = formatTime(picked);

        setState(() {
          _times = [formatted];
          _recalcTimes();
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.neutralLightActive),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              startTimeText,
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.primaryNormal,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.edit, size: 14.sp, color: AppColors.neutralDark),
          ],
        ),
      ),
    );
  }

  void _recalcTimes() {
    if (_frequencyCount <= 1) return;

    final startStr = _times.isNotEmpty ? _times.first : "8:00 AM";
    final startTime = _parseTime(startStr);

    final newTimes = ScheduleCalculator.calculateTimes(
      startTime: startTime,
      frequency: _frequencyCount,
    );

    _times = newTimes;
  }

  TimeOfDay _parseTime(String s) {
    try {
      final cleaned = s.toLowerCase().replaceAll(' ', '');
      final isPm = cleaned.endsWith('pm');
      final isAm = cleaned.endsWith('am');

      final timePart = cleaned.replaceAll('am', '').replaceAll('pm', '');
      final parts = timePart.split(':');

      var hour = int.parse(parts[0]);
      final minute = int.parse(parts.length > 1 ? parts[1] : '0');

      if (isPm && hour != 12) hour += 12;
      if (isAm && hour == 12) hour = 0;

      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return const TimeOfDay(hour: 8, minute: 0);
    }
  }

  String _calcFrequency(Set<String> days) {
    return (days.length == 7) ? 'Daily' : 'Weekly';
  }

  Future<void> _addTime() async {
    final picked = await pickTime(context);
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
      if (_times.isEmpty) _times = ['8:00 AM'];
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

  Widget _selectedMedicationPanel({
    required MedicineModel med,
    required List<String> times,
    required List<String> days,
    required bool showDays,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: SelectedMedicationPanel(
        medicine: med,
        times: times,
        days: days,
        frequency: '',
        frequencyHint: '',
        color: AppColors.neutralLight,
        borderColor: AppColors.neutralLightActive,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
        onRemove: () {},
        onAdjust: () {},
        compact: false,
        disableAdjust: true,
        showFrequency: false,
        showRemove: widget.showRemoveInSelectedCard,
        showDays: showDays,
      ),
    );
  }

  Widget _selectedMedicationsList({
    required List<MedicineModel> meds,
    required List<String> times,
    required List<String> days,
    required bool showDays,
  }) {
    return Column(
      children: meds
          .map(
            (m) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: _selectedMedicationPanel(
                med: m,
                times: times,
                days: days,
                showDays: showDays,
              ),
            ),
          )
          .toList(),
    );
  }
}

Future<TimeOfDay?> pickTime(BuildContext context) {
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      final base = Theme.of(context);

      const primary = AppColors.secondaryNormalHover;
      const surface = Colors.white;
      const onSurface = Color(0xFF1B1B1B);
      const dialBg = Color(0xFFF3F6FF);
      const muted = Color(0xFF8A93A3);

      return Theme(
        data: base.copyWith(
          brightness: Brightness.light,
          useMaterial3: true,
          colorScheme: base.colorScheme.copyWith(
            brightness: Brightness.light,
            primary: primary,
            onPrimary: Colors.white,
            surface: surface,
            onSurface: onSurface,
          ),
          timePickerTheme: const TimePickerThemeData(
            backgroundColor: surface,
            dialBackgroundColor: dialBg,
            dialTextColor: onSurface,
            dialHandColor: primary,
            hourMinuteColor: dialBg,
            hourMinuteTextColor: onSurface,
            dayPeriodColor: dialBg,
            dayPeriodTextColor: onSurface,
            helpTextStyle: TextStyle(color: muted, fontWeight: FontWeight.w600),
            cancelButtonStyle: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(muted),
            ),
            confirmButtonStyle: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(primary),
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}
