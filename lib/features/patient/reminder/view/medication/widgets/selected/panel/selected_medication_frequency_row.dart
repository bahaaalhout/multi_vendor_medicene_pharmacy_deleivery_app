import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

import 'selected_medication_chip.dart';

class SelectedMedicationFrequencyRow extends StatelessWidget {
  final String frequency;
  final String hint;

  const SelectedMedicationFrequencyRow({
    super.key,
    required this.frequency,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90.w,
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/alarm_icon.svg",
                width: 18.w,
                height: 18.w,
              ),
              SizedBox(width: 6.w),
              Text(
                "Frequently:",
                style: AppTextStyles.medium10.copyWith(
                  color: AppColors.secondaryDarker,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.w,
            children: [
              SelectedMedicationChip(text: frequency),
              Text(
                '• $hint',
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.reqular10.copyWith(
                  color: AppColors.successDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
