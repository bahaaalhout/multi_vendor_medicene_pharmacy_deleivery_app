import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class UserTypeWidget extends StatelessWidget {
  const UserTypeWidget({
    super.key,
    required this.userType,
    this.isSelected = false,
  });

  final String userType;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12.r),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryNormal
            : AppColors.neutralLightHover,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        userType,
        style: AppTextStyles.reqular20.copyWith(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
