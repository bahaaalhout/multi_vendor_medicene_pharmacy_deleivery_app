import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class AddInstraction extends StatelessWidget {
  final String hint;
  final VoidCallback onTap;

  const AddInstraction({super.key, required this.hint, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.neutralLightActive, width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hint,
              style: AppTextStyles.reqular16.copyWith(
                color: AppColors.neutralDarkActive,
              ),
            ),
            InkWell(
              onTap: onTap,
              child: SvgPicture.asset('assets/icons/plus-small.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
