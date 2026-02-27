import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class CalendarMonthTopBar extends StatelessWidget {
  final String monthLabel;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;
  final VoidCallback onToday;

  const CalendarMonthTopBar({
    super.key,
    required this.monthLabel,
    required this.onPrev,
    required this.onNext,
    required this.onToday,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Row(
        children: [
          Text(
            monthLabel,
            style: AppTextStyles.bold16.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
          SizedBox(width: 8.h),
          Text(
            "•",
            style: AppTextStyles.bold16.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
          SizedBox(width: 8.h),

          //today button (always visible)
          _PillButton(text: 'Today', onTap: onToday),

          const Spacer(),

          //arrows (show only when callbacks are not null)
          if (onPrev != null) ...[
            _IconCircleBtn(
              iconpath: "assets/icons/arrow_left_icon.svg",
              onTap: onPrev,
            ),
            SizedBox(width: 10.w),
          ],

          if (onNext != null)
            _IconCircleBtn(
              iconpath: "assets/icons/arrow_right_icon.svg",
              onTap: onNext,
            ),
        ],
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _PillButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.secondaryLight,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          text,
          style: AppTextStyles.medium14.copyWith(
            color: AppColors.primaryDarker,
          ),
        ),
      ),
    );
  }
}

class _IconCircleBtn extends StatelessWidget {
  final String iconpath;
  final VoidCallback? onTap;

  const _IconCircleBtn({required this.iconpath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //if null => disabled
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 40.w,
        height: 40.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(999.r)),
        child: SvgPicture.asset(iconpath, color: AppColors.primaryNormal),
      ),
    );
  }
}
