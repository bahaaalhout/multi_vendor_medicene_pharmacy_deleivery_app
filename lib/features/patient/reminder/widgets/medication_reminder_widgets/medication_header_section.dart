import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

/// header text above tabs (matches figma)
class MedicationHeaderSection extends StatelessWidget {
  const MedicationHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Choose a medication to activate reminders',
      style: AppTextStyles.medium14.copyWith(
        color: AppColors.neutralDarkActive,
      ),
    );
  }
}
