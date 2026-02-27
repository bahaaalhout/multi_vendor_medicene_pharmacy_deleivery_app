import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.isSecured = false,
    required this.onChanged,
  });
  final String title;
  final String hintText;
  final bool isSecured;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.medium16.copyWith(
            color: AppColors.primaryDarkActive,
          ),
        ),
        8.verticalSpace,
        TextFormField(
          onChanged: onChanged,
          obscureText: isSecured,
          decoration: InputDecoration(
            suffixIcon: isSecured ? Icon(Icons.visibility) : null,
            hintText: hintText,
            hintStyle: AppTextStyles.reqular14.copyWith(
              color: AppColors.neutralNormalActive,
            ),
            contentPadding: EdgeInsets.all(16.r),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(color: AppColors.neutralNormal, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(color: AppColors.neutralNormal, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(color: AppColors.neutralNormal, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
