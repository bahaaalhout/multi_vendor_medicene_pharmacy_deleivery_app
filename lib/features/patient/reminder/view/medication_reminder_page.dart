import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/medicine_selection_helpers.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_list_section.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_reminder_header.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_reminder_tabs.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/selected_medication_section.dart';

class MedicationReminderPage extends StatefulWidget {
  const MedicationReminderPage({super.key});

  @override
  State<MedicationReminderPage> createState() => _MedicationReminderPageState();
}

class _MedicationReminderPageState extends State<MedicationReminderPage> {
  //1) active tab
  MedicationReminderTab tab = MedicationReminderTab.prescriptions;

  //2) selected medicines ids (multi-select)
  final Set<String> selectedMedicineIds = {};

  @override
  Widget build(BuildContext context) {
    //load list based on tab
    final items = _getItemsByTab(tab);

    //get selected medicines (keep selected even when switching tabs)
    final selectedMedicines = getSelectedMedicinesFromTwoLists(
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
            _MainFrame(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //1) header
                  const MedicationReminderHeader(),
                  SizedBox(height: 25.h),

                  //2) tabs
                  MedicationReminderTabs(
                    selected: tab,
                    prescriptionsCount: prescriptionMedicines.length,
                    onChanged: _onTabChanged,
                  ),
                  SizedBox(height: 12.h),

                  //3) list section (card tap toggle / set reminder add)
                  MedicationListSection(
                    items: items,
                    selectedIds: selectedMedicineIds,
                    onToggleSelect: _toggleSelectMedicine,
                    onSetReminder: _addToSelected,
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),

            //4) selected block (show only if there is selection)
            if (selectedMedicines.isNotEmpty) ...[
              SizedBox(height: 16.h),
              SelectedMedicationsSection(
                medicines: selectedMedicines,
                onRemoveMedicine: (id) =>
                    setState(() => selectedMedicineIds.remove(id)),
                onClearAll: () => setState(() => selectedMedicineIds.clear()),
                onCreateReminders: _createRemindersForSelected,
                onAdjustReminder: () => _showToast('Adjust reminder tapped'),
              ),
              SizedBox(height: 24.h),
            ],
          ],
        ),
      ),
    );
  }

  //get list based on active tab
  List<MedicineModel> _getItemsByTab(MedicationReminderTab tab) {
    return (tab == MedicationReminderTab.prescriptions)
        ? prescriptionMedicines
        : recentOrderMedicines;
  }

  //when user change tab -> keep selection (do not clear)
  void _onTabChanged(MedicationReminderTab v) {
    setState(() {
      tab = v;
    });
  }

  //when user tap on card -> toggle selection
  void _toggleSelectMedicine(String id) {
    setState(() => toggleSelectedId(selectedMedicineIds, id));
  }

  //when user click set reminder -> add to selected list
  void _addToSelected(MedicineModel medicine) {
    setState(() => selectedMedicineIds.add(medicine.id));
    _showToast('Added: ${medicine.brandName}');
  }

  //when user click create reminder -> create for all selected
  void _createRemindersForSelected(List<MedicineModel> meds) {
    for (final m in meds) {
      //createReminderForMedicine(m);
    }
    _showToast('Created ${meds.length} reminder(s)');
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

//outer frame container (same style you use)
class _MainFrame extends StatelessWidget {
  final Widget child;
  const _MainFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.neutralLightActive, width: 1),
      ),
      child: child,
    );
  }
}
