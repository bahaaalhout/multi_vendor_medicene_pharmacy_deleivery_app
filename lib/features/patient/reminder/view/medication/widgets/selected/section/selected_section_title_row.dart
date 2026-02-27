import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SelectedSectionTitleRow extends StatelessWidget {
  final VoidCallback onClearAll;
  const SelectedSectionTitleRow({super.key, required this.onClearAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Selected medication',
          style: AppTextStyles.medium14.copyWith(
            color: AppColors.neutralDarkActive,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: onClearAll,
          child: Text(
            'Clear',
            style: AppTextStyles.semiBold12.copyWith(
              color: AppColors.primaryNormal,
            ),
          ),
        ),
      ],
    );
  }
}
