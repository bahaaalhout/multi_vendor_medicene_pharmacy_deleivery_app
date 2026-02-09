import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

import 'selected_medication_chip.dart';

class SelectedMedicationInfoRowWithAdjust extends StatelessWidget {
  final String label;
  final String iconPath;
  final List<String> chips;
  final VoidCallback onAdjust;
  final bool disabled;

  const SelectedMedicationInfoRowWithAdjust({
    super.key,
    required this.label,
    required this.iconPath,
    required this.chips,
    required this.onAdjust,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.w,
          child: Row(
            children: [
              SvgPicture.asset(iconPath, width: 18.w, height: 18.w),
              SizedBox(width: 4.w),
              Text(
                label,
                style: AppTextStyles.medium10.copyWith(
                  color: AppColors.secondaryDarker,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 4.w,
                  runSpacing: 4.h,
                  children: chips
                      .map((t) => SelectedMedicationChip(text: t))
                      .toList(),
                ),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: disabled ? null : onAdjust,
                child: Icon(
                  Icons.edit_outlined,
                  size: 18.w,
                  color: disabled
                      ? AppColors.neutralDark
                      : AppColors.primaryNormal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
