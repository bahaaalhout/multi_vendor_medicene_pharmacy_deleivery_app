import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

///----------------------------
/// TITLE ROW
///----------------------------

class MyCalendarTitleRow extends StatelessWidget {
  final String title;
  final bool expanded;
  final VoidCallback onToggle;

  const MyCalendarTitleRow({
    super.key,
    required this.title,
    required this.expanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //card title
        Text(
          title,
          style: AppTextStyles.bold20.copyWith(color: AppColors.primaryNormal),
        ),
        const Spacer(),

        //toggle icon (tap to collapse/expand)
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(999.r),
          child: Container(
            width: 40.w,
            height: 40.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999.r),
              color: AppColors.primaryNormal,
            ),
            child: AnimatedRotation(
              //expanded => arrow up, collapsed => arrow down
              turns: expanded ? 0.0 : 0.5,
              duration: const Duration(milliseconds: 260),
              child: SvgPicture.asset(
                "assets/icons/arrow_up_icon.svg",
                // ignore: deprecated_member_use
                color: AppColors.primaryLight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
