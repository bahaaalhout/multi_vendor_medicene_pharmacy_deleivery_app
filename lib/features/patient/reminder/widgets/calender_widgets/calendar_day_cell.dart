import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class CalendarDayCell extends StatelessWidget {
  final DateTime date;
  final bool isInMonth;
  final bool isSelected;
  final VoidCallback onTap;

  const CalendarDayCell({
    super.key,
    required this.date,
    required this.isInMonth,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = !isInMonth
        ? AppColors.neutralDarker
        : (isSelected
              ? Color.fromRGBO(255, 255, 255, 1)
              : AppColors.primaryNormal);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32.r),
      child: Container(
        width: 47.w,
        height: 40.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryNormal : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Text(
          '${date.day}',
          style: isSelected
              ? AppTextStyles.semiBold16.copyWith(color: textColor)
              : AppTextStyles.medium16.copyWith(color: textColor),
        ),
      ),
    );
  }
}
