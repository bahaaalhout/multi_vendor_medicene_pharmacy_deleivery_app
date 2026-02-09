import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

///----------------------------
/// SEARCH FIELD
///----------------------------

class MyCalendarSearchField extends StatelessWidget {
  final TextEditingController controller;

  const MyCalendarSearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 12.sp, color: AppColors.primaryDarkActive),
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Search events',
        hintStyle: AppTextStyles.reqular14.copyWith(
          color: AppColors.neutralDarker,
        ),
        filled: true,
        fillColor: AppColors.secondaryLight,
        prefixIcon: Padding(
          padding: EdgeInsets.all(15.w),
          child: SizedBox(
            width: 18.w,
            height: 18.w,
            child: SvgPicture.asset("assets/icons/search_icon.svg"),
          ),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.all(15.w),
          child: SizedBox(
            width: 40.w,
            height: 40.w,
            child: SvgPicture.asset("assets/icons/mic_icon.svg"),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE9EDF3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE9EDF3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primaryDark),
        ),
      ),
    );
  }
}
