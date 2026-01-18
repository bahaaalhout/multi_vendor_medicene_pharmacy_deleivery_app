import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';

class AppDateSelector extends StatelessWidget {
  final Widget dateWidget;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const AppDateSelector({
    super.key,
    required this.dateWidget,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
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
            width: 265.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.primaryNormal),
            ),
            child: Center(child: dateWidget),
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
