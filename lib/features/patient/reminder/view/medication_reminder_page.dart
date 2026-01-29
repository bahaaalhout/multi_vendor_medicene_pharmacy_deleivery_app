import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';

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
  /// 1) active tab
  MedicationReminderTab tab = MedicationReminderTab.prescriptions;

  /// 2) store selected medicine id (keep it simple)
  String? selectedMedicineId;

  @override
  Widget build(BuildContext context) {
    /// A) load list based on tab
    final items = _getItemsByTab(tab);

    /// B) get selected medicine model (if any)
    final selectedMedicine = _getSelectedMedicine(items, selectedMedicineId);

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
                  /// 1) header
                  const MedicationReminderHeader(),
                  SizedBox(height: 25.h),

                  /// 2) tabs
                  MedicationReminderTabs(
                    selected: tab,
                    prescriptionsCount: prescriptionMedicines.length,
                    onChanged: _onTabChanged,
                  ),
                  SizedBox(height: 12.h),

                  /// 3) list section
                  MedicationListSection(
                    items: items,
                    selectedId: selectedMedicineId,
                    onSelect: _onSelectMedicine,
                    onSetReminder: _onSetReminderPressed,
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),

            /// 4) selected block (figma)
            if (selectedMedicine != null) ...[
              SizedBox(height: 16.h),
              SelectedMedicationSection(
                medicine: selectedMedicine,
                onClearSelection: () =>
                    setState(() => selectedMedicineId = null),
                onAdjustReminder: () => _showToast('Adjust reminder tapped'),
                onCreateReminder: () => _showToast(
                  'Create reminder for: ${selectedMedicine.brandName}',
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ],
        ),
      ),
    );
  }

  /// -----------------------------
  /// logic helpers
  /// -----------------------------

  List<MedicineModel> _getItemsByTab(MedicationReminderTab tab) {
    return (tab == MedicationReminderTab.prescriptions)
        ? prescriptionMedicines
        : recentOrderMedicines;
  }

  MedicineModel? _getSelectedMedicine(List<MedicineModel> items, String? id) {
    if (id == null) return null;

    /// safe search (avoid crash if id not found)
    for (final m in items) {
      if (m.id == id) return m;
    }
    return null;
  }

  /// -----------------------------
  /// ui actions
  /// -----------------------------

  void _onTabChanged(MedicationReminderTab v) {
    setState(() {
      tab = v;
      selectedMedicineId = null; // reset selection when switching tab
    });
  }

  void _onSelectMedicine(String id) {
    setState(() => selectedMedicineId = id);
  }

  void _onSetReminderPressed(MedicineModel medicine) {
    _showToast('Set reminder for: ${medicine.brandName}');
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

/// Outer frame container (same style you use)
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
