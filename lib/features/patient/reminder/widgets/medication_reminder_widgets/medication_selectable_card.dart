import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/medication_reminder_widgets/medication_badges.dart';
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
            _HeaderRow(medicine: medicine, badgeText: badgeText),

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
                    : _SetReminderButton(onTap: onSetReminder),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//header row: image + title + badges
class _HeaderRow extends StatelessWidget {
  final MedicineModel medicine;
  final String? badgeText;

  const _HeaderRow({required this.medicine, required this.badgeText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100.w,
          height: 100.w,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.secondaryLight,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Image.network(
            medicine.imageUrls.first,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Icon(Icons.medication_outlined),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicine.brandName,
                style: AppTextStyles.semiBold16.copyWith(color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                medicine.genericName,
                style: AppTextStyles.reqular12.copyWith(
                  color: AppColors.primaryDarkActive,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10.h),

              //3 badges (type/strength/form)
              Wrap(
                spacing: 4.w,
                children: [
                  if (badgeText != null) MedicationBadge(text: badgeText!),
                  MedicationBadge(text: medicine.strength),
                  MedicationBadge(text: _formLabel(medicine.form)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  //convert enum to label
  String _formLabel(FormType form) {
    switch (form) {
      case FormType.tablet:
        return 'Tablet';
      case FormType.syrup:
        return 'Syrup';
      case FormType.capsule:
        return 'Capsule';
      case FormType.injection:
        return 'Injection';
      case FormType.cream:
        return 'Cream';
      case FormType.ointment:
        return 'Ointment';
    }
  }
}

//set reminder button
class _SetReminderButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SetReminderButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.primaryNormal,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Set reminder',
                style: AppTextStyles.semiBold12.copyWith(
                  color: AppColors.primaryLight,
                ),
              ),
              SizedBox(width: 12.w),
              SvgPicture.asset("assets/icons/add_reminder_icon.svg"),
            ],
          ),
        ),
      ),
    );
  }
}
