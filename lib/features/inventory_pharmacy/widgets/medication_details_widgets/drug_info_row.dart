import 'package:flutter/material.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/constants/app_colors.dart';
import 'package:multi_vendor_medicene_pharmacy_deleivery_app/core/theme/app_theme.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.neutralDarkActive,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: AppTextStyles.semiBold14.copyWith(
                color: AppColors.neutralDarkActive,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
