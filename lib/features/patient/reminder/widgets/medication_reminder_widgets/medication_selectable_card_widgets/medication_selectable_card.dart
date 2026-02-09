import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_badges.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_selectable_card_widgets/selectable_card_header_row.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_selectable_card_widgets/set_reminder_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_selected_button.dart';

class MedicationSelectableCard extends StatelessWidget {
  final MedicineModel medicine;
  final bool isSelected;

  //badge 1 (Type): "Prescription" / "Ordered"
  final String? badgeText;

  final VoidCallback onTap;
  final VoidCallback onSetReminder;

  //fixed info (later connect with real reminder data)
  final String doseText;
  final String scheduleText;
  final String frequencyText;

  const MedicationSelectableCard({
    super.key,
    required this.medicine,
    required this.isSelected,
    required this.onTap,
    required this.onSetReminder,
    this.badgeText,
    this.doseText = 'Dose: 1 tablet',
    this.scheduleText = 'Schedule: 3 times/day',
    this.frequencyText = 'Frequency: Daily',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //top: image + text
            SelectableCardHeaderRow(medicine: medicine, badgeText: badgeText),

            SizedBox(height: 8.h),

            //reminder info badges
            ReminderInfoBadges(
              doseText: doseText,
              scheduleText: scheduleText,
              frequencyText: frequencyText,
            ),

            SizedBox(height: 16.h),

            //action button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: SizedBox(
                width: double.infinity,
                height: 40.h,
                child: isSelected
                    ? MedicationSelectedButton(onTap: onTap)
                    : SetReminderButton(onTap: onSetReminder),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
