import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/widgets/app_buttons/app_bar_buttons/circle_icon_button.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/helpers/calendar_helpers.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/widgets/calender_widgets/primary_wide_button.dart';
import 'calendar_day_cell.dart';

class MyCalendarCard extends StatelessWidget {
  final String title;
  final TextEditingController searchController;

  //current visible month (yyyy-mm-01)
  final DateTime currentMonth;

  //selected day (yyyy-mm-dd)
  final DateTime selectedDate;

  //when user select a day from grid
  final ValueChanged<DateTime> onSelectDate;

  //when user change month only (prev/next)
  final ValueChanged<DateTime> onChangeMonth;

  const MyCalendarCard({
    super.key,
    required this.title,
    required this.searchController,
    required this.currentMonth,
    required this.selectedDate,
    required this.onSelectDate,
    required this.onChangeMonth,
  });

  @override
  Widget build(BuildContext context) {
    //build 42 cells to match figma
    final days = buildCalendarDays(currentMonth);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.secondaryLightActive),
        boxShadow: const [
          BoxShadow(
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
          _TitleRow(title: title),

          SizedBox(height: 16.h),

          _SearchField(controller: searchController),

          SizedBox(height: 16.h),

          _MonthHeader(
            month: currentMonth,
            onPrev: () => onChangeMonth(prevMonthStart(currentMonth)),
            onNext: () => onChangeMonth(nextMonthStart(currentMonth)),
          ),

          SizedBox(height: 12.h),

          const _WeekHeader(),

          SizedBox(height: 8.h),

          GridView.builder(
            itemCount: days.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemBuilder: (context, i) {
              final d = days[i];
              final isInMonth = d.month == currentMonth.month;
              final isSelected = isSameCalendarDay(d, selectedDate);

              return CalendarDayCell(
                date: d,
                isInMonth: isInMonth,
                isSelected: isSelected,
                onTap: () => onSelectDate(d),
              );
            },
          ),

          PrimaryWideButton(text: '+ Add new calendar', onTap: () {}),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

///----------------------------
/// TITLE ROW
///----------------------------

class _TitleRow extends StatelessWidget {
  final String title;

  const _TitleRow({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.bold20.copyWith(color: AppColors.primaryNormal),
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
            // ignore: deprecated_member_use
            color: AppColors.primaryLight,
          ),
        ),
      ],
    );
  }
}

///----------------------------
/// SEARCH FIELD
///----------------------------

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
        prefixIcon: Padding(
          padding: EdgeInsets.all(15.w),
          child: SizedBox(
            width: 18.w,
            height: 18.w,
            child: SvgPicture.asset("assets/icons/search_icon.svg"),
          ),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.all(15.w),
          child: SizedBox(
            width: 40.w,
            height: 40.w,
            child: SvgPicture.asset("assets/icons/mic_icon.svg"),
          ),
        ),
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

///----------------------------
/// WEEK HEADER
///----------------------------

class _WeekHeader extends StatelessWidget {
  const _WeekHeader();

  @override
  Widget build(BuildContext context) {
    //monday-based to match buildCalendarDays
    final labels = const ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

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
          .toList(),
    );
  }
}

///----------------------------
/// MONTH HEADER
///----------------------------

class _MonthHeader extends StatelessWidget {
  final DateTime month;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _MonthHeader({
    required this.month,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final label = monthYearLabel(month);

    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          CircleIconButton(
            assetIcon: "assets/icons/arrow_left_icon.svg",
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
            assetIcon: "assets/icons/arrow_right_icon.svg",
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}
