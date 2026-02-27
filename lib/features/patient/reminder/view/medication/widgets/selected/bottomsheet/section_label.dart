import 'package:flutter/material.dart';

import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class SectionLabel extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final Color? color;

  const SectionLabel({super.key, required this.title, this.style, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          style ??
          AppTextStyles.medium12.copyWith(
            color: color ?? AppColors.neutralDarkActive,
          ),
    );
  }
}
