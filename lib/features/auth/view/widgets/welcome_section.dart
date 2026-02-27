import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class WelcomeAuth extends StatelessWidget {
  const WelcomeAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/auth_logo.png'),
        16.verticalSpace,
        Text(
          'WELCOME TO CUREWAY',
          style: AppTextStyles.semiBold25.copyWith(
            color: AppColors.primaryNormal,
          ),
        ),
        8.verticalSpace,
        Text(
          'Complete step to get started',
          style: AppTextStyles.reqular14.copyWith(
            color: AppColors.primaryNormal,
          ),
        ),
      ],
    );
  }
}
