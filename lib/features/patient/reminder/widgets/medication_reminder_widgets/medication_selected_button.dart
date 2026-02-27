import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

//selected full width button (tap again to unselect)
class MedicationSelectedButton extends StatelessWidget {
  final VoidCallback onTap;
  const MedicationSelectedButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.successLight,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/selected_icon.svg"),
            SizedBox(width: 12.w),
            Text(
              'Selected',
              style: AppTextStyles.semiBold12.copyWith(
                color: AppColors.successDarker,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
