import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/time_formatters.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/selected/bottomsheet/add_chip.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/selected/bottomsheet/bottom_sheet_handle.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/selected/bottomsheet/selectable_chip.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/shared_widgets/main_frame.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/selected/panel/selected_medication_info_row.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/selected/panel/selected_medication_panel.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/schedule_calculator.dart';

class AdjustReminderBottomSheet extends StatefulWidget {
  final List<MedicineModel> selected;

  final String title;
  final String subtitle;

  final List<String> times;
  final List<String> days;
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

  late List<String> _cardTimes;
  late List<String> _cardDays;
  late String _cardFrequency;
  late String _startTime;

  int _frequencyCount = 1;

  bool _applied = false;
  AdjustedScheduleResult? _appliedResult;

  static const List<String> _allDays3 = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  @override
  void initState() {
    super.initState();

    // Card schedule is the original schedule and should not change until Apply
    final incomingTimes = widget.times.isNotEmpty ? widget.times : ['8:00 AM'];
    final incomingDays = widget.days.isNotEmpty
        ? widget.days.map(_normalizeDay).toList()
        : List<String>.from(_allDays3);
    final incomingFreq = widget.frequency.isNotEmpty
        ? widget.frequency
        : 'Daily';

    _cardTimes = List<String>.from(incomingTimes);
    _cardDays = incomingDays;
    _cardFrequency = incomingFreq;

    // Editor always starts with only one start time
    final initialStart = _cardTimes.isNotEmpty ? _cardTimes.first : '8:00 AM';
    _times = [initialStart];

    _days = _cardDays.toSet();
    if (_days.isEmpty) _days = {'Sun'};

    // Frequency is detected from the old schedule length
    _frequencyCount = incomingTimes.isNotEmpty ? incomingTimes.length : 1;

    // Build full schedule preview for the editor
    if (_frequencyCount > 1) {
      _recalcTimes();
    }
    _startTime = initialStart;
    _times = [_startTime];
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

                  // Card uses original schedule until Apply is pressed
                  if (count == 1)
                    _selectedMedicationPanel(
                      med: widget.selected.first,
                      times: _cardTimes,
                      days: _cardDays,
                      showDays: showDaysInTopCards,
                    )
                  else
                    _selectedMedicationsList(
                      meds: widget.selected,
                      times: _cardTimes,
                      days: _cardDays,
                      showDays: showDaysInTopCards,
                    ),

                  SizedBox(height: 14.h),

                  MainFrame(
                    color: _applied ? Colors.white : AppColors.secondaryLight,
                    child: Container(
                      color: _applied ? Colors.white : AppColors.secondaryLight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!_applied)
                            Text(
                              "• Pick your preferred start time, and the app will set the rest automatically",
                              style: AppTextStyles.medium12.copyWith(
                                color: AppColors.secondaryDarker,
                              ),
                            ),
                          if (!_applied) SizedBox(height: 20.h),
                          if (!_applied) ...[
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
                          ],

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

                              if (_applied)
                                Expanded(
                                  child: Wrap(
                                    spacing: 2.w,
                                    runSpacing: 2.h,
                                    children: _times
                                        .map((t) => _plainChip(t))
                                        .toList(),
                                  ),
                                )
                              else
                                Expanded(child: _buildStartTimePicker()),
                            ],
                          ),

