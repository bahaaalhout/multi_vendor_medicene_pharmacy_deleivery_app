import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/medication_reminder_actions.dart'
    as act;

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_schedule_helper.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/main_frame.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_header_section.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/adjust_reminder_bottom_sheet.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_list_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_reminder_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/models/adjusted_schedule_result.dart';

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

  @override
  Widget build(BuildContext context) {
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

    final schedule = getScheduleForMedicines(
      medicines: selectedMedicines,
      reminders: reminders,
    );
    final effectiveTimes = multiOverride?.times ?? schedule.times;
    final effectiveDays = multiOverride?.days ?? schedule.days;
    final effectiveFreq = multiOverride?.frequency ?? schedule.frequency;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppPrimaryAppBar(
        title: 'Medication Reminder',
        showBack: true,
        showAction: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
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
                      act.showToast(context, 'Added: ${m.brandName}');
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
                sameSchedule: schedule.sameSchedule,
                groupTimes: effectiveTimes,
                groupDays: effectiveDays,
                groupFrequency: effectiveFreq,

                singleOverrides: singleOverrides,
                onRemoveMedicine: (id) => act.removeSelected(
                  setState: setState,
                  selectedIds: selectedMedicineIds,
                  id: id,
                ),

                onClearAll: () => act.clearAllSelected(
                  setState: setState,
                  selectedIds: selectedMedicineIds,
                ),

                onCreateReminders: (meds) => act.showToast(
                  context,
                  'Created ${meds.length} reminder(s)',
                ),

                onAdjustSingle: (med) => _openAdjustSheetSingle(med),

                onAdjustMulti: (meds) => _handleAdjustMulti(meds),
              ),

              SizedBox(height: 24.h),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _openAdjustSheetSingle(MedicineModel med) async {
    final schedule = getScheduleForMedicines(
      medicines: [med],
      reminders: reminders,
    );

    final result = await showModalBottomSheet<AdjustedScheduleResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => AdjustReminderBottomSheet(
        selected: [med],
        title: 'Adjust reminder time',
        subtitle: 'Modify reminder times before confirming',
        sameSchedule: true,
        times: schedule.times,
        days: schedule.days,
        frequency: schedule.frequency,
        primaryButtonText: 'Adjust',
      ),
    );

    if (result == null) return;

    setState(() {
      singleOverrides[med.id] = result;
    });

    act.showToast(context, 'Adjusted for ${med.brandName}');
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

    final result = await showModalBottomSheet<AdjustedScheduleResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => AdjustReminderBottomSheet(
        selected: meds,
        sameSchedule: true,
        title: 'Adjust reminder time',
        subtitle: 'Modify reminder times for ${meds.length} medications',
        times: multiOverride?.times ?? schedule.times,
        days: multiOverride?.days ?? schedule.days,
        frequency: multiOverride?.frequency ?? schedule.frequency,
        primaryButtonText: 'Continue creating',
      ),
    );

    if (result == null) return;

    setState(() {
      multiOverride = result;
    });

    act.showToast(context, 'Adjusted for ${meds.length} medications');
  }
}
