import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SecuredOrder extends StatelessWidget {
  const SecuredOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.verified_user, color: AppColors.successDarker),
        8.horizontalSpace,
        Text(
          'Your order is secure',
          style: AppTextStyles.semiBold12.copyWith(
            color: AppColors.successDarker,
          ),
        ),
      ],
    );
  }
}
