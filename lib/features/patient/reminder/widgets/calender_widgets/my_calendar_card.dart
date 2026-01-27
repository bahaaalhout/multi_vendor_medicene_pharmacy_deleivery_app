import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'calendar_day_cell.dart';

class MyCalendarCard extends StatelessWidget {
  final String title;
  final TextEditingController searchController;
  final DateTime currentMonth;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSelectDate;

  const MyCalendarCard({
    super.key,
    required this.title,
    required this.searchController,
    required this.currentMonth,
    required this.selectedDate,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    final days = _buildMonthDays(currentMonth);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.secondaryLightActive),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: AppTextStyles.bold20.copyWith(
                  color: AppColors.primaryNormal,
                ),
              ),
              const Spacer(),
              Container(
                width: 40.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999.r),
                  color: AppColors.primaryNormal,
                ),
                child: SvgPicture.asset(
                  "assets/icons/arrow_up_icon.svg",
                  color: AppColors.primaryLight,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          _SearchField(controller: searchController),

          SizedBox(height: 16.h),

          _WeekHeader(),

          SizedBox(height: 8.h),

          GridView.builder(
            itemCount: days.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8.h,
              crossAxisSpacing: 8.w,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, i) {
              final d = days[i];
              final isInMonth = d.month == currentMonth.month;
              final isSelected = _isSameDay(d, selectedDate);

              return CalendarDayCell(
                date: d,
                isInMonth: isInMonth,
                isSelected: isSelected,
                onTap: () => onSelectDate(d),
              );
            },
          ),
        ],
      ),
    );
  }

  List<DateTime> _buildMonthDays(DateTime month) {
    final first = DateTime(month.year, month.month, 1);
    final last = DateTime(month.year, month.month + 1, 0);

    // monday-based
    final startOffset = (first.weekday - DateTime.monday) % 7;
    final start = first.subtract(Duration(days: startOffset));

    // build 6 weeks (42 cells) to look like figma
    return List.generate(42, (i) => start.add(Duration(days: i)))
        .where((d) => d.isBefore(last.add(const Duration(days: 14))))
        .take(42)
        .toList();
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;

  const _SearchField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 12.sp, color: AppColors.primaryDarkActive),
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Search events',
        hintStyle: AppTextStyles.reqular14.copyWith(
          color: AppColors.neutralDarker,
        ),
        filled: true,
        fillColor: AppColors.secondaryLight,
        prefixIcon: SvgPicture.asset(
          "assets/icons/search_icon.svg",
          height: 24.w,
          width: 24.w,
        ),
        suffixIcon: SvgPicture.asset("assets/icons/mic_icon.svg", height: 16.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE9EDF3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE9EDF3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primaryDark),
        ),
      ),
    );
  }
}

class _WeekHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labels = const ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Row(
      children: labels
          .map(
            (t) => Expanded(
              child: Center(
                child: Text(
                  t,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryNormal,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
