import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'reminder_chip.dart';

class ReminderBadgeGroup extends StatelessWidget {
  final bool isCompleted;
  final String quantityText;
  final String strengthText;
  final int doseCount;
  final String timeText;

  const ReminderBadgeGroup({
    super.key,
    required this.isCompleted,
    required this.quantityText,
    required this.strengthText,
    required this.doseCount,
    required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    final topBackground = const Color.fromRGBO(255, 255, 255, 1);
    final topTextColor = AppColors.neutralDarkHover;

    final bottomBackground = isCompleted
        ? AppColors.primaryLightActive
        : AppColors.primaryDark;
    final bottomTextColor = isCompleted
        ? AppColors.primaryDarkActive
        : Colors.white;

    final List<Widget> doseAndTimeChips = [];

    for (int i = 0; i < doseCount; i++) {
      doseAndTimeChips.add(
        ReminderChip(
          label: '1 tab',
          backgroundColor: bottomBackground,
          textColor: bottomTextColor,
          textStyle: AppTextStyles.medium12,
          icon: 'assets/icons/dose_icon.svg',
        ),
      );
    }

    doseAndTimeChips.add(
      ReminderChip(
        label: timeText,
        backgroundColor: bottomBackground,
        textColor: bottomTextColor,
        textStyle: AppTextStyles.medium12,
        icon: 'assets/icons/time_icon.svg',
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            ReminderChip(
              label: quantityText,
              backgroundColor: topBackground,
              textColor: topTextColor,
              textStyle: isCompleted
                  ? AppTextStyles.medium12
                  : AppTextStyles.medium10,
            ),
            ReminderChip(
              label: strengthText,
              backgroundColor: topBackground,
              textColor: topTextColor,
              textStyle: AppTextStyles.medium12,
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Wrap(spacing: 10.w, runSpacing: 8.h, children: doseAndTimeChips),
      ],
    );
  }
}
