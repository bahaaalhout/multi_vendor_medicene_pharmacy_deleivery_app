import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

enum CalendarHeaderMode { month, week, day }

class CalendarUnifiedHeader extends StatelessWidget {
  final CalendarHeaderMode mode;

  /// مثال:
  /// - Month: "January 2026"
  /// - Week/Day: "January 2026" (أو أي عنوان بدك)
  final String title;

  /// مثال للويك/داي:
  /// "Sat · 31 Jan 2026"
  final String? subtitle;

  /// "2 Reminders"
  final String remindersCountText;

  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onToday;

  const CalendarUnifiedHeader({
    super.key,
    required this.mode,
    required this.title,
    required this.remindersCountText,
    required this.onPrev,
    required this.onNext,
    required this.onToday,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // top row: title + Today + arrows
        Row(
          children: [
            Text(
              title,
              style: AppTextStyles.semiBold16.copyWith(
                color: AppColors.neutralDarkActive,
              ),
            ),
            SizedBox(width: 10.w),

            _TodayPill(onTap: onToday),

            const Spacer(),

            _CircleArrow(icon: Icons.chevron_left, onTap: onPrev),
            SizedBox(width: 10.w),
            _CircleArrow(icon: Icons.chevron_right, onTap: onNext),
          ],
        ),

        // optional subtitle (week/day)
        if (subtitle != null) ...[
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              subtitle!,
              style: AppTextStyles.medium12.copyWith(
                color: AppColors.neutralDarkHover,
              ),
            ),
          ),
        ],

        SizedBox(height: 12.h),

        // second row: left small day label (optional) + count on right
        Row(
          children: [
            // لو بدك تترك اليسار فاضي بالـ Month:
            if (mode == CalendarHeaderMode.month)
              Text('', style: AppTextStyles.medium12)
            else
              Text(' ', style: AppTextStyles.medium12),

            const Spacer(),

            Text(
              remindersCountText,
              style: AppTextStyles.medium12.copyWith(
                color: AppColors.primaryNormal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _TodayPill extends StatelessWidget {
  final VoidCallback onTap;
  const _TodayPill({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.secondaryLight,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          'Today',
          style: AppTextStyles.medium12.copyWith(
            color: AppColors.neutralDarker,
          ),
        ),
      ),
    );
  }
}

class _CircleArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleArrow({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999.r),
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.neutralLightActive, width: 1),
        ),
        child: Icon(icon, color: AppColors.neutralDarkActive),
      ),
    );
  }
}
