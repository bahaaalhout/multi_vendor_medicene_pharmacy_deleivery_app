import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "• ",
            style: TextStyle(
              color: AppColors.neutralDarkActive,
              fontSize: 14.sp,
            ),
          ),
          8.horizontalSpace,
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.medium12.copyWith(
                color: AppColors.neutralDarkActive,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
