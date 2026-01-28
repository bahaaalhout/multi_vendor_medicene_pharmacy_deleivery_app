import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_primary_app_bar.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/data/fake_data.dart';

class MedicationReminderPage extends StatefulWidget {
  const MedicationReminderPage({super.key});

  @override
  State<MedicationReminderPage> createState() => _MedicationReminderPageState();
}

class _MedicationReminderPageState extends State<MedicationReminderPage> {
  AddReminderTab tab = AddReminderTab.prescriptions;

  /// selected medicine id
  String? selectedMedicineId;

  @override
  Widget build(BuildContext context) {
    final items = _currentItems(tab);
    final selectedMedicine = _findSelected(items);

    return Scaffold(
      appBar: const AppPrimaryAppBar(title: 'Medication Reminder'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///----------------------------
            /// HEADER TEXT
            ///----------------------------
            Text(
              'Choose a medication to activate reminders',
              style: AppTextStyles.reqular14.copyWith(
                color: AppColors.neutralDarker,
              ),
            ),

            SizedBox(height: 12.h),

            ///----------------------------
            /// TABS
            ///----------------------------
            _AddReminderTabs(
              selected: tab,
              prescriptionsCount: prescriptionMedicines.length,
              onChanged: (v) => setState(() {
                tab = v;
                selectedMedicineId = null; //reset selection when switch
              }),
            ),

            SizedBox(height: 16.h),

            ///----------------------------
            /// LIST
            ///----------------------------
            _MedSelectableList(
              items: items,
              selectedId: selectedMedicineId,
              badgeText: _badgeLabel(tab),
              onSelect: (id) => setState(() => selectedMedicineId = id),
              onSetReminder: (medicine) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Set reminder for: ${medicine.brandName}'),
                  ),
                );
              },
            ),

            SizedBox(height: 16.h),

            ///----------------------------
            /// SELECTED MED SECTION
            ///----------------------------
            if (selectedMedicine != null) ...[
              _SelectedMedicationCard(
                medicine: selectedMedicine,
                onCreate: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Create reminder for: ${selectedMedicine.brandName}',
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24.h),
            ],
          ],
        ),
      ),
    );
  }

  ///----------------------------
  /// HELPERS
  ///----------------------------

  List<MedicineModel> _currentItems(AddReminderTab t) {
    return t == AddReminderTab.prescriptions
        ? prescriptionMedicines
        : recentOrderMedicines;
  }

  MedicineModel? _findSelected(List<MedicineModel> items) {
    if (selectedMedicineId == null) return null;
    return items
        .where((m) => m.id == selectedMedicineId)
        .cast<MedicineModel?>()
        .first;
  }

  String _badgeLabel(AddReminderTab t) {
    return t == AddReminderTab.prescriptions ? 'Prescription' : 'Ordered';
  }
}

///----------------------------
/// TABS WIDGET
///----------------------------

enum AddReminderTab { prescriptions, recent }

class _AddReminderTabs extends StatelessWidget {
  final AddReminderTab selected;
  final int prescriptionsCount;
  final ValueChanged<AddReminderTab> onChanged;

  const _AddReminderTabs({
    required this.selected,
    required this.prescriptionsCount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppColors.secondaryLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabChip(
              text: 'Prescriptions ($prescriptionsCount active)',
              isSelected: selected == AddReminderTab.prescriptions,
              onTap: () => onChanged(AddReminderTab.prescriptions),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _TabChip(
              text: 'Frequently ordered',
              isSelected: selected == AddReminderTab.recent,
              onTap: () => onChanged(AddReminderTab.recent),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabChip({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: isSelected
              ? Border.all(color: AppColors.secondaryLightActive)
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.medium12.copyWith(
              color: isSelected
                  ? AppColors.primaryNormal
                  : AppColors.neutralDarker,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

///----------------------------
/// LIST (shared)
///----------------------------

class _MedSelectableList extends StatelessWidget {
  final List<MedicineModel> items;
  final String? selectedId;
  final String badgeText;
  final ValueChanged<String> onSelect;
  final ValueChanged<MedicineModel> onSetReminder;

  const _MedSelectableList({
    required this.items,
    required this.selectedId,
    required this.badgeText,
    required this.onSelect,
    required this.onSetReminder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((medicine) {
        final isSelected = medicine.id == selectedId;

        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: _MedicationCard(
            medicine: medicine,
            badgeText: badgeText,
            isSelected: isSelected,
            onTap: () => onSelect(medicine.id),
            onSetReminder: () => onSetReminder(medicine),
          ),
        );
      }).toList(),
    );
  }
}

class _MedicationCard extends StatelessWidget {
  final MedicineModel medicine;
  final String badgeText;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onSetReminder;

  const _MedicationCard({
    required this.medicine,
    required this.badgeText,
    required this.isSelected,
    required this.onTap,
    required this.onSetReminder,
  });

  @override
  Widget build(BuildContext context) {
    final title = medicine.brandName;
    final subTitle = '${medicine.genericName} • ${medicine.strength}';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryNormal
                : AppColors.secondaryLightActive,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.06),
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            ///----------------------------
            /// LEFT IMAGE
            ///----------------------------
            Container(
              width: 54.w,
              height: 54.w,
              decoration: BoxDecoration(
                color: AppColors.secondaryLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(Icons.medication_outlined),
            ),

            SizedBox(width: 12.w),

            ///----------------------------
            /// TEXT
            ///----------------------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.semiBold16.copyWith(
                      color: AppColors.primaryDarker,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subTitle,
                    style: AppTextStyles.reqular12.copyWith(
                      color: AppColors.neutralDarker,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),

                  /// badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryLight,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Text(
                      badgeText,
                      style: AppTextStyles.medium12.copyWith(
                        color: AppColors.primaryNormal,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 10.w),

            ///----------------------------
            /// RIGHT ACTION
            ///----------------------------
            if (isSelected)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7ED),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 6.w),
                    Text(
                      'Selected',
                      style: AppTextStyles.medium12.copyWith(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              )
            else
              SizedBox(
                height: 36.h,
                child: ElevatedButton(
                  onPressed: onSetReminder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNormal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Set reminder',
                    style: AppTextStyles.medium12.copyWith(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

///----------------------------
/// SELECTED CARD
///----------------------------

class _SelectedMedicationCard extends StatelessWidget {
  final MedicineModel medicine;
  final VoidCallback onCreate;

  const _SelectedMedicationCard({
    required this.medicine,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.secondaryLightActive),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected medication',
            style: AppTextStyles.medium12.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
          SizedBox(height: 10.h),

          Text(
            medicine.brandName,
            style: AppTextStyles.semiBold16.copyWith(
              color: AppColors.primaryDarker,
            ),
          ),

          SizedBox(height: 14.h),

          SizedBox(
            width: double.infinity,
            height: 46.h,
            child: ElevatedButton(
              onPressed: onCreate,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryNormal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Create Reminder',
                style: AppTextStyles.medium16.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
