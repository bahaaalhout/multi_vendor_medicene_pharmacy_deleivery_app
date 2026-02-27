import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

enum CalendarViewTab { day, week, month }

class CalendarTabs extends StatelessWidget {
  final CalendarViewTab selected;
  final ValueChanged<CalendarViewTab> onChanged;

  const CalendarTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.secondaryLightActive, width: 1.w),
      ),
      child: Row(
        children: [
          _TabBtn(
            text: 'Day',
            isActive: selected == CalendarViewTab.day,
            onTap: () => onChanged(CalendarViewTab.day),
          ),
          _TabBtn(
            text: 'Week',
            isActive: selected == CalendarViewTab.week,
            onTap: () => onChanged(CalendarViewTab.week),
          ),
          _TabBtn(
            text: 'Month',
            isActive: selected == CalendarViewTab.month,
            onTap: () => onChanged(CalendarViewTab.month),
          ),
        ],
      ),
    );
  }
}

class _TabBtn extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _TabBtn({
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          height: 47.h,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isActive ? AppColors.secondaryLight : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: isActive
                ? AppTextStyles.semiBold12.copyWith(
                    color: AppColors.neutralDarker,
                  )
                : AppTextStyles.medium12.copyWith(
                    color: AppColors.neutralDarker,
                  ),
          ),
        ),
      ),
    );
  }
}
