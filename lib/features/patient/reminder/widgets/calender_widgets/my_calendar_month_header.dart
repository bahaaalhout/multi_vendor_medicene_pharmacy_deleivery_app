import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/circle_icon_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_helpers.dart';

///----------------------------
/// MONTH HEADER
///----------------------------

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
    //month label
    final label = monthYearLabel(month);

    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          //prev month
          CircleIconButton(
            assetIcon: "assets/icons/arrow_left_icon.svg",
            onPressed: onPrev,
          ),

          //month name
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

          //next month
          CircleIconButton(
            assetIcon: "assets/icons/arrow_right_icon.svg",
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}
