import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class StyledText extends StatelessWidget {
  const StyledText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.bold20.copyWith(
        color: AppColors.primaryDarker,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
