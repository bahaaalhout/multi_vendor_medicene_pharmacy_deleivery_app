import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/medication_actions.dart'
    as act;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/cubit/reminder_cubit.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_schedule.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/confirm_reminder_args.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/reminder_item.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/main_frame.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_header_section.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_list_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_reminder_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_section_widgets/selected_medication_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/routes/app_routes.dart';

class MedicationReminderPage extends StatefulWidget {
  const MedicationReminderPage({super.key});

  @override
  State<MedicationReminderPage> createState() => _MedicationReminderPageState();
}

class _MedicationReminderPageState extends State<MedicationReminderPage> {
  MedicationReminderTab tab = MedicationReminderTab.prescriptions;

  final Set<String> selectedMedicineIds = {};
  final Map<String, AdjustedScheduleResult> singleOverrides = {};
  AdjustedScheduleResult? multiOverride;

  // ===== Inline Banner State =====
  String? _inlineMsg;
  bool _inlineError = true;
  bool _showInline = false;

  void _showInlineMessage(String text, {bool isError = true}) {
    setState(() {
      _inlineMsg = text;
      _inlineError = isError;
      _showInline = true;
    });

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      setState(() => _showInline = false);
    });
  }

  Widget _inlineBanner() {
    final bg = _inlineError ? const Color(0xFFFFF3F3) : const Color(0xFFF2FFF6);
    final border = _inlineError
        ? AppColors.errorLight
        : const Color(0xFFB7E4C7);
    final iconBg = _inlineError
        ? const Color(0xFFFFE1E1)
        : const Color(0xFFDFF7E7);
    final iconColor = _inlineError
        ? AppColors.errorDarker
        : const Color(0xFF1B7F3A);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child: (!_showInline || _inlineMsg == null)
          ? const SizedBox.shrink()
          : Container(
              key: const ValueKey('inlineBanner'),
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: border, width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: BoxDecoration(
                      color: iconBg,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Icon(
                      Icons.info_outline,
                      size: 18.sp,
                      color: iconColor,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      _inlineMsg!,
                      style: AppTextStyles.reqular12.copyWith(height: 1.35),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prescriptionMedicines = medicineData
        .where((m) => m.requiresPrescription)
        .toList();

    final recentOrderMedicines = medicineData
        .where((m) => !m.requiresPrescription)
        .toList();

    final items = act.getItemsByTab(
      tab: tab,
      prescriptions: prescriptionMedicines,
      recents: recentOrderMedicines,
    );

    final selectedMedicines = act.getSelectedMeds(
      selectedIds: selectedMedicineIds,
      listA: prescriptionMedicines,
      listB: recentOrderMedicines,
    );

    final scheduleInfo = getScheduleForMedicines(
      medicines: selectedMedicines,
      reminders: reminders,
    );

    final effectiveSchedule = resolveEffectiveSchedule(
      selectedIds: selectedMedicineIds,
      singleOverrides: singleOverrides,
      multiOverride: multiOverride,
      allMedicines: [...prescriptionMedicines, ...recentOrderMedicines],
      reminders: reminders,
    );

    final scheduleToUse =
        (effectiveSchedule.times.isEmpty ||
            effectiveSchedule.days.isEmpty ||
            effectiveSchedule.frequency.isEmpty)
        ? _defaultSchedule()
        : AdjustedScheduleResult(
            times: effectiveSchedule.times,
            days: effectiveSchedule.days,
            frequency: effectiveSchedule.frequency,
          );

    final effectiveTimes = scheduleToUse.times;
    final effectiveDays = scheduleToUse.days;
    final effectiveFreq = scheduleToUse.frequency;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 34.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: SvgPicture.asset("assets/icons/back.svg"),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Mediciation Reminder',
                  style: AppTextStyles.bold22.copyWith(
                    height: 1.5,
                    color: AppColors.primaryDarker,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            MainFrame(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MedicationHeaderSection(),
                  SizedBox(height: 25.h),

                  MedicationReminderTabs(
                    selected: tab,
                    prescriptionsCount: prescriptionMedicines.length,
                    onChanged: (v) => act.changeTab(
                      setState: setState,
                      setTab: (x) => tab = x,
                      newTab: v,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  MedicationListSection(
                    items: items,
                    selectedIds: selectedMedicineIds,
                    reminders: reminders,
                    onToggleSelect: (id) => act.toggleSelect(
                      setState: setState,
                      selectedIds: selectedMedicineIds,
                      id: id,
                    ),
                    onSetReminder: (m) {
                      act.addToSelected(
                        setState: setState,
                        selectedIds: selectedMedicineIds,
                        medicine: m,
                      );
                    },
                  ),

                  SizedBox(height: 16.h),
                ],
              ),
            ),

            if (selectedMedicines.isNotEmpty) ...[
              SizedBox(height: 16.h),
              SelectedMedicationsSection(
                medicines: selectedMedicines,
                sameSchedule:
                    multiOverride != null || scheduleInfo.sameSchedule,
                groupTimes: effectiveTimes,
                groupDays: effectiveDays,
                groupFrequency: effectiveFreq,
                singleOverrides: singleOverrides,

                onRemoveMedicine: (id) => act.removeMedicineWithOverrides(
                  setState: setState,
                  selectedIds: selectedMedicineIds,
                  singleOverrides: singleOverrides,
                  multiOverride: multiOverride,
                  setMultiOverride: (v) => multiOverride = v,
                  id: id,
                ),

                onClearAll: () => act.clearAllWithOverrides(
                  setState: setState,
                  selectedIds: selectedMedicineIds,
                  singleOverrides: singleOverrides,
                  setMultiOverride: (v) => multiOverride = v,
                ),

                onCreateReminders: (meds) async {
                  if (meds.isEmpty) return;

                  final schedule = AdjustedScheduleResult(
                    times: effectiveTimes,
                    days: effectiveDays,
                    frequency: effectiveFreq,
                  );

                  final duplicate = _hasDuplicateInCurrentList(
                    medicines: meds,
                    schedule: schedule,
                    existing: reminders.cast<ReminderItem>(),
                  );

                  if (duplicate) {
                    // Show confirmation dialog to replace
                    final replace = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Reminder Already Exists"),
                        content: const Text(
                            "A reminder for this medication already exists.\nDo you want to replace it with the new schedule?"),
                        actions: [
                          TextButton(
                            onPressed: () => ctx.pop(false),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () => ctx.pop(true),
                            child: const Text("Replace"),
                          ),
                        ],
                      ),
                    );

                    if (replace != true) return;
                  }

                  final args = ConfirmReminderArgs(
                    medicines: meds,
                    schedule: schedule,
                  );

                  final res = await context.push(
                    AppRoutes.confirmReminder,
                    extra: args,
                  );

                  if (!context.mounted) return;

                  if (res is List<ReminderItem>) {
                    if (duplicate) {
                      // If we are replacing, delete OLD reminders first
                      // We can use the cubit to delete based on medicine IDs
                      if (context.mounted) {
                         context.read<ReminderCubit>().deleteRemindersForMedicines(
                             meds,
                             currentDate: DateTime.now(),
                           );
                      }
                    }
                    if (context.mounted) {
                      context.pop(res);
                    }
                  }
                },

                onAdjustSingle: (med) => _openAdjustSheetSingle(med),
                onAdjustMulti: (meds) => _handleAdjustMulti(meds),

                footer: _inlineBanner(),
              ),
              SizedBox(height: 24.h),
            ],
          ],
        ),
      ),
    );
  }

  bool _hasDuplicateInCurrentList({
    required List<MedicineModel> medicines,
    required AdjustedScheduleResult schedule,
    required List<ReminderItem> existing,
  }) {
    for (final med in medicines) {
      for (final t in schedule.times) {
        final newTime = _parseToMinutes(t);

        final found = existing.any((r) {
          if (r.medicine.id != med.id) return false;
          final oldTime = (r.time.hour * 60) + r.time.minute;
          return oldTime == newTime;
        });

        if (found) return true;
      }
    }
    return false;
  }

  int _parseToMinutes(String timeText) {
    final cleaned = timeText.toLowerCase().replaceAll(' ', '');
    final isPm = cleaned.endsWith('pm');
    final isAm = cleaned.endsWith('am');

    final timePart = cleaned.replaceAll('am', '').replaceAll('pm', '');
    final parts = timePart.split(':');

    var hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0;

    if (isPm && hour != 12) hour += 12;
    if (isAm && hour == 12) hour = 0;

    return (hour * 60) + minute;
  }

  Future<void> _openAdjustSheetSingle(MedicineModel med) async {
    final schedule = getScheduleForMedicines(
      medicines: [med],
      reminders: reminders,
    );

    final fallback = _defaultSchedule();

    final times = schedule.times.isEmpty ? fallback.times : schedule.times;
    final days = schedule.days.isEmpty ? fallback.days : schedule.days;
    final freq = schedule.frequency.isEmpty
        ? fallback.frequency
        : schedule.frequency;

    final result = await act.openAdjustBottomSheet(
      context: context,
      selected: [med],
      title: 'Adjust reminder time',
      subtitle: 'Modify reminder times before confirming',
      sameSchedule: true,
      times: times,
      days: days,
      frequency: freq,
      showRemoveInSelectedCard: false,
    );

    if (result == null) return;

    setState(() {
      singleOverrides[med.id] = result;
    });
  }

  Future<void> _handleAdjustMulti(List<MedicineModel> meds) async {
    final schedule = getScheduleForMedicines(
      medicines: meds,
      reminders: reminders,
    );

    if (!schedule.sameSchedule) {
      act.showToast(
        context,
        'These medications have different schedules.\nCreate a separate reminder for each medication.',
      );
      return;
    }

    final fallback = _defaultSchedule();

    final times = (multiOverride?.times.isNotEmpty ?? false)
        ? multiOverride!.times
        : (schedule.times.isEmpty ? fallback.times : schedule.times);

    final days = (multiOverride?.days.isNotEmpty ?? false)
        ? multiOverride!.days
        : (schedule.days.isEmpty ? fallback.days : schedule.days);

    final freq = (multiOverride?.frequency.isNotEmpty ?? false)
        ? multiOverride!.frequency
        : (schedule.frequency.isEmpty
              ? fallback.frequency
              : schedule.frequency);

    final result = await act.openAdjustBottomSheet(
      context: context,
      selected: meds,
      title: 'Adjust reminder time',
      subtitle: 'Modify reminder times for ${meds.length} medications',
      sameSchedule: true,
      times: times,
      days: days,
      frequency: freq,
      showRemoveInSelectedCard: false,
      showDaysInSelectedCard: false,
    );

    if (result == null) return;

    setState(() {
      multiOverride = result;
    });
  }

  AdjustedScheduleResult _defaultSchedule() {
    return const AdjustedScheduleResult(
      times: ['8:00 AM'],
      days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      frequency: 'Daily',
    );
  }
}
