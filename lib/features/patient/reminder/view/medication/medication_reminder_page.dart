import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/medication_reminder_actions.dart'
    as act;

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/main_frame.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/view/medication/widgets/medication_header_section.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_list_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_reminder_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_section.dart';

class MedicationReminderPage extends StatefulWidget {
  const MedicationReminderPage({super.key});

  @override
  State<MedicationReminderPage> createState() => _MedicationReminderPageState();
}

class _MedicationReminderPageState extends State<MedicationReminderPage> {
  //active tab
  MedicationReminderTab tab = MedicationReminderTab.prescriptions;

  //selected medicines ids (multi-select)
  final Set<String> selectedMedicineIds = {};

  @override
  Widget build(BuildContext context) {
    //load list based on active tab
    final items = act.getItemsByTab(
      tab: tab,
      prescriptions: prescriptionMedicines,
      recents: recentOrderMedicines,
    );

    //get selected medicines (keep selected even when switching tabs)
    final selectedMedicines = act.getSelectedMeds(
      selectedIds: selectedMedicineIds,
      listA: prescriptionMedicines,
      listB: recentOrderMedicines,
    );

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
            //main frame container
            MainFrame(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //header section
                  const MedicationHeaderSection(),
                  SizedBox(height: 25.h),

                  //tabs
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

                  //medications list
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

            //selected block (show only if there is selection)
            if (selectedMedicines.isNotEmpty) ...[
              SizedBox(height: 16.h),

              SelectedMedicationsSection(
                medicines: selectedMedicines,
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
                onAdjustReminder: () =>
                    act.showToast(context, 'Adjust reminder tapped'),
              ),

              SizedBox(height: 24.h),
            ],
          ],
        ),
      ),
    );
  }
}
