import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class NotificationDatePill extends StatelessWidget {
  final DateTime date;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const NotificationDatePill({
    super.key,
    required this.date,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final label =
        'Today · ${date.day}, ${months[date.month - 1]}, ${date.year}';

    return Row(
      children: [
        IconButton(
          onPressed: onPrev,
          icon: SvgPicture.asset(
            'assets/icons/back_icon.svg',
            width: 40.w,
            height: 40.h,
          ),
        ),
        Expanded(
          child: Container(
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.primaryNormal),
            ),
            child: Center(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.semiBold12.copyWith(
                  color: AppColors.primaryNormal,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: onNext,
          icon: Transform.scale(
            scaleX: -1,
            child: SvgPicture.asset(
              'assets/icons/back_icon.svg',
              width: 40.w,
              height: 40.w,
            ),
          ),
        ),
      ],
    );
  }
}
