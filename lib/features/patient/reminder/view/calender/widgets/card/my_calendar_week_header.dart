import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class MyCalendarWeekHeader extends StatelessWidget {
  const MyCalendarWeekHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Monday-based to match the month grid generation.
    const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Row(
      children: labels
          .map(
            (t) => Expanded(
              child: Center(
                child: Text(
                  t,
                  style: AppTextStyles.medium16.copyWith(
                    color: AppColors.primaryDarker,
                  ),
                ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}