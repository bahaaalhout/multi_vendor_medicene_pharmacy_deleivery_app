import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String value;
  final TextInputType? keyboardType;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.value,
    this.keyboardType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.neutralLightActive,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.neutralLight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.semiBold10.copyWith(
              color: AppColors.neutralDark,
            ),
          ),
          16.verticalSpace,
          TextField(
            controller: TextEditingController(text: value)
              ..selection = TextSelection.collapsed(offset: value.length),
            keyboardType: keyboardType,
            style: AppTextStyles.semiBold14.copyWith(
              color: AppColors.primaryDarker,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: true,
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
