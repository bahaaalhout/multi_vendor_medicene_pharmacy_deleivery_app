import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class AgreeToThePersonalData extends StatelessWidget {
  const AgreeToThePersonalData({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: true, onChanged: (isChecked) {}),
        Text(
          'I agree to the processing of',
          style: AppTextStyles.reqular12.copyWith(color: AppColors.neutralDark),
        ),
        6.horizontalSpace,
        Text(
          'Personal Data',
          style: AppTextStyles.semiBold12.copyWith(
            color: AppColors.primaryNormal,
          ),
        ),
      ],
    );
  }
}
