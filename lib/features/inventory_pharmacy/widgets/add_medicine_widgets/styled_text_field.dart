import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class StyledTextField extends StatelessWidget {
  const StyledTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.textHint,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
  });
  final TextEditingController controller;
  final String title;
  final String textHint;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.medium16.copyWith(
              color: AppColors.neutralDarker,
            ),
          ),
          8.verticalSpace,
          TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: textHint,
              hintStyle: AppTextStyles.reqular14.copyWith(
                color: AppColors.neutralDark,
              ),

              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 1,
                  color: AppColors.neutralLightActive,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: AppColors.neutralLightActive),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),

                borderSide: BorderSide(
                  color: AppColors.primaryNormal,
                  width: 1.5,
                ),
              ),

              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
