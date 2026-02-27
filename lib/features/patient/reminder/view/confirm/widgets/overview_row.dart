import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/features/patient/reminder/shared_widgets/main_frame.dart';

class OverviewRow extends StatelessWidget {
  final String iconAsset;
  final String title;
  final List<TextSpan> valueSpans;
  final String sub;

  const OverviewRow({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.valueSpans,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 12.w,
              height: 12.w,
              child: SvgPicture.asset(
                iconAsset,
                color: AppColors.primaryNormal,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.medium12.copyWith(
                  color: AppColors.primaryDarker,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 329.w,
          child: MainFrame(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(text: TextSpan(children: valueSpans)),
                SizedBox(height: 6.h),
                Text(
                  sub,
                  style: AppTextStyles.reqular10.copyWith(
                    color: AppColors.primaryDarkActive,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}