                          SizedBox(height: 14.h),

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
                                child: _applied
                                    ? Wrap(
                                        spacing: 2.w,
                                        runSpacing: 2.h,
                                        children: _buildAppliedDaysChips(),
                                      )
                                    : Wrap(
                                        spacing: 2.5.w,
                                        children: _allDays3.map((day3) {
                                          final selected = _days.contains(day3);
                                          return SelectableChip(
                                            text: day3.substring(0, 1),
                                            selected: selected,
                                            onTap: () => _toggleDay(day3),
                                          );
                                        }).toList(),
                                      ),
                              ),
                            ],
                          ),

                          SizedBox(height: 18.h),

                          SizedBox(
                            width: double.infinity,
                            height: 44.h,
                            child: Material(
                              color: _applied
                                  ? AppColors.successLight
                                  : AppColors.primaryNormal,
                              borderRadius: BorderRadius.circular(14.r),
                              child: InkWell(
                                onTap: _applied ? null : () => _apply(freqText),
                                borderRadius: BorderRadius.circular(14.r),
                                child: Center(
                                  child: Text(
                                    _applied ? "Adjusted" : "Adjust",
                                    style: AppTextStyles.semiBold14.copyWith(
                                      color: _applied
                                          ? AppColors.successDarker
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Continue button appears only after Apply
                          if (_applied) ...[
                            SizedBox(height: 12.h),
                            SizedBox(
                              width: double.infinity,
                              height: 52.h,
                              child: Material(
                                color: AppColors.primaryNormal,
                                borderRadius: BorderRadius.circular(16.r),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16.r),
                                  onTap: _continueCreating,
                                  child: Center(
                                    child: Text(
                                      "Continue creating",
                                      style: AppTextStyles.semiBold16.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],

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

  // Normalize day values to 3-letter format to prevent duplicates like Sun and S
  String _normalizeDay(String d) {
    final v = d.trim();
    if (_allDays3.contains(v)) return v;
    if (v == 'S') return 'Sun';
    if (v == 'M') return 'Mon';
    if (v == 'T') return 'Tue';
    if (v == 'W') return 'Wed';
    if (v == 'F') return 'Fri';
    return 'Sun';
  }

  Widget _buildFrequencyDropdown() {
    return Expanded(
      child: Container(
        height: 40.h,
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
                    // Any edit cancels the applied state
                    _applied = false;
                    _appliedResult = null;

                    _frequencyCount = val;

                    final startStr = _times.isNotEmpty
                        ? _times.first
                        : "8:00 AM";

                    _times = [startStr];

                    if (_frequencyCount > 1) {
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

  Widget _plainChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(8.r),
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

  List<Widget> _buildAppliedDaysChips() {
    final isDaily = _days.length == 7;

    if (isDaily) {
      // Keep one-letter display when all days are selected
      return _allDays3.map((d) => _plainChip(d.substring(0, 1))).toList();
    }

    // Show only selected days using 3-letter format
    final selectedSorted = _days.toList()
      ..sort((a, b) => _allDays3.indexOf(a).compareTo(_allDays3.indexOf(b)));

    return selectedSorted.map((d) => _plainChip(d)).toList();
  }

  Widget _buildStartTimePicker() {
    final startTimeText = _startTime;

    return InkWell(
      onTap: () async {
        final picked = await pickTime(context);
        if (picked == null) return;

        final formatted = formatTime(picked);

        setState(() {
          _applied = false;
          _appliedResult = null;

          _startTime = formatted;
          _times = [_startTime];

          if (_frequencyCount > 1) {
            _recalcTimes();
          }
        });
      },
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.neutralLightActive),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              startTimeText,
              style: AppTextStyles.medium12.copyWith(
                color: AppColors.neutralDarker,
              ),
            ),
            SizedBox(width: 6.w),
            SvgPicture.asset("assets/icons/select_icon.svg"),
          ],
        ),
      ),
    );
  }

  // Apply copies the edited schedule into the card schedule and enables Continue
  void _apply(String freqText) {
    final normalizedDays = _days.map(_normalizeDay).toSet().toList();
    normalizedDays.sort(
      (a, b) => _allDays3.indexOf(a).compareTo(_allDays3.indexOf(b)),
    );

    final result = AdjustedScheduleResult(
      times: List<String>.from(_times),
      days: normalizedDays,
      frequency: freqText,
    );

    setState(() {
      _applied = true;
      _appliedResult = result;

      _cardTimes = List<String>.from(result.times);
      _cardDays = List<String>.from(result.days);
      _cardFrequency = result.frequency;
    });
  }

  // Continue returns the applied schedule back to the page
  void _continueCreating() {
    if (_appliedResult == null) return;
    Navigator.pop(context, _appliedResult);
  }

  void _recalcTimes() {
    if (_frequencyCount <= 1) return;

    final startTime = _parseTime(_startTime);

    _times = ScheduleCalculator.calculateTimes(
      startTime: startTime,
      frequency: _frequencyCount,
    );
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

  void _toggleDay(String d) {
    setState(() {
      // Any edit cancels the applied state
      _applied = false;
      _appliedResult = null;

      final day3 = _normalizeDay(d);

      if (_days.contains(day3)) {
        if (_days.length > 1) _days.remove(day3);
      } else {
        _days.add(day3);
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
        frequency: _cardFrequency,
        frequencyHint: '',
        color: AppColors.neutralLight,
        borderColor: AppColors.neutralLightActive,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
        onRemove: () {},
        onAdjust: () {},
        compact: false,
        disableAdjust: true,
        showFrequency: true,
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
