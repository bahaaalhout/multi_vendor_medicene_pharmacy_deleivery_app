import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/models/medicine_model.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class MedicationSelectableCard extends StatelessWidget {
  final MedicineModel medicine;
  final bool isSelected;

  /// Badge 1 (Type): "Prescription" / "Ordered"
  final String? badgeText;

  final VoidCallback onTap;
  final VoidCallback onSetReminder;

  /// Reminder fixed info (later you can make it dynamic)
  final String doseText; // e.g. "Dose: 1 tablet"
  final String scheduleText; // e.g. "Schedule: 3 times/day"
  final String frequencyText; // e.g. "Frequency: Daily"

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
            /// TOP: Image + Text
            Row(
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
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.medication_outlined),
                  ),
                ),

                SizedBox(width: 16.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine.brandName,
                        style: AppTextStyles.semiBold16.copyWith(
                          color: Colors.black,
                        ),
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

                      /// 3 BADGES (Type / Strength / Form)
                      Wrap(
                        spacing: 4.w,
                        children: [
                          if (badgeText != null) _Badge(text: badgeText!),
                          _Badge(text: medicine.strength),
                          _Badge(text: _formLabel(medicine.form)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            /// REMINDER INFO BADGES (Dose / Schedule / Frequency)
            _ReminderInfoBadges(
              doseText: doseText,
              scheduleText: scheduleText,
              frequencyText: frequencyText,
            ),

            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: SizedBox(
                width: double.infinity,
                height: 40.h,
                child: isSelected
                    ? const _SelectedFullWidth()
                    : Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                        child: InkWell(
                          onTap: onSetReminder,
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
                                SvgPicture.asset(
                                  "assets/icons/add_reminder_icon.svg",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

class _Badge extends StatelessWidget {
  final String text;
  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.neutralLightActive, width: 1),
      ),
      child: Text(
        text,
        style: AppTextStyles.medium8.copyWith(color: AppColors.neutralDarker),
      ),
    );
  }
}

class _ReminderInfoBadges extends StatelessWidget {
  final String doseText;
  final String scheduleText;
  final String frequencyText;

  const _ReminderInfoBadges({
    required this.doseText,
    required this.scheduleText,
    required this.frequencyText,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.w,
      children: [
        _InfoBadge(text: doseText),
        _InfoBadge(text: scheduleText),
        _InfoBadge(text: frequencyText),
      ],
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final String text;
  const _InfoBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5FF), // background light like figma
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: AppTextStyles.medium8.copyWith(color: AppColors.secondaryDarker),
      ),
    );
  }
}

class _SelectedFullWidth extends StatelessWidget {
  const _SelectedFullWidth();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/selected_icon.svg"),
          SizedBox(width: 12.w),
          Text(
            'Selected',
            style: AppTextStyles.semiBold12.copyWith(
              color: AppColors.successDarker,
            ),
          ),
        ],
      ),
    );
  }
}
