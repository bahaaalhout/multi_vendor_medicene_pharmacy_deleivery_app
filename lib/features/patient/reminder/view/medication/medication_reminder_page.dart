import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/medication_actions.dart'
    as act;

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/reminder_schedule.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/main_frame.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_header_section.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_list_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_reminder_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_section_widgets/selected_medication_section.dart';
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

    final effectiveSchedule = resolveEffectiveSchedule(
      selectedIds: selectedMedicineIds,
      singleOverrides: singleOverrides,
      multiOverride: multiOverride,
      allMedicines: [...prescriptionMedicines, ...recentOrderMedicines],
      reminders: reminders,
    );

    final effectiveTimes = effectiveSchedule.times;
    final effectiveDays = effectiveSchedule.days;
    final effectiveFreq = effectiveSchedule.frequency;

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
                sameSchedule:
                    multiOverride != null ||
                    selectedMedicineIds.every(
                      (id) => singleOverrides.containsKey(id),
                    ),
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

    final result = await act.openAdjustBottomSheet(
      context: context,
      selected: [med],
      title: 'Adjust reminder time',
      subtitle: 'Modify reminder times before confirming',
      sameSchedule: true,
      times: schedule.times,
      days: schedule.days,
      frequency: schedule.frequency,
      primaryButtonText: 'Adjust',
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

    final result = await act.openAdjustBottomSheet(
      context: context,
      selected: meds,
      title: 'Adjust reminder time',
      subtitle: 'Modify reminder times for ${meds.length} medications',
      sameSchedule: true,
      times: multiOverride?.times ?? schedule.times,
      days: multiOverride?.days ?? schedule.days,
      frequency: multiOverride?.frequency ?? schedule.frequency,
      primaryButtonText: 'Continue creating',
    );

    if (result == null) return;

    setState(() {
      multiOverride = result;
    });

    act.showToast(context, 'Adjusted for ${meds.length} medications');
  }
}
