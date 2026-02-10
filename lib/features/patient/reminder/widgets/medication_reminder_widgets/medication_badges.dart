import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

//small border badge (type/strength/form)
class MedicationBadge extends StatelessWidget {
  final String text;
  const MedicationBadge({super.key, required this.text});

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

//reminder info badges group (dose/schedule/frequency)
class ReminderInfoBadges extends StatelessWidget {
  final String doseText;
  final String scheduleText;
  final String frequencyText;

  const ReminderInfoBadges({
    super.key,
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

//single info badge
class _InfoBadge extends StatelessWidget {
  final String text;
  const _InfoBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5FF), //background light like figma
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: AppTextStyles.medium8.copyWith(color: AppColors.secondaryDarker),
      ),
    );
  }
}
