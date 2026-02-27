import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/circle_icon_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_formatters.dart';

class MyCalendarMonthHeader extends StatelessWidget {
  final DateTime month;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const MyCalendarMonthHeader({
    super.key,
    required this.month,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final label = monthYearLabel(month);

    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          CircleIconButton(
            assetIcon: "assets/icons/arrow_left.svg",
            onPressed: onPrev,
          ),
          Expanded(
            child: Center(
              child: Text(
                label,
                style: AppTextStyles.semiBold16.copyWith(
                  color: AppColors.primaryNormal,
                ),
              ),
            ),
          ),
          CircleIconButton(
            assetIcon: "assets/icons/arrow_right.svg",
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}