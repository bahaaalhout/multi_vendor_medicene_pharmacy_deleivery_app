import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

class DayItem {
  final String weekLetter; // S M T W T F S
  final int dayNumber;

  DayItem({required this.weekLetter, required this.dayNumber});
}

class ReminderDayStrip extends StatelessWidget {
  final List<DayItem> days;
  final int selectedDay;
  final ValueChanged<int> onSelectDay;

  const ReminderDayStrip({
    super.key,
    required this.days,
    required this.selectedDay,
    required this.onSelectDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: days.map((d) {
          final isSelected = d.dayNumber == selectedDay;

          return InkWell(
            onTap: () => onSelectDay(d.dayNumber),
            borderRadius: BorderRadius.circular(4.r),
            child: SizedBox(
              width: 51.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    d.weekLetter,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isSelected
                          ? AppColors.primaryDarker
                          : AppColors.primaryLightActive,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: 30.w,
                    height: 20.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryDarker
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      '${d.dayNumber}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isSelected
                            ? AppColors.primaryLight
                            : AppColors.primaryNormal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 3.h,
                    width: 16.w,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color.fromRGBO(0, 0, 0, 1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
