import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReminderChip extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle textStyle;
  final String? icon;

  const ReminderChip({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 23.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            SvgPicture.asset(
              icon!,
              width: 10.w,
              height: 10.w,
              color: textColor,
            ),
            SizedBox(width: 4.w),
          ],
          Text(label, style: textStyle.copyWith(color: textColor)),
        ],
      ),
    );
  }
}
